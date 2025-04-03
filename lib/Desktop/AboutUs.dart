import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                'IACT Team',
                style: GoogleFonts.baloo2(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'IACT is, in part, a collaborative effort with various industry partners and academic institutions.',
                style: GoogleFonts.baloo2(
                  fontSize: 24,
                  height: 1.5,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 60,
                  runSpacing: 60,
                  children: _buildTeamMembers(context),
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'About us',
                      style: GoogleFonts.baloo2(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '''               The IACT team develops and maintains various tools, algorithms, and software
                related to innovative software solutions.Development is ongoing, and things are changing rapidly. 
                This site provides information useful for accessing and using IACT services as well as
                recent publications and updates on what the team has done.All of our software itself
                is developed using modern technologies including Flutter, React, and Node.js.Our applications
                are available through various platforms including web, mobile, and desktop environments.''',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.baloo2(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTeamMembers(BuildContext context) {
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
        'name': ' Farida Katunzi',
        'role': 'Finance Manager',
        'id': '10',
        'image': 'farida.jpeg'
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
        'image': 'assets/team/shoko.jpg'
      },
      {
        'name': 'Shukurani Mohamed',
        'role': 'Mobile Developer',
        'id': '6',
        'image': 'assets/team/shukurani.jpg'
      },
      {
        'name': 'Selemani Mmbaga',
        'role': 'Full Stack Developer',
        'id': '5',
        'image': 'assets/team/selemani.jpg'
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

    return teamMembers
        .map((member) => _buildTeamMemberCard(context, member))
        .toList();
  }

  Widget _buildTeamMemberCard(
      BuildContext context, Map<String, String> member) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue.shade900,
            content: Text(
                "${member['name']}'s IACT profile is unavailable right now try again later"),
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: member['image'] != null
                      ? Image.asset(
                          member['image']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            );
                          },
                        )
                      : Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              member['name']!,
              style: GoogleFonts.baloo2(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.blue.shade900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              member['role']!,
              style: GoogleFonts.baloo2(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
