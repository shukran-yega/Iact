import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iact/Desktop/NavBar.dart';
import 'package:iact/Desktop/staffPanel.dart';
import 'dart:html' as html;

bool _obscurePassword = true; // initial state

class StaffLoginPopup extends StatefulWidget {
  const StaffLoginPopup({Key? key}) : super(key: key);

  @override
  State<StaffLoginPopup> createState() => _StaffLoginPopupState();
}

class _StaffLoginPopupState extends State<StaffLoginPopup> {
  bool _loading = false;
  String? _errorMessage;
  late TextEditingController idController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
    void doLogin() async {
      setState(() {
        _loading = true;
        _errorMessage = null;
      });

      final email = idController.text.trim();
      final password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        setState(() {
          _errorMessage = 'Please enter both email and password.';
          _loading = false;
        });
        return;
      }

      try {
        final baseUrl = html.window.location.hostname == 'localhost' ||
                html.window.location.hostname == '127.0.0.1'
            ? 'http://127.0.0.1:8000'
            : html.window.location.origin;
        final uri = Uri.parse('$baseUrl/auth/login');

        print('[LOGIN] Attempting login with email: $email');
        final resp = await http.post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}),
        );

        print(
            '[LOGIN] Response status: \\${resp.statusCode}, body: \\${resp.body}');

        setState(() {
          _loading = false;
        });

        if (resp.statusCode == 200) {
          final userData = jsonDecode(resp.body);
          print(
              '[LOGIN SUCCESS] User logged in: \\${userData['first_name']} \\${userData['last_name']}');

          isSigned = true;
          Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Staffpanel(
              firstName: userData['first_name'] ?? '',
              role: userData['role'] ?? '',
            );
          }));
        } else if (resp.statusCode == 401) {
          _errorMessage = 'Invalid email or password';
        } else if (resp.statusCode == 500) {
          _errorMessage = 'Server error. Please try again.';
        } else {
          _errorMessage = 'Login failed: \\${resp.statusCode}';
        }
      } catch (e) {
        setState(() {
          _loading = false;
          _errorMessage = 'Network error: $e';
        });
      }
    }

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
              "Staff Login",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            // Email text field
            TextField(
              controller: idController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                focusColor: Colors.blue.shade900,
                labelText: "Email Address",
                hintText: "Enter your email address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Password text field
            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              style: const TextStyle(),
              decoration: InputDecoration(
                focusColor: Colors.blue.shade900,
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              onSubmitted: (_) => doLogin(),
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
              onPressed: _loading ? null : doLogin,
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
