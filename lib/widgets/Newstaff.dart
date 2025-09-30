import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html; // for window location (web)

// Show this dialog to add a new staff member
Future<void> showNewStaffDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => const NewStaffDialog(),
  );
}

class NewStaffDialog extends StatefulWidget {
  const NewStaffDialog({super.key});

  @override
  State<NewStaffDialog> createState() => _NewStaffDialogState();
}

class _NewStaffDialogState extends State<NewStaffDialog> {
  // Controllers for form fields
  final TextEditingController _staffIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Role selection state
  String _selectedRole = 'default';

  // Loading state for submit button
  bool _submitting = false;

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Helper to compute base URL for backend
  String get _baseUrl {
    // Use localhost:8000 for local development, fallback to origin for production
    final isLocal = html.window.location.hostname == 'localhost' ||
        html.window.location.hostname == '127.0.0.1';
    return isLocal ? 'http://127.0.0.1:8000' : html.window.location.origin;
  }

  // Submit handler to call POST /users/
  Future<void> _submit() async {
    // Validate form fields first
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Read field values
    final staffId = _staffIdController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final role = _selectedRole.trim();

    // Update loading state
    setState(() {
      _submitting = true;
    });

    try {
      // Build request payload that matches backend schema
      final payload = {
        'staff_id': staffId,
        'username':
            staffId, // keep a username (backward compatible): use staff_id
        'password': password,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'role': role,
      };

      final uri = Uri.parse('$_baseUrl/users/');

      // Send POST request
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      // Print detailed response for troubleshooting in terminal
      // Note: On web this prints to browser console; on backend, server logs already print
      // We're following the instruction to print error codes in try/catch
      print(
          '[POST /users/] status=${response.statusCode} body=${response.body}');

      // Reset loading state
      if (!mounted) return;
      setState(() {
        _submitting = false;
      });

      // Handle API response
      if (response.statusCode == 200) {
        // Success feedback
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User added successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      } else {
        // Failure feedback with status and message
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to add user: ${response.statusCode} ${response.body}',
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      // Print exception details to console for debugging
      print('[POST /users/] exception=$e');
      if (!mounted) return;
      setState(() {
        _submitting = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding user: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dialog container with a form
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  'Add New Staff',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),

                // Staff ID
                TextFormField(
                  controller: _staffIdController,
                  decoration: InputDecoration(
                    labelText: 'Staff ID',
                    hintText: 'e.g. 0001',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.badge, color: Colors.blue),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Staff ID is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // First and Last name in a row
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.person_outline,
                              color: Colors.blue),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'First name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.person_outline,
                              color: Colors.blue),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Last name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'name@example.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon:
                        const Icon(Icons.email_outlined, color: Colors.blue),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(v.trim())) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Colors.blue),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Password is required';
                    }
                    if (v.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Role dropdown
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedRole,
                      items: const [
                        DropdownMenuItem(
                          value: 'admin',
                          child: Text('Admin'),
                        ),
                        DropdownMenuItem(
                          value: 'Manager',
                          child: Text('Manager'),
                        ),
                        DropdownMenuItem(
                          value: 'Finance / Accounting',
                          child: Text('Finance / Accounting'),
                        ),
                        DropdownMenuItem(
                          value: 'Human resource',
                          child: Text('HR'),
                        ),
                        DropdownMenuItem(
                          value: 'Operations',
                          child: Text('Operations Logistics'),
                        ),
                        DropdownMenuItem(
                          value: 'default',
                          child: Text('default'),
                        ),
                      ],
                      onChanged: (newVal) {
                        if (newVal == null) return;
                        setState(() {
                          _selectedRole = newVal;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _submitting
                          ? null
                          : () {
                              Navigator.of(context).pop();
                            },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _submitting ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                      ),
                      child: _submitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Add User',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _staffIdController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
