import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

// A simple data model for our documents
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

bool loading = false;
Uint8List? _imageBytes;

class _StaffpanelState extends State<Staffpanel> {
  // Use a list of Document objects for better data management
  final List<Document> _documents = List.generate(
    12,
    (index) => Document(id: index, title: 'Document #${index + 1}'),
  );

  // Function to add a new document

  void _pickImage() async {
    try {
      // Pick an image or PDF as bytes
      final Uint8List? imageBytes = await ImagePickerWeb.getImageAsBytes();
      if (imageBytes != null) {
        setState(() {
          _imageBytes = imageBytes;
          loading = true; // show loader while uploading
        });

        // Prepare multipart HTTP request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://127.0.0.1:8000/documents/upload/'), // your backend endpoint
        );

        request.files.add(
          http.MultipartFile.fromBytes('file', imageBytes,
              filename: 'upload_file'),
        );

        // Add any extra fields (e.g., owner_id)
        request.fields['owner_id'] = '1'; // replace with actual staff/user id

        // Send the request
        var response = await request.send();

        setState(() => loading = false);

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
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
      setState(() => loading = false);
      print('Error picking/uploading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking/uploading file: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  } // Function to delete a document by its ID

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

  // Function to view a document
  void _viewDocument(String title) {
    // A simple dialog to simulate viewing a document
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Viewing Document'),
        content: Text('You are now viewing the contents of "$title".'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close', style: TextStyle(color: Colors.blue[900])),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define the primary theme color for easy reuse
    const Color primaryColor = Color(0xFF0D47A1); // This is Colors.blue[900]

    return Scaffold(
      backgroundColor: Colors.grey[100], // A light background for contrast
      body: Row(
        children: [
          // Section 1: Left-side navigation/description panel
          _buildSidePanel(primaryColor),

          // Section 2: Right-side main UI with the document grid
          _buildMainContent(primaryColor),
        ],
      ),
      // Floating Action Button to add new documents
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        backgroundColor: primaryColor,
        tooltip: 'Add New Document',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Widget for the left-side panel
  Widget _buildSidePanel(Color primaryColor) {
    return Container(
      width: 280, // A fixed width for the side panel
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

  // Helper for creating list tiles in the side panel
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

  // Widget for the main content area (the grid)
  Widget _buildMainContent(Color primaryColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250.0, // Max width of each item
            mainAxisSpacing: 20.0, // Spacing between rows
            crossAxisSpacing: 20.0, // Spacing between columns
            childAspectRatio: 0.85, // Aspect ratio of items
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

// A stateless widget for the document card to keep the code clean
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.article_outlined,
              size: 60,
              color: primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              document.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Clean button for "View"
                IconButton(
                  icon: const Icon(Icons.visibility_outlined),
                  color: primaryColor,
                  tooltip: 'View Document',
                  onPressed: onView,
                ),
                // Clean button for "Delete"
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
