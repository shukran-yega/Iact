import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:iact/Desktop/Landing_page.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html; // needed to open files in a new browser tab

// Document data model
class Document {
  int id;
  String title;
  Document({required this.id, required this.title});
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
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/documents/'));
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> docsJson = jsonDecode(response.body);

        setState(() {
          _documents = docsJson
              .map((json) => Document(
                    id: json['id'],
                    title: json['filename'], // ✅ use 'filename' from backend
                  ))
              .toList();
        });
      } else {
        print('Failed to fetch documents: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching documents: $e');
    }
  }

  // Pick and upload a file
  void _pickAndUploadFile() async {
    try {
      final Uint8List? fileBytes = await ImagePickerWeb.getImageAsBytes();
      if (fileBytes != null) {
        setState(() => _loading = true);

        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://127.0.0.1:8000/documents/upload/'),
        );

        request.files.add(
          http.MultipartFile.fromBytes('file', fileBytes,
              filename: 'upload_file'),
        );

        request.fields['owner_id'] = '1'; // replace with actual user id

        var response = await request.send();
        setState(() => _loading = false);

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          _fetchDocuments(); // refresh the document grid
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Upload failed: ${response.statusCode}'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    } catch (e) {
      setState(() => _loading = false);
      print('Error picking/uploading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking/uploading file: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // Delete a document locally (you can add backend deletion later)
  void _deleteDocument(int id) {
    setState(() {
      _documents.removeWhere((doc) => doc.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document deleted.'),
        backgroundColor: Colors.redAccent,
      ),
    );
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

  // Main content (grid)
  Widget _buildMainContent(Color primaryColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.builder(
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
  final VoidCallback onView;
  final VoidCallback onDelete;

  const DocumentCard({
    super.key,
    required this.document,
    required this.primaryColor,
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
