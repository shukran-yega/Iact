import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileAboutPage extends StatefulWidget {
  const MobileAboutPage({super.key});

  @override
  State<MobileAboutPage> createState() => _MobileAboutPageState();
}

class _MobileAboutPageState extends State<MobileAboutPage> {
  final List<Map<String, String>> coreMembers = [
    {
      'name': 'Isaac Lyatuu',
      'role': 'System Architect',
      'id': '1',
      'image': 'isaac.jpg',
      'testimony': '',
    },
    {
      'name': 'Jonas Mwambimbi',
      'role': 'Systems developer',
      'id': '3',
      'image': 'jonas.jpg',
      'testimony': '',
    },
    {
      'name': 'Shoko Mohamed',
      'role': 'Product Design',
      'id': '4',
      'image': 'assets/team/shoko.jpg',
      'testimony':
          "Working with IAct since early 2024 has been a truly transformative experience for me. As a Product Designer, I've gained invaluable skills in both coding and design, expanding my capabilities far beyond what I initially expected. The team at IAct has not only supported my growth within the company but has also exposed me to parts of the tech industry I might never have encountered otherwise."
              "One of the most rewarding parts of this journey has been IAct's encouragement and support in helping me develop my own idea and bring it to market. Their belief in my potential and their willingness to invest in my growth has opened doors to exciting new opportunities. I'm incredibly grateful to be part of a company that fosters innovation, learning, and real-world impact.",
    },
    {
      'name': 'Felix Ruben',
      'role': 'DevOps Engineer',
      'id': '9',
      'image': 'assets/team/john.jpg',
      'testimony': '',
    },
    {
      'name': 'Janice Stephen',
      'role': 'Product Manager',
      'id': '12',
      'image': 'assets/team/sophie.jpg',
      'testimony': '',
    },
    {
      'name': 'Carlos Stevenson',
      'role': 'Frontend Developer',
      'id': '11',
      'image': 'assets/team/carlos.jpg',
      'testimony': '',
    },
    {
      'name': 'Alex Brown',
      'role': 'Systems Architect',
      'id': '13',
      'image': 'assets/team/alex.jpg',
      'testimony': '',
    },
    {
      'name': 'Grace Litu',
      'role': 'Research Engineer',
      'id': '14',
      'image': 'assets/team/grace.jpg',
      'testimony': '',
    },
  ];

