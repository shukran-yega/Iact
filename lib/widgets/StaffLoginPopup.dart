import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:iact/Desktop/NavBar.dart';

bool _obscurePassword = true; // initial state

class StaffLoginPopup extends StatefulWidget {
  const StaffLoginPopup({Key? key}) : super(key: key);

  @override
  State<StaffLoginPopup> createState() => _StaffLoginPopupState();
}

class _StaffLoginPopupState extends State<StaffLoginPopup> {
  bool _loading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    // Controller for the ID text field
    final TextEditingController idController = TextEditingController();
    // Controller for the password text field
    final TextEditingController passwordController = TextEditingController();

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Title for the popup
            const Text(
              "Staff Login v0.0.3",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            // ID text field
            TextField(
              controller: idController,
              decoration: InputDecoration(
                focusColor: Colors.blue.shade900,
                labelText: "Staff ID",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Password text field
            // Inside your StatefulWidget

            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              style: const TextStyle(),
              decoration: InputDecoration(
                focusColor: Colors.blue.shade900,
                labelText: "Password",
                // optional: label text color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                // Add a suffix icon to toggle visibility
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword; // toggle visibility
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 24.0),
            if (_errorMessage != null) ...[
              SizedBox(height: 12),
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red.shade700),
                textAlign: TextAlign.center,
              ),
            ],

            const SizedBox(height: 12),

            // Login button
            ElevatedButton(
              onPressed: _loading
                  ? null
                  : () async {
                      setState(() {
                        _loading = true;
                        _errorMessage = null;
                      });

                      final staffId = idController.text.trim();
                      final password = passwordController.text;

                      if (staffId.isEmpty || password.isEmpty) {
                        setState(() {
                          _errorMessage = 'Please enter both ID and password.';
                          _loading = false;
                        });
                        return;
                      }

                      try {
                        final uri =
                            Uri.parse('http://127.0.0.1:8000/auth/login');

                        final resp = await http.post(
                          uri,
                          headers: {'Content-Type': 'application/json'},
                          body: jsonEncode(
                              {'username': staffId, 'password': password}),
                        );

                        setState(() {
                          _loading = false;
                        });

                        if (resp.statusCode == 200) {
                          isSigned = true;
                          Navigator.of(context).pop();
                        } else if (resp.statusCode == 401) {
                          _errorMessage = 'Invalid credentials';
                        } else {
                          _errorMessage = 'Server error: ${resp.statusCode}';
                        }
                      } catch (e) {
                        setState(() {
                          _loading = false;
                          _errorMessage = 'Network error: $e';
                        });
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              child: _loading
                  ? SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text("Login", style: TextStyle(fontSize: 18.0)),
            )
          ],
        ),
      ),
    );
  }
}
