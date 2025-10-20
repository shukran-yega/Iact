import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

// Document data model
class Document {
  int id;
  String title;
  String owner;
  String uploadedAt;
  Document({
    required this.id,
    required this.title,
    required this.owner,
    required this.uploadedAt,
  });
}

// Folder data model
class Folder {
  final int id;
  final String name;
  Folder({required this.id, required this.name});
}

// User data model
class User {
  final int id;
  final String staffId;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  User({
    required this.id,
    required this.staffId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
  });
}

class Staffpanel extends StatefulWidget {
  final String firstName;
  final String role;
  final id;
  const Staffpanel(
      {Key? key, required this.firstName, required this.role, required this.id})
      : super(key: key);

  @override
  State<Staffpanel> createState() => _StaffpanelState();
}

class _StaffpanelState extends State<Staffpanel> {
  List<Folder> _folders = [];
  int? _currentFolderId;
  String? _currentFolderName;
  List<Document> _documents = [];
  List<User> _users = [];
  bool _loading = false;
  bool _leftSidebarExpanded = true;
  bool _rightSidebarExpanded = false;
  String _rightSidebarMode =
      'none'; // 'upload', 'users', 'newStaff', 'newFolder'

  @override
  void initState() {
    super.initState();
    _fetchFolders();
  }

  String get _baseUrl {
    final hostname = html.window.location.hostname;

    // Local development
    if (hostname == 'localhost' || hostname == '127.0.0.1') {
      return 'http://127.0.0.1:8000';
    }

    // Production - API is proxied through nginx on same domain
    return html.window.location.origin;
  }

  Future<void> _fetchFolders() async {
    try {
      final uri = Uri.parse("$_baseUrl/folders/?current_user_id=${widget.id}");
      final response = await http.get(uri);

      print(
          '[GET /folders/] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        // Check if response is actually JSON
        if (response.body.trim().startsWith('[') ||
            response.body.trim().startsWith('{')) {
          final List<dynamic> list = jsonDecode(response.body);
          if (!mounted) return;
          setState(() {
            _folders =
                list.map((j) => Folder(id: j['id'], name: j['name'])).toList();
          });
        } else {
          print('[GET /folders/] Response is not JSON: ${response.body}');
          _showSnackBar('Server returned invalid response');
        }
      } else {
        print('[GET /folders/] Error: ${response.statusCode}');
        _showSnackBar('Failed to fetch folders: ${response.statusCode}');
      }
    } catch (e) {
      print('[GET /folders/] exception=$e');
      _showSnackBar('Error fetching folders: $e');
    }
  }

