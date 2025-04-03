import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileAboutPage extends StatelessWidget {
  const MobileAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildTeamSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "IACT Team",
            style: GoogleFonts.baloo2(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Meet our exceptional team of innovators, developers, and researchers who are passionate about transforming ideas into impactful solutions. Together, we combine expertise in technology, research, and data analytics to drive meaningful change.",
            textAlign: TextAlign.center,
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

  Widget _buildTeamSection() {
    final teamMembers = [
      {
        "name": "Dr. James Anderson",
        "role": "Chief Executive Officer",
      },
      {
        "name": "Sarah Mitchell",
        "role": "Head of Research",
      },
      {
        "name": "Michael Chen",
        "role": "Lead Software Developer",
      },
      {
        "name": "Dr. Emily Carter",
        "role": "Data Science Director",
      },
      {
        "name": "David Kimani",
        "role": "Field Operations Manager",
      },
      {
        "name": "Lisa Wong",
        "role": "UX Research Lead",
      },
      {
        "name": "Robert Mbeki",
        "role": "Senior Developer",
      },
      {
        "name": "Maria Garcia",
        "role": "Research Coordinator",
      },
      {
        "name": "John Doe",
        "role": "Systems Architect",
      },
      {
        "name": "Anna Smith",
        "role": "Data Analyst",
      },
      {
        "name": "Peter Zhang",
        "role": "Mobile Developer",
      },
      {
        "name": "Grace Ochieng",
        "role": "Project Manager",
      },
      {
        "name": "Tom Wilson",
        "role": "Backend Developer",
      },
      {
        "name": "Sophie Chen",
        "role": "UI/UX Designer",
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Wrap(
        spacing: 16,
        runSpacing: 24,
        alignment: WrapAlignment.center,
        children:
            teamMembers.map((member) => _buildTeamMember(member)).toList(),
      ),
    );
  }

  Widget _buildTeamMember(Map<String, String> member) {
    return Container(
      width: 150,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade100,
              border: Border.all(
                color: Colors.blue.shade900.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.blue.shade900.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            member["name"]!,
            textAlign: TextAlign.center,
            style: GoogleFonts.baloo2(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            member["role"]!,
            textAlign: TextAlign.center,
            style: GoogleFonts.baloo2(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
