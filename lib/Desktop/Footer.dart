import 'package:flutter/material.dart';

class IACTFooter extends StatelessWidget {
  const IACTFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      color: const Color(0xFFEFF3FA), // Light blue background
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Contact Info, Address, and Logo in a single row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email Icon

              // Contact Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "📧 Email Address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "info@iact.co.tz",
                    style: TextStyle(fontSize: 14, color: Colors.blue[700]),
                  ),
                  Text(
                    "support@iact.co.tz",
                    style: TextStyle(fontSize: 14, color: Colors.blue[700]),
                  ),
                ],
              ),

              // Address Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "📍 Physical Address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("IACT - Ideas in Action",
                      style: TextStyle(fontSize: 14)),
                  Text("Tanzania, Dar es salaam",
                      style: TextStyle(fontSize: 14)),
                  Text("P.O Box 12345 - 00100", style: TextStyle(fontSize: 14)),
                ],
              ),

              // Logo
              Image.asset(
                "iact.png", // Replace with actual IACT logo
                height: 50,
              ),
            ],
          ),

          const SizedBox(height: 5),

          // Copyright Info
          Column(
            children: const [
              Text(
                "© 2025 IACT - Ideas in Action. All Rights Reserved.",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              SizedBox(height: 5),
              Text(
                "Version: 1.0.0",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