  final List<Map<String, String>> partTimeStaff = [
    {
      'name': 'Godfrey Siwingwa',
      'role': 'Field Coordinator',
      'id': '2',
      'image': 'Godfrey.jpg',
      'testimony':
          "With hands-on experience supervising and implementing projects across Tanzania, I've witnessed firsthand how ideas—often starting as voices from individuals or communities—are captured through surveys and interviews, transformed into digital solutions, and ultimately inform decision-making at various levels. For me, this is the true meaning of turning ideas into action. iACT has given me the platform to be part of this journey, and I take great pride in contributing to meaningful impact."
              "\n\nBsc of Arts in Public Administration - G.Siwingwa",
    },
    {
      'name': 'Farida Katunzi',
      'role': 'Finance & Admin',
      'id': '10',
      'image': 'farida.jpeg',
      'testimony':
          "I joined iACT eight years ago, primarily supporting office operations and project implementation. The diverse exposure inspired me to pursue further education in Social science (monitering and evaluation). iACT believed in my vision and supported it—both financially through tuition assistance and by offering the flexibility to balance work and school. This experience truly brought my ideas to life, and I'm deeply grateful for the opportunity."
              "\n\nBSc of Arts in Finance - F.Katunzi\nMSc of Arts in project planning - F.Katunzi\nPhd in progress",
    },
    {
      'name': 'Shukurani Irema',
      'role': 'Software Developer',
      'id': '6',
      'image': 'assets/team/shukurani.jpg',
      'testimony':
          "As part of my BSc degree requirements, I undertook an internship with iACT, where I was entrusted with revamping their website to reflect recent company developments and enhance its professional appeal. Throughout the process, I received invaluable technical mentorship that not only helped me meet my academic goals but also provided hands-on experience with real-world projects. It was a true example of turning ideas into action"
              '\n\nBSc in Computer Science - S.Irema',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                'The Team',
                style: GoogleFonts.baloo2(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'IACT is, in part, a collaborative effort with various industry partners and academic institutions.',
                textAlign: TextAlign.center,
                style: GoogleFonts.baloo2(
                  fontSize: 18,
                  height: 1.5,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 24,
                  runSpacing: 24,
                  children: _buildTeamMembers(context),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Turning ideas into Action',
                style: GoogleFonts.baloo2(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 24,
                children: partTimeStaff
                    .map((member) => _buildTeamMemberCard(context, member))
                    .toList(),
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About us',
                    style: GoogleFonts.baloo2(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '''The IACT team develops and maintains various tools, algorithms, and software
related to innovative software solutions. Development is ongoing, and things are changing rapidly. 
This site provides information useful for accessing and using IACT services as well as
recent publications and updates on what the team has done. All of our software itself
is developed using modern technologies including Flutter, React, and Node.js. Our applications
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
    return [
      Text(
        'Core Team Members',
        style: GoogleFonts.baloo2(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade900,
        ),
      ),
      const SizedBox(height: 16),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 24,
        runSpacing: 24,
        children: coreMembers
            .map((member) => _buildTeamMemberCard(context, member))
            .toList(),
      ),
      const SizedBox(height: 32),
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
          'BSc. In Mass Communication with 4+ years in design patterns using tools such as Figma, adobe XD and many more',
      'Shukurani Irema':
          'BSc. in Computer Science with expertise in mobile app development using Flutter. 3+ years of experience in creating cross-platform applications with focus on user experience and performance optimization.',
      'Felix Ruben':
          'MSc. in DevOps Engineering with 5+ years of experience in cloud infrastructure, CI/CD pipelines, and containerization. Expert in AWS, Docker, and Kubernetes deployment strategies.',
      'Carlos Stevenson':
          'BSc. in Software Engineering with 4+ years of frontend development experience. Specialized in React, Vue.js, and modern JavaScript frameworks. Strong focus on responsive design and user interface optimization.',
      'Janice Stephen':
          'MBA with 6+ years in product management. Experienced in agile methodologies, user research, and product strategy. Successfully led multiple digital product launches and iterations.',
      'Alex Brown':
          'PhD in Systems Architecture with 8+ years of experience in designing scalable enterprise solutions. Expert in microservices architecture, cloud computing, and system integration.',
      'Grace Litu':
          'MSc. in Research Engineering with 5+ years in data analysis and research methodology. Specialized in quantitative research methods and statistical analysis for social impact studies.',
    };

    final String bio =
        profiles[member['name']] ?? 'Profile information coming soon...';
    final String testimony = member['testimony'] ?? '';
    final bool hasTestimony = testimony.isNotEmpty;

    return InkWell(
      onTap: () {
        _showMemberDetailBottomSheet(
            context, member, bio, testimony, hasTestimony);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: member['image'] != null
                      ? Image.asset(
                          member['image']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            );
                          },
                        )
                      : Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              member['name']!,
              style: GoogleFonts.baloo2(
                fontSize: 16,
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

  void _showMemberDetailBottomSheet(
    BuildContext context,
    Map<String, String> member,
    String bio,
    String testimony,
    bool hasTestimony,
  ) {
    showModalBottomSheet(
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 24),
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
              SizedBox(height: 16),
              Text(
                member['name']!,
                style: GoogleFonts.baloo2(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(height: 6),
              Text(
                member['role']!,
                style: GoogleFonts.baloo2(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile',
                        style: GoogleFonts.baloo2(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        bio,
                        style: GoogleFonts.baloo2(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.grey[800],
                        ),
                      ),
                      if (hasTestimony) ...[
                        SizedBox(height: 24),
                        Text(
                          'Details',
                          style: GoogleFonts.baloo2(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.blue.shade100,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            testimony,
                            style: GoogleFonts.baloo2(
                              fontSize: 16,
                              height: 1.5,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
