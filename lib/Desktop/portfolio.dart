import 'package:flutter/material.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.0,
            mainAxisSpacing: 2,
          ),
          children: [
            _buildPortfolioItem(
              imagePath: "ihi.jpg",
              title: "Windows-based Online Virtual Machine",
              details:
                  "Custom dedicated online Windows-based server for hosting dedicated online services such as IIS, ASP.NET Controller, and MS SQL Server. Our online virtual servers can be configured with a static IP address, remote desktop connection, as well as base system modifications (kernel modifications). You can also configure script backups (cron jobs) or a complete snapshot of the server.",
            ),
            _buildPortfolioItem(
              imagePath: "twaweza.jpg",
              title: "Mbunge Live Project Pilot Survey",
              details:
                  "iDeas in Action conducted a two-pilot study for the survey in two constituencies: Tarime Rural and Nzega. The overall purpose of this assignment is to explore the short-term and potential long-term effects of the Mbunge live show intervention. The two pilot episodes were screened live using mobile cinema in 10 wards of each of the MPs' constituencies; the screenings were similar to a village meeting. Pre- and post-interviews were conducted with randomly selected respondents. The research team covered about half of the wards in each constituency using a mixed-method exercise, as appropriate to the theme/topic of exploration.",
            ),
            _buildPortfolioItem(
              imagePath: "toronto.jpg",
              title: "Data Collection on Diagnosing Energy",
              details:
                  "FERN Marketing wished to obtain data on product sales and key performance indicators. We provided data management support—designing and customizing data collection tools, programming of data tools, data hosting, data cleaning, and data processing. We provided an online dashboard to give their clients summarized key performance indicators. Through FERN, we have indirectly worked with telecom companies in Tanzania (Tigo and Vodacom) and other companies such as Philip Morris International Tanzania (PMI).",
            ),
            _buildPortfolioItem(
              imagePath: "aaph.jpg",
              title: "Linux-based Online Virtual Servers",
              details:
                  "Custom dedicated online servers for hosting dedicated online applications such as web and data servers, online repositories, mail clients, and so forth. Our online virtual servers can be configured for direct secure shell connection (SSH) as well as base system modifications (kernel modifications). You can also configure script backups (cron jobs) or a complete snapshot of the server.",
            ),
            _buildPortfolioItem(
              imagePath: "pact.jpg",
              title: "Bridge Data Migration (DHIS2 Data Linkage)",
              details:
                  "With PACT Tanzania, we developed an online bridge application to DHIS2. DHIS2 is a famous data warehouse for online data collection via web forms. DHIS2 can also be configured for different types of data collection including mobile and machine-to-machine using Access Program Interfaces (APIs). Despite wide usage, DHIS2 has flexibility limitations on how to manipulate or modify some specific aspects of its data. With PACT Tanzania, we worked on a custom-designed solution to specifically address this challenge, and we were able to develop a bridge that acts as a pipe for advanced features to DHIS2 data.",
            ),
            _buildPortfolioItem(
              imagePath: "t4d.jpg",
              title: "Data collection for Transparency for Development",
              details:
                  "Transparency for Development (T4D) is a project led jointly by the Harvard Kennedy School and the Results for Development Institute in collaboration with the Clinton Health Access Initiative (CHAI), and is designed to assess whether well-designed transparency and accountability (T/A) interventions improve maternal and neonatal health (MNH) outcomes, and under what conditions within 100 sampled communities within the Dodoma and Tanga regions. iAct recruited and trained field enumerators, as well as, collected qualitative and quantitative data for that particular survey and provided data management support.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioItem({
    required String imagePath,
    required String title,
    required String details,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black), // Border even when collapsed
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
          color: Colors.white, // Background color to avoid transparency
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          tilePadding: EdgeInsets.zero,
          childrenPadding: const EdgeInsets.all(10),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imagePath, height: 100, fit: BoxFit.contain),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                details,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
