import 'package:flutter/material.dart';
import 'package:iact/widgets/glassContainer.dart';

class WhatIactDoes extends StatelessWidget {
  const WhatIactDoes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6, // Controls width
        child: GlassmorphicContainer(
          blurStrength: 15,
          opacity: 0.2,
          borderRadius: 30,
          borderColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  "What We Do",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 15),

                // List of Services
                Column(
                  children: [
                    _serviceItem(Icons.storage, "Data Collection"),
                    _serviceItem(Icons.science, "Research Implementation"),
                    _serviceItem(Icons.smartphone, "Mobile Applications"),
                    _serviceItem(Icons.developer_mode, "Systems Development"),
                    _serviceItem(Icons.bar_chart, "Data Analytics"),
                    _serviceItem(Icons.cloud, "Data Hosting"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for each service
  Widget _serviceItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon and Text
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white.withOpacity(0.8),
                child: Icon(icon, size: 26, color: Colors.black87),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),

          // Read More Button
          TextButton(
            onPressed: () {
              print("Read more about $title");
            },
            child: const Text(
              "Read More",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
