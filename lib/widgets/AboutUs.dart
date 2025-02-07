import 'package:flutter/material.dart';

class AboutIact extends StatelessWidget {
  const AboutIact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
      margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.redAccent.shade100
            .withOpacity(0.2), // Soft red accent background
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About IACT",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent.shade700, // Darker red accent for text
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "At IACT, we transform ideas into action by fostering innovation and delivering creative solutions. "
            "Our team is dedicated to turning bold concepts into reality, ensuring tangible results through collaboration and strategic planning.",
            style: TextStyle(
              fontSize: 23,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              //height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
