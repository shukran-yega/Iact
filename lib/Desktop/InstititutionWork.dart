import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstitutionStats extends StatelessWidget {
  const InstitutionStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        // Positioned.fill(
        //   child: Image.asset(
        //     "assets/field2.jpg", // Change this to your background image
        //     fit: BoxFit.cover,
        //   ),
        // ),

        // Dark Overlay for Contrast
        Positioned.fill(
          child: Container(
            color: Colors.blueGrey.withOpacity(0.05),
          ),
        ),

        // Content
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text.rich(
                TextSpan(
                  text: "Our ",
                  style: GoogleFonts.baloo2(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Impact",
                      style: GoogleFonts.baloo2(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard(
                  icon: Icons.people,
                  value: "10+",
                  label: "Creative Staff",
                ),
                _buildStatCard(
                  icon: Icons.task_alt,
                  value: "15+",
                  label: "Projects Accomplished",
                ),
                _buildStatCard(
                  icon: Icons.handshake,
                  value: "13+",
                  label: "Clients",
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
      {required IconData icon, required String value, required String label}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
            border: Border.all(color: Colors.blue.shade900, width: 3),
          ),
          child: Icon(icon, color: Colors.black, size: 40),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: GoogleFonts.baloo2(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          label,
          style: GoogleFonts.baloo2(fontSize: 18, color: Colors.black),
        ),
      ],
    );
  }
}
