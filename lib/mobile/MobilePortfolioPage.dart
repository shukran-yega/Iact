import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobilePortfolioPage extends StatelessWidget {
  const MobilePortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildPortfolioGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Our Work",
            style: GoogleFonts.baloo2(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Discover our innovative solutions and successful projects",
            style: GoogleFonts.baloo2(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioGrid() {
    final projects = [
      {
        "title": "Data Collection Platform",
        "category": "Software Development",
        "image": "field3.jpg",
      },
      {
        "title": "Research Analytics Dashboard",
        "category": "Data Analysis",
        "image": "PIC2.jpg",
      },
      {
        "title": "Mobile Survey App",
        "category": "Mobile Development",
        "image": "mobile.jpg",
      },
      {
        "title": "Cloud Infrastructure",
        "category": "Data Hosting",
        "image": "cloud.jpg",
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children:
            projects.map((project) => _buildProjectCard(project)).toList(),
      ),
    );
  }

  Widget _buildProjectCard(Map<String, String> project) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              project["image"]!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project["category"]!,
                  style: GoogleFonts.baloo2(
                    fontSize: 14,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  project["title"]!,
                  style: GoogleFonts.baloo2(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
