import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final List<double> _imageScales = List.generate(9, (_) => 1.0);
  final List<double> _cardElevations = List.generate(9, (_) => 2.0);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 1200;

    return SingleChildScrollView(
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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 20 : 40, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(context),
              SizedBox(height: 40),
              _buildServicesGrid(context, isSmallScreen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          TextSpan(
            text: "From ",
            style: GoogleFonts.baloo2(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: "insights ",
                style: GoogleFonts.baloo2(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              TextSpan(
                text: "to",
                style: GoogleFonts.baloo2(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: " innovation",
                style: GoogleFonts.baloo2(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          textAlign: TextAlign.center,
          "Transforming bold ideas into actionable insights through innovation and data-driven strategies",
          style: GoogleFonts.baloo2(
            fontSize: 24,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context, bool isSmallScreen) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        _buildServiceCard(
          context,
          0,
          "Software Development",
          "Creating Custom tailored software solutions",
          "IACT specializes in crafting tailor-made software solutions that empower businesses to streamline processes and achieve their unique goals. We deliver scalable and efficient systems designed to drive success. Your vision, our expertise—seamlessly integrated.",
          "computer.jpg",
          isSmallScreen,
        ),
        _buildServiceCard(
          context,
          1,
          "Research Implementation",
          "Ethical and structured research",
          "Ethical research implementation balances integrity and accountability, protecting rights and ensuring transparency. By following clear objectives and systematic methodologies, it delivers meaningful, impactful results while upholding established guidelines",
          "field5.jpg",
          isSmallScreen,
          isHorizontal: true,
        ),
        _buildServiceCard(
          context,
          2,
          "Mobile Development",
          "Creating Custom tailored software solutions",
          "Mobile development focuses on creating user-friendly, responsive applications tailored for smartphones and tablets. With innovative design and seamless performance, it enhances accessibility and engagement for users. From concept to deployment.",
          "mobile.jpg",
          isSmallScreen,
        ),
        _buildServiceCard(
          context,
          3,
          "Data Hosting",
          "Secured Cloud based Hosting",
          "Secured cloud-based hosting ensures data protection through encryption, firewalls, and regular backups. It offers scalable solutions with robust security measures to safeguard. Perfect for businesses prioritizing safety and efficiency.",
          "cloud.jpg",
          isSmallScreen,
        ),
        _buildServiceCard(
          context,
          4,
          "Data Analysis",
          "Performing data analysis",
          "Data analysis involves systematically collecting, cleaning, and interpreting data to uncover insights and support decision-making. By leveraging statistical techniques and visualization tools, it transforms raw data into actionable knowledge.",
          "PIC2.jpg",
          isSmallScreen,
          isHorizontal: true,
        ),
        _buildServiceCard(
          context,
          5,
          "Data Collection",
          "Ethical Data collection",
          "Data collection involves gathering information from various sources using structured methods, ensuring accuracy and relevance. It serves as the foundation for analysis and decision-making in research and business.",
          "field.jpg",
          isSmallScreen,
        ),
        _buildServiceCard(
          context,
          6,
          "Recruiting and Training",
          "Training enumerators to perform ethical interviews",
          "Recruiting and training enumerators involves selecting qualified individuals for data collection tasks and equipping them with the necessary skills. This includes thorough onboarding, clear instructions, and practical training.",
          "field2.jpg",
          isSmallScreen,
        ),
        _buildServiceCard(
          context,
          7,
          "Support and Mentorship",
          "Support others through mentorship",
          "Support and mentorship involve guiding individuals through challenges while fostering their personal and professional growth. It includes providing advice, sharing knowledge, and creating a nurturing environment for development.",
          "mentors.jpg",
          isSmallScreen,
          isHorizontal: true,
        ),
        _buildServiceCard(
          context,
          8,
          "Research Deployment",
          "Deploying research proposal to local context",
          "Adaptation and deployment of a research proposal involve tailoring the methodology to fit specific contexts and ensuring its effective implementation. This process prioritizes ethical considerations and systematic execution.",
          "support2.jpg",
          isSmallScreen,
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    int index,
    String title,
    String subtitle,
    String description,
    String imagePath,
    bool isSmallScreen, {
    bool isHorizontal = false,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _imageScales[index] = 1.05;
        _cardElevations[index] = 8.0;
      }),
      onExit: (_) => setState(() {
        _imageScales[index] = 1.0;
        _cardElevations[index] = 2.0;
      }),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: isSmallScreen
            ? MediaQuery.of(context).size.width
            : (isHorizontal ? 500 : 450),
        constraints: BoxConstraints(
          minHeight: isHorizontal ? 350 : 400,
          maxHeight: isHorizontal ? 400 : 450,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: _cardElevations[index] * 2,
              offset: Offset(0, _cardElevations[index]),
            ),
          ],
        ),
        child: isHorizontal
            ? _buildHorizontalCard(
                context, index, title, subtitle, description, imagePath)
            : _buildVerticalCard(
                context, index, title, subtitle, description, imagePath),
      ),
    );
  }

  Widget _buildVerticalCard(
    BuildContext context,
    int index,
    String title,
    String subtitle,
    String description,
    String imagePath,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.baloo2(
              fontSize: 16,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.baloo2(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    description,
                    style: GoogleFonts.baloo2(
                      fontSize: 15,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Learn more →",
                    style: GoogleFonts.baloo2(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          AnimatedScale(
            scale: _imageScales[index],
            duration: Duration(milliseconds: 200),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCard(
    BuildContext context,
    int index,
    String title,
    String subtitle,
    String description,
    String imagePath,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.baloo2(
                    fontSize: 16,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.baloo2(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          description,
                          style: GoogleFonts.baloo2(
                            fontSize: 15,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Learn more →",
                          style: GoogleFonts.baloo2(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          AnimatedScale(
            scale: _imageScales[index],
            duration: Duration(milliseconds: 200),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 300,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
