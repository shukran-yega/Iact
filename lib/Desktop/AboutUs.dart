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
                'The Team',
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
    final coreMembers = [
      {
        'name': 'Isaac Lyatuu',
        'role': 'System Architect',
        'id': '1',
        'image': 'isaac.jpg'
      },
      {
        'name': 'Jonas Mwambimbi',
        'role': 'Systems developer',
        'id': '3',
        'image': 'jonas.jpg'
      },
      {
        'name': 'Shoko Mohamed',
        'role': 'Product Design',
        'id': '4',
        'image': 'assets/team/shoko.jpg'
      },
      {
        'name': 'John Smith',
        'role': 'DevOps Engineer',
        'id': '9',
        'image': 'assets/team/john.jpg'
      },
      {
        'name': 'Carlos Stevenson',
        'role': 'Frontend Developer',
        'id': '11',
        'image': 'assets/team/carlos.jpg'
      },
      {
        'name': 'Sophie Thompson',
        'role': 'Product Manager',
        'id': '12',
        'image': 'assets/team/sophie.jpg'
      },
      {
        'name': 'Alex Brown',
        'role': 'Systems Architect',
        'id': '13',
        'image': 'assets/team/alex.jpg'
      },
      {
        'name': 'Grace Litu',
        'role': 'Research Engineer',
        'id': '14',
        'image': 'assets/team/grace.jpg'
      },
    ];

    final partTimeStaff = [
      {
        'name': 'Godfrey Siwingwa',
        'role': 'Field Coordinator',
        'id': '2',
        'image': 'Godfrey.jpg'
      },
      {
        'name': 'Farida Katunzi',
        'role': 'Finance & Admin',
        'id': '10',
        'image': 'farida.jpeg'
      },
      {
        'name': 'Shukurani Irema',
        'role': 'Mobile Developer',
        'id': '6',
        'image': 'assets/team/shukurani.jpg'
      },
    ];

    return [
      Center(
        child: Text(
          'Core Team Members',
          style: GoogleFonts.baloo2(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
      ),
      const SizedBox(height: 20),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 60,
        runSpacing: 60,
        children: coreMembers
            .map((member) => _buildTeamMemberCard(context, member))
            .toList(),
      ),
      const SizedBox(height: 40),
      Center(
        child: Text(
          'Part-Time Members',
          style: GoogleFonts.baloo2(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
      ),
      const SizedBox(height: 20),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 60,
        runSpacing: 60,
        children: partTimeStaff
            .map((member) => _buildTeamMemberCard(context, member))
            .toList(),
      ),
    ];
  }

  Widget _buildTeamMemberCard(
      BuildContext context, Map<String, String> member) {
    final Map<String, String> profiles = {
      'Isaac Lyatuu':
          'BSc. In Computer Science, MSc in Mathematics and PhD. In Epidemiology with over 10 years in Health Systems designs and application, particularly in low-resource settings. Practical experience in data science activities including analysis and graphical presentations, machine learning and software development.',
      'Godfrey Siwingwa':
          'Bachelors of Arts in Public Administration with over 5 years of experiences for field implementation working with digital and paper-based data collection teams. Support both, quantitative and qualitative data collections activities, and formal introduction to administrative structures.',
      'Farida Katunzi':
          'Bachelor of Arts in Finance and a Master of Arts in Project Planning and Management with 6+ experience managing projects coupled with strong foundation in both financial and project management. Manage compliance with ethical requirements and communications for securing research permits and introduction letters.',
      'Jonas Mwambimbi':
          'Full Stack software developer with 4+ experience in python + java development including REStFul API, Systems Gateways and Web-based applications. Experience in Django, NoSQL, Flask, FastAPI and AngularJS.',
      'Shoko Mohamed':
          'BSc. in Mass Communication with 4+ years of experience crafting intuitive and impactful designs using tools like Figma, Adobe XD, and more. Passionate about visual storytelling and user-centered design.',
      'Shukurani Irema':
          'BSc. in Computer Science with 3+ years of full-stack development experience. Skilled in building robust web and mobile apps using Flutter, Supabase, and other modern technologies, with a strong focus on performance and user experience.',
      'John Smith':
          'MSc. in DevOps Engineering with 5+ years of experience in cloud infrastructure, CI/CD pipelines, and containerization. Expert in AWS, Docker, and Kubernetes deployment strategies.',
      'Carlos Stevenson':
          'BSc. in Software Engineering with 4+ years of frontend development experience. Specialized in React, Vue.js, and modern JavaScript frameworks. Strong focus on responsive design and user interface optimization.',
      'Sophie Thompson':
          'MBA with 6+ years in product management. Experienced in agile methodologies, user research, and product strategy. Successfully led multiple digital product launches and iterations.',
      'Alex Brown':
          'PhD in Systems Architecture with 8+ years of experience in designing scalable enterprise solutions. Expert in microservices architecture, cloud computing, and system integration.',
      'Grace Litu':
          'MSc. in Research Engineering with 5+ years in data analysis and research methodology. Specialized in quantitative research methods and statistical analysis for social impact studies.',
    };

    final String bio =
        profiles[member['name']] ?? 'Profile information coming soon...';

    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            closeIconColor: Colors.white,
            showCloseIcon: true,
            elevation: 0,
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.12,
                vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            backgroundColor: Colors.blue.shade900.withOpacity(0.8),
            content: Text(
              bio,
              style: TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 8),
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