  Future<void> _fetchDocuments({required int folderId}) async {
    try {
      final uri = Uri.parse('$_baseUrl/documents/?folder_id=$folderId');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> docsJson = jsonDecode(response.body);
        if (!mounted) return;
        setState(() {
          _documents = docsJson
              .map((json) => Document(
                    id: json['id'],
                    title: json['filename'],
                    owner: json['owner'] ?? '',
                    uploadedAt: json['uploaded_at'] ?? '',
                  ))
              .toList();
        });
      }
    } catch (e) {
      _showSnackBar('Error fetching documents: $e');
    }
  }

  Future<void> _fetchUsers() async {
    try {
      final uri = Uri.parse('$_baseUrl/users/');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        List<dynamic> usersJson = jsonDecode(response.body);
        if (!mounted) return;
        setState(() {
          _users = usersJson
              .map((u) => User(
                    id: u['id'],
                    staffId: u['staff_id'] ?? '',
                    firstName: u['first_name'],
                    lastName: u['last_name'],
                    email: u['email'] ?? '',
                    role: u['role'] ?? 'N/A',
                  ))
              .toList();
        });
      }
    } catch (e) {
      _showSnackBar('Error fetching users: $e');
    }
  }

  Future<void> _deleteUser(int userId) async {
    try {
      final uri = Uri.parse('$_baseUrl/users/$userId');
      final response = await http.delete(uri);
      if (response.statusCode == 204) {
        setState(() {
          _users.removeWhere((u) => u.id == userId);
        });
        _showSnackBar('User deleted successfully');
      } else {
        _showSnackBar('Failed to delete user');
      }
    } catch (e) {
      _showSnackBar('Error deleting user: $e');
    }
  }

  Future<void> _uploadFile({
    required List<int> fileBytes,
    required String filename,
    required String owner,
  }) async {
    if (_currentFolderId == null) return;

    // Check file size (50MB limit)
    final fileSizeInMB = fileBytes.length / (1024 * 1024);
    if (fileSizeInMB > 50) {
      _showSnackBar('File size exceeds 50MB limit');
      return;
    }

    setState(() => _loading = true);

    try {
      print(
          '[UPLOAD] Starting upload of ${filename} (${fileSizeInMB.toStringAsFixed(2)}MB)');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/documents/upload/'),
      );

      if (!filename.toLowerCase().endsWith('.pdf')) {
        filename = '$filename.pdf';
      }

      request.files.add(
        http.MultipartFile.fromBytes('file', fileBytes, filename: filename),
      );
      request.fields['filename'] = filename;
      request.fields['owner'] = owner;
      request.fields['folder_id'] = _currentFolderId!.toString();

      print('[UPLOAD] Sending request for ${filename}');
      var streamed = await request.send();
      var response = await http.Response.fromStream(streamed);

      print(
          '[UPLOAD] Response status: ${response.statusCode}, body: ${response.body}');

      if (!mounted) return;
      setState(() => _loading = false);

      if (response.statusCode == 200) {
        _showSnackBar('File uploaded successfully!');
        _fetchDocuments(folderId: _currentFolderId!);
        setState(() {
          _rightSidebarExpanded = false;
          _rightSidebarMode = 'none';
        });
      } else if (response.statusCode == 413) {
        _showSnackBar('File too large. Maximum size is 50MB');
      } else {
        _showSnackBar(
            'Upload failed: ${response.statusCode}. ${response.body}');
      }
    } catch (e) {
      print('[UPLOAD ERROR] $e');
      if (mounted) setState(() => _loading = false);
      _showSnackBar('Error uploading file: $e');
    }
  }

  Future<void> _deleteDocument(int id) async {
    try {
      final uri = Uri.parse('$_baseUrl/documents/$id');
      final response = await http.delete(uri);
      if (response.statusCode == 204) {
        setState(() {
          _documents.removeWhere((doc) => doc.id == id);
        });
        _showSnackBar('Document deleted successfully');
      } else {
        _showSnackBar('Delete failed');
      }
    } catch (e) {
      _showSnackBar('Error deleting document: $e');
    }
  }

  void _viewDocument(String filename) {
    final url = '$_baseUrl/documents/file/$filename';
    html.window.open(url, '_blank');
  }

  Future<void> _createFolder(String name) async {
    try {
      final uri = Uri.parse('$_baseUrl/folders/');
      final resp = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name}),
      );
      if (resp.statusCode == 200) {
        _showSnackBar('Folder created');
        _fetchFolders();
        setState(() {
          _rightSidebarExpanded = false;
          _rightSidebarMode = 'none';
        });
      } else {
        _showSnackBar('Failed to create folder');
      }
    } catch (e) {
      _showSnackBar('Error creating folder: $e');
    }
  }

  Future<void> _deleteFolder(int folderId) async {
    try {
      final uri = Uri.parse('$_baseUrl/folders/$folderId');
      final response = await http.delete(uri);
      if (response.statusCode == 204) {
        await _fetchFolders();
        _showSnackBar('Folder deleted');
      } else {
        _showSnackBar('Failed to delete folder');
      }
    } catch (e) {
      _showSnackBar('Error deleting folder: $e');
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  String _formatUploadDate(String uploadedAt) {
    try {
      final datePart = uploadedAt.split(' ').first;
      final dt = DateTime.parse(datePart);
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${dt.day.toString().padLeft(2, '0')} ${months[dt.month - 1]} ${dt.year}';
    } catch (e) {
      return uploadedAt.split(' ').first;
    }
  }

  void _openRightSidebar(String mode) {
    setState(() {
      if (_rightSidebarMode == mode && _rightSidebarExpanded) {
        _rightSidebarExpanded = false;
        _rightSidebarMode = 'none';
      } else {
        _rightSidebarMode = mode;
        _rightSidebarExpanded = true;
        if (mode == 'users') {
          _fetchUsers();
        }
      }
    });
  }

  // access control
  bool get canSeeStaffTools =>
      widget.role == 'Level 1' || widget.role == 'Level 2';
  bool get accesslevel1only => widget.role == 'Level 1';
  // access control

  List<int> selectedFolderIds = []; // folder IDs selected for access

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0D47A1);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // Left Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _leftSidebarExpanded ? 280 : 70,
            color: Colors.white,
            child: _buildLeftSidebar(primaryColor),
          ),
          // Main Content
          Expanded(child: _buildMainContent(primaryColor)),
          // Right Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _rightSidebarExpanded ? 380 : 0,
            child: _rightSidebarExpanded
                ? _buildRightSidebar(primaryColor)
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftSidebar(Color primaryColor) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  _leftSidebarExpanded ? Icons.menu_open : Icons.menu,
                  color: primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _leftSidebarExpanded = !_leftSidebarExpanded;
                  });
                },
              ),
              if (_leftSidebarExpanded) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'iACT Portal',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (_leftSidebarExpanded) const Divider(),

        // User info
        if (_leftSidebarExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome,',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                Text(
                  widget.firstName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.role.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 20),

        // Navigation items
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildNavItem(
                icon: Icons.folder_outlined,
                label: 'Folders',
                isActive: _currentFolderId == null,
                onTap: () {
                  setState(() {
                    _currentFolderId = null;
                    _currentFolderName = null;
                    _documents = [];
                  });
                },
              ),
              Visibility(
                visible: canSeeStaffTools,
                child: _buildNavItem(
                    icon: Icons.upload_file,
                    label: 'Upload Document',
                    isActive: _currentFolderId == 0,
                    onTap: () {
                      _openRightSidebar('upload');
                      _currentFolderId = 0;
                    }),
              ),
              Visibility(
                visible: canSeeStaffTools,
                child: _buildNavItem(
                    icon: Icons.create_new_folder,
                    label: 'New Folder',
                    isActive: _currentFolderId == 1,
                    onTap: () {
                      _openRightSidebar('newFolder');
                      _currentFolderId = 1;
                    }),
              ),
              Visibility(
                visible: accesslevel1only,
                child: _buildNavItem(
                    icon: Icons.person_add,
                    label: 'Add Staff',
                    isActive: _currentFolderId == 2,
                    onTap: () {
                      _openRightSidebar('newStaff');
                      _currentFolderId = 2;
                    }),
              ),
              Visibility(
                visible: accesslevel1only,
                child: _buildNavItem(
                    icon: Icons.supervised_user_circle,
                    label: 'Manage Users/roles',
                    isActive: _currentFolderId == 3,
                    onTap: () {
                      _openRightSidebar('users');
                      _currentFolderId = 3;
                    }),
              ),
            ],
          ),
        ),

        // Logout button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _leftSidebarExpanded
              ? ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => html.window.location.reload(),
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.logout),
                  color: primaryColor,
                  onPressed: () => html.window.location.reload(),
                ),
        ),

        if (_leftSidebarExpanded)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'v1.0.0',
              style: TextStyle(fontSize: 11, color: Colors.grey[400]),
            ),
          ),
      ],
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    const Color primaryColor = Color(0xFF0D47A1);
    final isExpanded = _leftSidebarExpanded;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? primaryColor.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? primaryColor : Colors.grey[700],
          size: 24,
        ),
        title: isExpanded
            ? Text(
                label,
                style: TextStyle(
                  color: isActive ? primaryColor : Colors.grey[700],
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 14,
                ),
              )
            : null,
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: isExpanded ? 16 : 12,
          vertical: 4,
        ),
        dense: true,
      ),
    );
  }

  Widget _buildMainContent(Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          if (_currentFolderId != null)
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _currentFolderId = null;
                      _currentFolderName = null;
                      _documents = [];
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back, size: 20, color: primaryColor),
                        const SizedBox(width: 8),
                        const Text(
                          'Folders',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_currentFolderName != null) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right, size: 20, color: Colors.grey[400]),
                  const SizedBox(width: 8),
                  Text(
                    _currentFolderName!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),

          const SizedBox(height: 16),

          // Content
          Expanded(
            child: _currentFolderId == null
                ? _buildFoldersGrid(primaryColor)
                : _buildDocumentsGrid(primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildFoldersGrid(Color primaryColor) {
    if (_folders.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.folder_off_sharp, size: 72, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text(
              'No accessible folders detected',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 24),
            Visibility(
              visible: canSeeStaffTools,
              child: ElevatedButton.icon(
                onPressed: () => _openRightSidebar('newFolder'),
                icon: const Icon(Icons.add),
                label: const Text('Create Folder'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.2,
      ),
      itemCount: _folders.length,
      itemBuilder: (context, index) {
        final folder = _folders[index];
        return _buildFolderCard(folder, primaryColor);
      },
    );
  }

  Widget _buildFolderCard(Folder folder, Color primaryColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() {
            _currentFolderId = folder.id;
            _currentFolderName = folder.name;
            _documents = [];
          });
          _fetchDocuments(folderId: folder.id);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.folder, size: 36, color: Colors.amber[700]),
                  Visibility(
                    visible: canSeeStaffTools,
                    child: IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.redAccent),
                      onPressed: () => _deleteFolder(folder.id),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                folder.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentsGrid(Color primaryColor) {
    if (_documents.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.description_outlined, size: 72, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text(
              'No documents yet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Upload your first document to this folder',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _openRightSidebar('upload'),
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload Document'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.85,
      ),
      itemCount: _documents.length,
      itemBuilder: (context, index) {
        final document = _documents[index];
        return _buildDocumentCard(document, primaryColor);
      },
    );
  }

  Widget _buildDocumentCard(Document document, Color primaryColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.picture_as_pdf, size: 50, color: Colors.red[400]),
            const SizedBox(height: 12),
            Text(
              document.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person_outline, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    document.owner,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _formatUploadDate(document.uploadedAt),
              style: TextStyle(fontSize: 11, color: Colors.grey[500]),
            ),
            const Spacer(),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility_outlined),
                  color: primaryColor,
                  onPressed: () => _viewDocument(document.title),
                  tooltip: 'View',
                ),
                Visibility(
                  visible: canSeeStaffTools,
                  child: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.redAccent,
                    onPressed: () => _deleteDocument(document.id),
                    tooltip: 'Delete',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightSidebar(Color primaryColor) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _getRightSidebarTitle(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _rightSidebarExpanded = false;
                      _rightSidebarMode = 'none';
                    });
                  },
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: _buildRightSidebarContent(primaryColor),
          ),
        ],
      ),
    );
  }

  String _getRightSidebarTitle() {
    switch (_rightSidebarMode) {
      case 'upload':
        return 'Upload Document';
      case 'users':
        return 'Manage Users';
      case 'newStaff':
        return 'Add New Staff';
      case 'newFolder':
        return 'Create Folder';
      default:
        return '';
    }
  }

  Widget _buildRightSidebarContent(Color primaryColor) {
    switch (_rightSidebarMode) {
      case 'upload':
        return _buildUploadForm(primaryColor);
      case 'users':
        return _buildUsersPanel();
      case 'newStaff':
        return _buildNewStaffForm(primaryColor);
      case 'newFolder':
        return _buildNewFolderForm(primaryColor);
      default:
        return const SizedBox();
    }
  }

  Widget _buildUploadForm(Color primaryColor) {
    if (_currentFolderId == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.folder_open, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'Please open a folder first',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final filenameController = TextEditingController();
    final ownerController = TextEditingController(text: widget.firstName);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Uploading to: $_currentFolderName',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: filenameController,
            decoration: InputDecoration(
              labelText: 'File Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.description),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: ownerController,
            decoration: InputDecoration(
              labelText: 'Owner',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _loading
                  ? null
                  : () async {
                      final filename = filenameController.text.trim();
                      final owner = ownerController.text.trim();

                      if (filename.isEmpty || owner.isEmpty) {
                        _showSnackBar('Please fill in all fields');
                        return;
                      }

                      final fileBytes = await ImagePickerWeb.getImageAsBytes();
                      if (fileBytes == null) return;

                      await _uploadFile(
                        fileBytes: fileBytes,
                        filename: filename,
                        owner: owner,
                      );
                    },
              icon: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.upload_file),
              label: Text(_loading ? 'Uploading...' : 'Select & Upload File'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersPanel() {
    if (_users.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index];
        Color roleColor;
        switch (user.role.toLowerCase()) {
          case 'Level 1':
            roleColor = Colors.blueAccent;
            break;
          case 'Level 2':
            roleColor = Colors.green;
            break;
          default:
            roleColor = Colors.grey;
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: roleColor.withOpacity(0.15),
                      child: Icon(Icons.person, color: roleColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.firstName} ${user.lastName}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'UserID: ' + user.id.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            "Email: " + user.email,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Role dropdown
                        PopupMenuButton<String>(
                          onSelected: (String newRole) async {
                            // ... your role update logic
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                                value: 'Level 1', child: Text('Level 1')),
                            const PopupMenuItem<String>(
                                value: 'Level 2', child: Text('Level 2')),
                            const PopupMenuItem<String>(
                                value: 'Level 3', child: Text('Level 3')),
                          ],
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: roleColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  user.role.toUpperCase(),
                                  style: TextStyle(
                                    color: roleColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(Icons.arrow_drop_down,
                                    color: roleColor, size: 16),
                              ],
                            ),
                          ),
                        ),

                        // Delete button
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.redAccent),
                          onPressed: () => _deleteUser(user.id),
                        ),
                      ],
                    ),

                    // ExpansionTile placed outside the Row

                    ExpansionTile(
                      title: Text('Update Folder Access'),
                      leading: Icon(Icons.folder_open),
                      children: [
                        ..._folders.map((folder) {
                          return StatefulBuilder(
                            builder: (context, setCheckboxState) {
                              bool isChecked =
                                  selectedFolderIds.contains(folder.id);

                              return CheckboxListTile(
                                title: Text(folder.name),
                                value: isChecked,
                                onChanged: (bool? checked) {
                                  setCheckboxState(() {
                                    isChecked = checked ?? false;
                                  });

                                  setState(() {
                                    if (checked == true) {
                                      selectedFolderIds.add(folder.id);
                                    } else {
                                      selectedFolderIds.remove(folder.id);
                                    }
                                  });
                                },
                              );
                            },
                          );
                        }).toList(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                try {
                                  final uri = Uri.parse(
                                      '$_baseUrl/users/${user.id}/access');
                                  final response = await http.patch(
                                    uri,
                                    headers: {
                                      'Content-Type': 'application/json'
                                    },
                                    body: jsonEncode(
                                        {'accessFile': selectedFolderIds}),
                                  );

                                  if (response.statusCode == 200) {
                                    _showSnackBar(
                                        'Access updated successfully');
                                    await _fetchUsers(); // Refresh user list
                                  } else {
                                    _showSnackBar('Failed to update access');
                                  }
                                } catch (e) {
                                  _showSnackBar('Error updating access: $e');
                                }
                              },
                              icon: const Icon(Icons.check),
                              label: const Text('Done'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNewStaffForm(Color primaryColor) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    String selectedRole = 'Level 3';
    String Access = "Full access";

    return StatefulBuilder(
      builder: (context, setFormState) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedRole,
                decoration: InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.work_outline),
                ),
                items: const [
                  DropdownMenuItem(
                      value: 'Level 1',
                      child: Text('level 1 (full privildege)')),
                  DropdownMenuItem(
                      value: 'Level 2',
                      child: Text('level 2 (Create/delete folders/files)')),
                  DropdownMenuItem(
                      value: 'Level 3', child: Text('Level 3 (View only)')),
                ],
                onChanged: (value) {
                  setFormState(() {
                    selectedRole = value!;
                  });
                },
              ),
              // access panel
              SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ExpansionTile(
                  title: Text('Select Folder Access'),
                  leading: Icon(Icons.folder_open),
                  children: _folders.map((folder) {
                    return CheckboxListTile(
                      title: Text(folder.name),
                      value: selectedFolderIds.contains(folder.id),
                      onChanged: (bool? checked) {
                        setFormState(() {
                          if (checked == true) {
                            selectedFolderIds.add(folder.id);
                          } else {
                            selectedFolderIds.remove(folder.id);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final firstName = firstNameController.text.trim();
                    final lastName = lastNameController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (firstName.isEmpty ||
                        lastName.isEmpty ||
                        email.isEmpty ||
                        password.isEmpty) {
                      _showSnackBar('Please fill in all fields');
                      return;
                    }

                    // ✅ New check: Ensure folders are selected for non-Level 1 users
                    if (selectedRole != 'Level 1' &&
                        selectedFolderIds.isEmpty) {
                      _showSnackBar(
                          'Please select at least one folder for this role');
                      return;
                    }

                    try {
                      // Generate a staff_id
                      final staffId = DateTime.now()
                          .millisecondsSinceEpoch
                          .toString()
                          .substring(8);
                      final username =
                          '${firstName.toLowerCase()}.${lastName.toLowerCase()}';

                      final uri = Uri.parse('$_baseUrl/users/');
                      print(
                          '[CREATE USER] Sending request for $firstName $lastName');

                      final response = await http.post(
                        uri,
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode({
                          'staff_id': staffId,
                          'username': username,
                          'password': password,
                          'email': email,
                          'first_name': firstName,
                          'last_name': lastName,
                          'role': selectedRole,
                          'accessFile': selectedRole == 'Level 1'
                              ? []
                              : selectedFolderIds,
                        }),
                      );

                      if (response.statusCode == 200) {
                        _showSnackBar('Staff member added successfully');
                        // Clear the form
                        firstNameController.clear();
                        lastNameController.clear();
                        emailController.clear();
                        passwordController.clear();
                        setState(() {
                          _rightSidebarExpanded = false;
                          _rightSidebarMode = 'none';
                        });
                        // Refresh users list if it's visible
                        if (_rightSidebarMode == 'users') {
                          _fetchUsers();
                        }
                      } else {
                        _showSnackBar(
                            'Failed to add staff member: ${response.statusCode}');
                        print('[CREATE USER ERROR] ${response.body}');
                      }
                    } catch (e) {
                      _showSnackBar('Error creating staff member: $e');
                      print('[CREATE USER ERROR] $e');
                    }
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Add Staff Member'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNewFolderForm(Color primaryColor) {
    final folderNameController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: folderNameController,
            decoration: InputDecoration(
              labelText: 'Folder Name',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              prefixIcon: const Icon(Icons.folder_outlined),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                final name = folderNameController.text.trim();
                if (name.isEmpty) {
                  _showSnackBar('Please enter a folder name');
                  return;
                }
                _createFolder(name);
              },
              icon: const Icon(Icons.create_new_folder),
              label: const Text('Create Folder'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
