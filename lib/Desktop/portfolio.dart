import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  text: "Our ",
                  style: GoogleFonts.baloo2(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Portfolio",
                      style: GoogleFonts.baloo2(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Explore our successful projects and collaborations",
                style: GoogleFonts.baloo2(
                  fontSize: 24,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 80),
              _buildPortfolioItem(
                context,
                "Microbiological water properties assessment",
                "Impact evaluation of the SCRP in the Simiyu Region",
                "iAs part of the pre-study exercise conducted for the impact evaluation of the Simiyu Climate Resilience Project (SCRP), iACT conducted guided field data collection on water samples and perform pre-processing to support investigation for physical, chemical and microbiological water properties of the 272 sampled water sources scattered around 90 villages in the Simiyu Region. ",
                "water.png",
                "emblem.png",
                "Ministry of Water - Tanzania with support from KfW Bank ",
                isImageLeft: false,
              ),
              SizedBox(height: 60),
              _buildPortfolioItem(
                context,
                "Mbunge Live Project Pilot Survey",
                "Exploring the short term and long term effects of Mbunge live show intervention",
                "iDeas in Action conducted a two-pilot study for the survey in two constituencies: "
                    "Tarime Rural and Nzega. The overall purpose of this assignment "
                    "is to explore the short-term and potential long-term effects of the Mbunge live show intervention. The two pilot episodes were screened live using mobile cinema in 10 wards of each of the MPs' constituencies; the screenings were similar to a village meeting. Pre- and post-interviews were conducted with randomly selected respondents. The research team covered about half of the wards in each constituency using a mixed-method exercise, as appropriate to the theme/topic of exploration.",
                "field13.png",
                "twaweza.jpg",
                "Twaweza",
                isImageLeft: true,
                sourceUrl:
                    'https://twaweza.org/wp-content/uploads/2021/02/Brief_MbungeLive-Brief.pdf',
              ),
              SizedBox(height: 80),
              _buildPortfolioItem(
                context,
                "Market Research",
                "FERN Marketing wished to obtain data on product sales and key performance indicators on selected clients.",
                "FERN Marketing wished to obtain data on product "
                    "sales and key performance indicators on selected clients."
                    " We provided data management support which included to design data collection tools,"
                    " program digital data captures, online data hosting and data processing "
                    "including data cleaning and analytical investigations. In addition,"
                    " we provided online dash board with summary key performance indicators. Through FERN, we also worked (indirectly) with telecom companies Tigo and Vodacom) and Philip Morris International Tanzania (PMI)",
                "fern_1.png",
                "fernLogo.png",
                "Fern",
                isImageLeft: false,
              ),
              SizedBox(height: 80),
              _buildPortfolioItem(
                context,
                "Data collection for Transparency for Development",
                "Designed to access the intervention aimed at improving maternal and neonatal health",
                "Transparency for Development (T4D) is a project led jointly by the Harvard Kennedy School and the Results for Development Institute in collaboration with the Clinton Health Access Initiative (CHAI), and is designed to assess whether well-designed transparency and accountability (T/A) interventions improve maternal and neonatal health (MNH) outcomes, and under what conditions within 100 sampled communities within the Dodoma and Tanga regions. iAct recruited and trained field enumerators, as well as, collected qualitative and quantitative data for that particular survey and provided data management support.",
                "field4.jpg",
                "t4d.jpg",
                "Transparency for Development",
                isImageLeft: false,
              ),
              SizedBox(height: 80),
              _buildPortfolioItem(
                context,
                "Data Collection on diagnosing energy",
                "A spatial planning approach on energy-efficient and resilient in urban development, Dar es Salaam",
                "iDeas In Action was engaged to carry out the digitization of the questionnaire/survey and data collection (in the field) for the IGC-Funded Small Project: Diagnosing energy-efficient and resilient urban development in Dar es Salaam. iACT supported field work preparation (i.e., processing COSTECH research permits, introduction letters to local governments and adapting, optimizing and customizing data collection tools), provide help with recruitment and training of field enumerators, translate data collection tools to Kiswahili, provide data management support, and carry out a residential energy use survey for 1328 households in Dar es salaam in eight (8) sampled wards (i.e., Keko, Buguruni, Manzese, Mwananyamala, Sinza, Mbezi beach, Masaki and Kimara) ",
                "field8.jpg",
                "toronto.jpg",
                "The International Growth Centre (IGC),\nLondon School of Economics & University of Toronto, Canada, 2018",
                isImageLeft: true,
              ),
              SizedBox(height: 80),
              _buildPortfolioItem(
                context,
                "Windows-based Online virtual Machine",
                "For hosting dedicated online servers such as ASP.NET and MS SQL",
                "Custom dedicated online Windows-based server for hosting dedicated online services such as IIS, ASP.NET Controller, and MS SQL Server. Our online virtual servers can be configured with a static IP address, remote desktop connection, as well as base system modifications (kernel modifications). You can also configure script backups (cron jobs) or a complete snapshot of the server.",
                "pic1.jpg",
                "ihi.jpg",
                "Ifakara health center",
                isImageLeft: false,
              ),
              SizedBox(height: 80),
              _buildPortfolioItem(
                context,
                "Linux-based Online Virtual Servers",
                "Custom dedicated online servers for hosting dedicated online applications",
                "Custom dedicated online servers for hosting dedicated online applications such as web and data servers, online repositories, mail clients, and so forth. Our online virtual servers can be configured for direct secure shell connection (SSH) as well as base system modifications (kernel modifications). You can also configure script backups (cron jobs) or a complete snapshot of the server.",
                "computer.jpg",
                "aaph.jpg",
                "African Academy for Public Health",
                isImageLeft: true,
              ),
              SizedBox(height: 80),
              _buildPortfolioItem(
                context,
                "Bridge Data Migration (DHIS2 Data Linkage)",
                "We developed an online bridge application to DHIS2",
                "With PACT Tanzania, we developed an online bridge application to DHIS2. DHIS2 is a famous data warehouse for online data collection via web forms. DHIS2 can also be configured for different types of data collection including mobile and machine-to-machine using Access Program Interfaces (APIs). Despite wide usage, DHIS2 has flexibility limitations on how to manipulate or modify some specific aspects of its data. With PACT Tanzania, we worked on a custom-designed solution to specifically address this challenge, and we were able to develop a bridge that acts as a pipe for advanced features to DHIS2 data.",
                "dhis2.jpg",
                "pact.jpg",
                "PACT",
                isImageLeft: false,
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
    String partnerName, {
    bool isImageLeft = true,
    String? sourceUrl,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final itemHeight = screenHeight * 0.73;

    return Container(
      height: itemHeight,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isImageLeft) ...[
            Expanded(
              flex: 1,
              child: Container(
                height: itemHeight * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 40),
          ],
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.baloo2(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    subtitle,
                    style: GoogleFonts.baloo2(
                      fontSize: 18,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  child: Text(
                    description,
                    style: GoogleFonts.baloo2(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 65),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            partnerImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          partnerName,
                          style: GoogleFonts.baloo2(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                      if (sourceUrl != null) ...[
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => _launchUrl(sourceUrl),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.link,
                                  size: 16,
                                  color: Colors.blue.shade900,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'View Source',
                                  style: GoogleFonts.baloo2(
                                    fontSize: 14,
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isImageLeft) ...[
            SizedBox(width: 40),
            Expanded(
              flex: 1,
              child: Container(
                height: itemHeight * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
