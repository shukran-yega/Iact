import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobilePortfolioPage extends StatelessWidget {
  const MobilePortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
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
                      text: "Portfolio",
                      style: GoogleFonts.baloo2(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Explore our successful projects and collaborations",
                textAlign: TextAlign.center,
                style: GoogleFonts.baloo2(
                  fontSize: 18,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              _buildPortfolioItem(
                context,
                "Mbunge Live Project Pilot Survey",
                "Exploring the short term and long term effects of Mbunge live show intervention",
                "iDeas in Action conducted a two-pilot study for the survey in two constituencies: Tarime Rural and Nzega. The overall purpose of this assignment is to explore the short-term and potential long-term effects of the Mbunge live show intervention. The two pilot episodes were screened live using mobile cinema in 10 wards of each of the MPs' constituencies; the screenings were similar to a village meeting. Pre- and post-interviews were conducted with randomly selected respondents. The research team covered about half of the wards in each constituency using a mixed-method exercise, as appropriate to the theme/topic of exploration.",
                "field.jpg",
                "twaweza.jpg",
                "Twaweza",
              ),
              const SizedBox(height: 40),
              _buildPortfolioItem(
                context,
                "Data collection for Transparency for Development",
                "Designed to access the intervention aimed at improving maternal and neonatal health",
                "Transparency for Development (T4D) is a project led jointly by the Harvard Kennedy School and the Results for Development Institute in collaboration with the Clinton Health Access Initiative (CHAI), and is designed to assess whether well-designed transparency and accountability (T/A) interventions improve maternal and neonatal health (MNH) outcomes, and under what conditions within 100 sampled communities within the Dodoma and Tanga regions. iAct recruited and trained field enumerators, as well as, collected qualitative and quantitative data for that particular survey and provided data management support.",
                "field4.jpg",
                "t4d.jpg",
                "Transparency for Development",
              ),
              const SizedBox(height: 40),
              _buildPortfolioItem(
                context,
                "Data Collection on diagnosing energy",
                "FERN Marketing wished to obtain data on product sales and key performance indicators",
                "FERN Marketing wished to obtain data on product sales and key performance indicators. We provided data management support—designing and customizing data collection tools, programming of data tools, data hosting, data cleaning, and data processing. We provided an online dashboard to give their clients summarized key performance indicators. Through FERN, we have indirectly worked with telecom companies in Tanzania (Tigo and Vodacom) and other companies such as Philip Morris International Tanzania (PMI).",
                "PIC2.jpg",
                "toronto.jpg",
                "Toronto University",
              ),
              const SizedBox(height: 40),
              _buildPortfolioItem(
                context,
                "Windows-based Online virtual Machine",
                "For hosting dedicated online servers such as ASP.NET and MS SQL",
                "Custom dedicated online Windows-based server for hosting dedicated online services such as IIS, ASP.NET Controller, and MS SQL Server. Our online virtual servers can be configured with a static IP address, remote desktop connection, as well as base system modifications (kernel modifications). You can also configure script backups (cron jobs) or a complete snapshot of the server.",
                "pic1.jpg",
                "ihi.jpg",
                "Ifakara health center",
              ),
              const SizedBox(height: 40),
              _buildPortfolioItem(
                context,
                "Linux-based Online Virtual Servers",
                "Custom dedicated online servers for hosting dedicated online applications",
                "Custom dedicated online servers for hosting dedicated online applications such as web and data servers, online repositories, mail clients, and so forth. Our online virtual servers can be configured for direct secure shell connection (SSH) as well as base system modifications (kernel modifications). You can also configure script backups (cron jobs) or a complete snapshot of the server.",
                "computer.jpg",
                "aaph.jpg",
                "AAPH",
              ),
              const SizedBox(height: 40),
              _buildPortfolioItem(
                context,
                "Bridge Data Migration (DHIS2 Data Linkage)",
                "We developed an online bridge application to DHIS2",
                "With PACT Tanzania, we developed an online bridge application to DHIS2. DHIS2 is a famous data warehouse for online data collection via web forms. DHIS2 can also be configured for different types of data collection including mobile and machine-to-machine using Access Program Interfaces (APIs). Despite wide usage, DHIS2 has flexibility limitations on how to manipulate or modify some specific aspects of its data. With PACT Tanzania, we worked on a custom-designed solution to specifically address this challenge, and we were able to develop a bridge that acts as a pipe for advanced features to DHIS2 data.",
                "dhis2.jpg",
                "pact.jpg",
                "PACT",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioItem(
    BuildContext context,
    String title,
    String subtitle,
    String description,
    String imagePath,
    String partnerImage,
    String partnerName,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.baloo2(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              subtitle,
              style: GoogleFonts.baloo2(
                fontSize: 16,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.baloo2(
              fontSize: 14,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      partnerImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  partnerName,
                  style: GoogleFonts.baloo2(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue.shade900,
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
