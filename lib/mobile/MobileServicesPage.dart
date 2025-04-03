import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileServicesPage extends StatelessWidget {
  const MobileServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildServicesList(),
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
            "From insights to innovation",
            style: GoogleFonts.baloo2(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Transforming bold ideas into actionable insights through innovation and data-driven strategies",
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

  Widget _buildServicesList() {
    final services = [
      {
        "title": "Software Development",
        "subtitle": "Creating Custom tailored software solutions",
        "description":
            "IACT specializes in crafting tailor-made software solutions that empower businesses to streamline processes and achieve their unique goals.",
        "image": "assets/computer.jpg",
      },
      {
        "title": "Research Implementation",
        "subtitle": "Ethical and structured research",
        "description":
            "Ethical research implementation balances integrity and accountability, protecting rights and ensuring transparency.",
        "image": "assets/field5.jpg",
      },
      {
        "title": "Mobile Development",
        "subtitle": "Creating Custom tailored software solutions",
        "description":
            "Mobile development focuses on creating user-friendly, responsive applications tailored for smartphones and tablets.",
        "image": "assets/mobile.jpg",
      },
      {
        "title": "Data Hosting",
        "subtitle": "Secured Cloud based Hosting",
        "description":
            "Secured cloud-based hosting ensures data protection through encryption, firewalls, and regular backups.",
        "image": "assets/cloud.jpg",
      },
      {
        "title": "Data Analysis",
        "subtitle": "Performing data analysis",
        "description":
            "Data analysis involves systematically collecting, cleaning, and interpreting data to uncover insights.",
        "image": "assets/PIC2.jpg",
      },
      {
        "title": "Data Collection",
        "subtitle": "Ethical Data collection",
        "description":
            "Data collection involves gathering information from various sources using structured methods.",
        "image": "assets/field.jpg",
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceCard(service);
      },
    );
  }

  Widget _buildServiceCard(Map<String, String> service) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
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
              service["image"]!,
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
                  service["title"]!,
                  style: GoogleFonts.baloo2(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  service["subtitle"]!,
                  style: GoogleFonts.baloo2(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  service["description"]!,
                  style: GoogleFonts.baloo2(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.5,
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
