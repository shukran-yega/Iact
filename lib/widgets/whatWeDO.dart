import 'package:flutter/material.dart';
import 'package:iact/widgets/glassContainer.dart';

class WhatIactDoes extends StatelessWidget {
  const WhatIactDoes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3, // Controls width
      height: 120,
      child: GlassmorphicContainer(
        blurStrength: 15,
        opacity: 0.2,
        borderRadius: 30,
        borderColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            height: 80, // Maintain a similar height structure
            child: Stack(
              clipBehavior: Clip.none, // Allow overlapping icons
              children: [
                Positioned(
                    left: 3,
                    //bottom: 10,
                    child: _serviceIcon(Icons.storage, "Data Collection")),
                Positioned(
                    left: 100, child: _serviceIcon(Icons.science, "Research")),
                Positioned(
                    left: 200,
                    child: _serviceIcon(Icons.bar_chart, "Analytics")),
                Positioned(
                  left: 300,
                  top: 20,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                      children: [
                        TextSpan(
                          text: "20+",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                        const TextSpan(
                          text: "\nProjects Completed",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for Service Icons
  Widget _serviceIcon(IconData icon, String serviceName) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white.withOpacity(0.8),
          child: Icon(icon, size: 30, color: Colors.black87),
        ),
        const SizedBox(height: 5),
        Text(
          serviceName,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54),
        ),
      ],
    );
  }
}
