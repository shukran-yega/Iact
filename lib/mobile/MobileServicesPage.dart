import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileServicesPage extends StatefulWidget {
  const MobileServicesPage({super.key});

  @override
  State<MobileServicesPage> createState() => _MobileServicesPageState();
}

class _MobileServicesPageState extends State<MobileServicesPage> {
  final List<double> _imageScales = List.generate(9, (_) => 1.0);
  final List<double> _cardElevations = List.generate(9, (_) => 2.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.blue.shade50.withOpacity(0.3),
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              _buildHeader(),
              _buildServicesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              text: "Our ",
              style: GoogleFonts.baloo2(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: "Services ",
                  style: GoogleFonts.baloo2(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Transforming bold ideas to breakthrough products, \npowered by innovation and insight",
            textAlign: TextAlign.center,
            style: GoogleFonts.baloo2(
              fontSize: 18,
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
            "IACT specializes in crafting tailor-made software solutions that empower businesses to streamline processes and achieve their unique goals. We deliver scalable and efficient systems designed to drive success. Your vision, our expertise—seamlessly integrated.",
        "image": "computer.jpg",
      },
      {
        "title": "Research Implementation",
        "subtitle": "Ethical and structured research",
        "description":
            "Ethical research implementation balances integrity and accountability, protecting rights and ensuring transparency. By following clear objectives and systematic methodologies, it delivers meaningful, impactful results while upholding established guidelines",
        "image": "field5.jpg",
      },
      {
        "title": "Mobile Development",
        "subtitle": "From Concept to Launch",
        "description":
            "We craft intuitive and responsive applications tailored for smartphones and tablets—seamlessly integrated with desktop web platforms. Our approach ensures maximum accessibility, consistent performance across devices, and meaningful user engagement at every touch-point",
        "image": "mobile.jpg",
      },
      {
        "title": "Data Hosting",
        "subtitle": "Virtual Private servers",
        "description": "Virtual Private Servers (VPS)"
            "Online machines with Windows and Linux OS"
            "We help our clients to configure online virtual machines through trusted companies such as Digital Oceans, Contabo & Go Daddy and manage payments in local currency. The virtual machines can be run with Windows or Linux, configured with static IP address, DNS and additional services such as automatic backups, firewalls and remote management.",
        "image": "cloud.jpg",
      },
      {
        "title": "Data Analysis",
        "subtitle": "Performing data analysis",
        "description":
            "Data analysis involves systematically collecting, cleaning, and interpreting data to uncover insights and support decision-making. By leveraging statistical techniques and visualization tools, it transforms raw data into actionable knowledge.",
        "image": "PIC2.jpg",
      },
      {
        "title": "Data Collection",
        "subtitle": "Field-work and ground experience",
        "description":
            "We employ a diverse range of structured and unstructured data collection methods covering both quantitative and qualitative fieldwork. Our approach ensures accuracy, contextual relevance, and provides a solid foundation for insightful analysis and data-driven decision-making in research and business environments",
        "image": "field.jpg",
      },
      {
        "title": "Recruiting and Training",
        "subtitle": "Training enumerators to perform ethical interviews",
        "description":
            "Recruiting and training enumerators involves selecting qualified individuals for data collection tasks and equipping them with the necessary skills. This includes thorough onboarding, clear instructions, and practical training.",
        "image": "field2.jpg",
      },
      {
        "title": "Support and Mentorship",
        "subtitle": "Support others through mentorship",
        "description":
            "Support and mentorship involve guiding individuals through challenges while fostering their personal and professional growth. It includes providing advice, sharing knowledge, and creating a nurturing environment for development.",
        "image": "field8.jpg",
      },
      {
        "title": "Research Deployment",
        "subtitle": "Deploying research proposal to local context",
        "description":
            "Adaptation and deployment of a research proposal involve tailoring the methodology to fit specific contexts and ensuring its effective implementation. This process prioritizes ethical considerations and systematic execution.",
        "image": "field11_2.jpg",
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceCard(service, index);
      },
    );
  }

  Widget _buildServiceCard(Map<String, String> service, int index) {
    return GestureDetector(
      onTapDown: (_) => setState(() {
        _imageScales[index] = 1.05;
        _cardElevations[index] = 8.0;
      }),
      onTapUp: (_) => setState(() {
        _imageScales[index] = 1.0;
        _cardElevations[index] = 2.0;
      }),
      onTapCancel: () => setState(() {
        _imageScales[index] = 1.0;
        _cardElevations[index] = 2.0;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: _cardElevations[index] * 2,
              offset: Offset(0, _cardElevations[index]),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Transform.scale(
                scale: _imageScales[index],
                child: Image.asset(
                  service["image"]!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      service["subtitle"]!,
                      style: GoogleFonts.baloo2(
                        fontSize: 16,
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.w500,
                      ),
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
      ),
    );
  }
}
