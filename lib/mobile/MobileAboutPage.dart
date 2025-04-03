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
        'name': 'Isaac Lyatuu',
        'role': 'Managing Director',
        'id': '1',
        'image': 'isaac.jpg'
      },
      {
        'name': 'Samson Kiware',
        'role': 'Principal Researcher',
        'id': '2',
        'image': 'samson.jpg'
      },
      {
        'name': 'Jonas Mwambimbi',
        'role': 'Software Architect',
        'id': '3',
        'image': 'jonas.jpg'
      },
      {
        'name': 'Shoko Irema',
        'role': 'UI/UX Designer',
        'id': '4',
        'image': 'shoko.jpg'
      },
      {
        'name': 'Selemani Mmbaga',
        'role': 'Full Stack Developer',
        'id': '5',
        'image': 'assets/team/selemani.jpg'
      },
      {
        'name': 'Shukurani Mohamed',
        'role': 'Mobile Developer',
        'id': '6',
        'image': ''
      },
      {
        'name': 'Samwel Godfrey',
        'role': 'Backend Engineer',
        'id': '7',
        'image': 'assets/team/samwel.jpg'
      },
      // {
      //   'name': 'Imani Irema',
      //   'role': 'Data Scientist',
      //   'id': '8',
      //   'image': 'assets/team/imani.jpg'
      // },
      {
        'name': 'John Smith',
        'role': 'DevOps Engineer',
        'id': '9',
        'image': 'assets/team/john.jpg'
      },
      {
        'name': ' Farida Katunzi',
        'role': 'QA Engineer',
        'id': '10',
        'image': 'assets/team/farida.jpg'
      },
      {
        'name': 'Carlos Martinez',
        'role': 'Frontend Developer',
        'id': '11',
        'image': 'assets/team/carlos.jpg'
      },
      {
        'name': 'Sophie Brown',
        'role': 'Product Manager',
        'id': '12',
        'image': 'assets/team/sophie.jpg'
      },
      {
        'name': 'Alex Johnson',
        'role': 'Systems Architect',
        'id': '13',
        'image': 'assets/team/alex.jpg'
      },
      {
        'name': 'Grace Liu',
        'role': 'Research Engineer',
        'id': '14',
        'image': 'assets/team/grace.jpg'
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
