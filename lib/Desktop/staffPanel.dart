import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html; // needed to open files in a new browser tab

// Document data model
class Document {
  // Unique id
  int id;
  // Filename displayed as title
  String title;
  // Owner from backend
  String owner;
  // Uploaded at (raw string from backend)
  String uploadedAt;
  Document(
      {required this.id,
      required this.title,
      required this.owner,
      required this.uploadedAt});
}

class Staffpanel extends StatefulWidget {
  const Staffpanel({super.key});

  @override
  State<Staffpanel> createState() => _StaffpanelState();
}

class _StaffpanelState extends State<Staffpanel> {
  List<Document> _documents = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchDocuments(); // load documents from backend on start
  }

  // Fetch documents from backend
  // Fetch documents from backend
  Future<void> _fetchDocuments() async {
    // Fetch documents list from backend and update UI; print any errors.
    try {
      final uri = Uri.parse('http://127.0.0.1:8000/documents/');
      final response = await http.get(uri);
      print(
          '[GET /documents/] status=${response.statusCode} body=${response.body}');
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
      } else {
        print(
            '[GET /documents/] error status=${response.statusCode} body=${response.body}');
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to fetch documents: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('[GET /documents/] exception=$e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching documents: $e')),
      );
    }
  }

  // Pick and upload a file
  Future<void> _pickAndUploadFile() async {
    final fileBytes = await ImagePickerWeb.getImageAsBytes();
    if (fileBytes == null) return;

    // Ask user for metadata
    String? filename;
    String? owner;

    await showDialog(
      context: context,
      builder: (context) {
        final filenameController = TextEditingController();
        final ownerController = TextEditingController();
        return AlertDialog(
          title: const Text("File Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: filenameController,
                decoration: const InputDecoration(labelText: "File name"),
              ),
              TextField(
                controller: ownerController,
                decoration: const InputDecoration(labelText: "Owner"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                filename = filenameController.text.trim();
                owner = ownerController.text.trim();
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );

    if (filename == null ||
        owner == null ||
        filename!.isEmpty ||
        owner!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Upload cancelled: missing details")),
      );
      return;
    }

    if (!mounted) return;
    setState(() => _loading = true);

    try {
      // Build multipart request for upload
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:8000/documents/upload/'),
      );

      // Ensure filename ends with .pdf for consistent server and browser handling
      if (filename != null && !filename!.toLowerCase().endsWith('.pdf')) {
        print('[UPLOAD INFO] Appending .pdf to filename "$filename"');
        filename = '${filename!}.pdf';
      }

      // Attach file bytes and metadata fields
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          fileBytes,
          filename: filename,
        ),
      );
      request.fields['filename'] = filename!;
      request.fields['owner'] = owner!;

      // Send and convert streamed response to Response to read body
      var streamed = await request.send();
      var response = await http.Response.fromStream(streamed);
      if (!mounted) return;
      setState(() => _loading = false);

      print(
          '[POST /documents/upload/] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("File uploaded successfully!")),
        );
        _fetchDocuments();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Upload failed: ${response.statusCode} ${response.body}")),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
      }
      print('[POST /documents/upload/] exception=$e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading file: $e")),
      );
    }
  }

  // Delete a document both locally and on backend
  Future<void> _deleteDocument(int id) async {
    // Delete a document by id; log details for troubleshooting.
    try {
      final uri = Uri.parse('http://127.0.0.1:8000/documents/$id');
      final response = await http.delete(uri);
      print(
          '[DELETE /documents/{id}] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 204) {
        setState(() {
          _documents.removeWhere((doc) => doc.id == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Document deleted successfully.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Delete failed: ${response.statusCode} ${response.body}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      print('[DELETE /documents/{id}] exception=$e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting document: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _viewDocument(String filename) {
    final url = 'http://127.0.0.1:8000/documents/file/$filename';
    html.window.open(url, '_blank'); // opens file in a new browser tab
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0D47A1);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          _buildSidePanel(primaryColor),
          _buildMainContent(primaryColor),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickAndUploadFile,
        backgroundColor: primaryColor,
        tooltip: 'Add New Document',
        child: _loading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Left side panel
  Widget _buildSidePanel(Color primaryColor) {
    return Container(
      width: 280,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.dashboard_customize, color: primaryColor, size: 32),
                const SizedBox(width: 12),
                Text(
                  'Staff Portal',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Manage your documents efficiently and securely. Use the panel on the right to view and manage all available files.',
              style:
                  TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
            ),
            const SizedBox(height: 30),
            _buildInfoTile(
              icon: Icons.add_circle_outline,
              title: 'Add Documents',
              subtitle: 'Use the \'+\' button to add a new file.',
              color: primaryColor,
            ),
            const SizedBox(height: 20),
            _buildInfoTile(
              icon: Icons.visibility_outlined,
              title: 'View Documents',
              subtitle: 'Click the view icon on any document.',
              color: primaryColor,
            ),
            const SizedBox(height: 20),
            _buildInfoTile(
              icon: Icons.delete_sweep_outlined,
              title: 'Delete Documents',
              subtitle: 'Remove documents you no longer need.',
              color: primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40.0,
                top: 30,
              ),
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900], // blue shade 900
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  html.window.location.reload();
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Text(
              '© 2025 Document Corp.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(
      {required IconData icon,
      required String title,
      required String subtitle,
      required Color color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        )
      ],
    );
  }

  // Helper: format 'YYYY-MM-DD HH:MM:SS' -> 'DD Mon YYYY'
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
      final day = dt.day.toString().padLeft(2, '0');
      final month = months[dt.month - 1];
      final year = dt.year.toString();
      return '$day $month $year';
    } catch (e) {
      print('[DATE FORMAT ERROR] uploadedAt="$uploadedAt" err=$e');
      return uploadedAt.split(' ').first;
    }
  }

  // Main content (grid)
  Widget _buildMainContent(Color primaryColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _documents.isEmpty
            // Empty state when there are no documents uploaded yet
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.cloud_off_outlined,
                        size: 72, color: Colors.black26),
                    SizedBox(height: 16),
                    Text(
                      'No files uploaded yet',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Upload your first PDF to the Iact servers.',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              )
            // Grid of documents when available
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.85,
                ),
                itemCount: _documents.length,
                itemBuilder: (context, index) {
                  final document = _documents[index];
                  return DocumentCard(
                    document: document,
                    primaryColor: primaryColor,
                    formattedDate: _formatUploadDate(document.uploadedAt),
                    onView: () => _viewDocument(document.title),
                    onDelete: () => _deleteDocument(document.id),
                  );
                },
              ),
      ),
    );
  }
}

// Document Card widget
class DocumentCard extends StatelessWidget {
  final Document document;
  final Color primaryColor;
  final String formattedDate;
  final VoidCallback onView;
  final VoidCallback onDelete;

  const DocumentCard({
    super.key,
    required this.document,
    required this.primaryColor,
    required this.formattedDate,
    required this.onView,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.blue.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.article_outlined, size: 60, color: primaryColor),
            const SizedBox(height: 20),
            Text(
              document.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_outline,
                    size: 16, color: Colors.black54),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    document.owner,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.event_note_outlined,
                    size: 16, color: Colors.black54),
                const SizedBox(width: 6),
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
            const Spacer(),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility_outlined),
                  color: primaryColor,
                  tooltip: 'View Document',
                  onPressed: onView,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.redAccent,
                  tooltip: 'Delete Document',
                  onPressed: onDelete,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
