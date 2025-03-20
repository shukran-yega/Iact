import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'carausel_Slider.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600
        ? 1
        : screenWidth < 1200
            ? 2
            : 3;
    double itemWidth = screenWidth / crossAxisCount;
    double itemHeight = 500; // Adjust height as needed
    double childAspectRatio = itemWidth / itemHeight;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text.rich(
                            overflow: TextOverflow.visible,
                            TextSpan(
                              text: "Mbunge Live Project Pilot Survey",
                              style: GoogleFonts.baloo2(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            textAlign: TextAlign.justify,
                            "Exploring the short term and long term effects of\nMbunge live show intervention",
                            style: GoogleFonts.baloo2(fontSize: 25),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.justify,
                          "iDeas in Action conducted a two-pilot study for the survey in two constituencies:\n "
                          "Tarime Rural and Nzega. The overall purpose of this assignment is to explore \n"
                          "the short-term and potential long-term effects of the Mbunge live show intervention.\n "
                          "The two pilot episodes were screened live using mobile cinema in 10 wards of each of\n the MPs' constituencies; "
                          "the screenings were similar to a village meeting. Pre- and\n post-interviews were conducted with randomly selected respondents.\n"
                          "The research team covered about half of the wards in each constituency\n using a mixed-method exercise,\n "
                          "as appropriate to the theme/topic of exploration.",
                          style: GoogleFonts.baloo2(
                            fontSize: 18,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 100,
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900.withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 70, // Ensure a defined size
                                height: 70,
                                //padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.shade200,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(100), // Corrected
                                  child: Image.asset(
                                    "twaweza.jpg",
                                    fit: BoxFit.cover,
                                    // Use 'cover' to maintain aspect ratio
                                    width: 70,
                                    // Ensure a defined size
                                    height: 70,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Twaweza",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.7, // Ensure it has a height
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ImageCarousel(
                      imagePaths: ["field.jpg", "team.jpg", "field2.jpg"],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text.rich(
                            overflow: TextOverflow.visible,
                            TextSpan(
                              text:
                                  "Data collection for Transparency for Development",
                              style: GoogleFonts.baloo2(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            textAlign: TextAlign.justify,
                            "Designed to access the intervention "
                            "aimed at improving maternal\nand neonatal health",
                            style: GoogleFonts.baloo2(fontSize: 25),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.justify,
                          "Transparency for Development (T4D) is a project led jointly by the Harvard Kennedy School \n"
                          "and the Results for Development Institute in collaboration with the Clinton Health Access Initiative (CHAI)\n,"
                          " and is designed to assess whether well-designed transparency and accountability (T/A)\n"
                          "interventions improve maternal and neonatal health (MNH) outcomes, and under what \n"
                          "conditions within 100 sampled communities within the Dodoma and Tanga regions.\n"
                          "iAct recruited and trained field enumerators, as well as, collected qualitative\n"
                          "and quantitative data for that particular survey and provided data management support.",
                          style: GoogleFonts.baloo2(
                            fontSize: 18,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 100,
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900.withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 70, // Ensure a defined size
                                height: 70,
                                //padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.shade200,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(100), // Corrected
                                  child: Image.asset(
                                    "t4d.jpg",
                                    fit: BoxFit.cover,
                                    // Use 'cover' to maintain aspect ratio
                                    width: 70,
                                    // Ensure a defined size
                                    height: 70,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Transparency for Development",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.7, // Ensure it has a height
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ImageCarousel(
                      imagePaths: ["field4.jpg", "field5.jpg", "support2.jpg"],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text.rich(
                            overflow: TextOverflow.visible,
                            TextSpan(
                              text: "Data Collection on diagnosing energy",
                              style: GoogleFonts.baloo2(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            textAlign: TextAlign.justify,
                            "FERN Marketing wished to obtain data on product sales\n"
                            "and key performance indicators.",
                            style: GoogleFonts.baloo2(fontSize: 25),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.justify,
                          "FERN Marketing wished to obtain data on product sales and key performance indicators.\n"
                          "We provided data management support—designing and customizing data collection tools,\n"
                          "programming of data tools, data hosting, data cleaning, and data processing.\n"
                          "We provided an online dashboard to give their clients summarized key performance\nindicators."
                          "Through FERN, we have indirectly worked with telecom companies in Tanzania \n(Tigo and Vodacom)"
                          "and other companies such as Philip Morris International Tanzania (PMI).",
                          style: GoogleFonts.baloo2(
                            fontSize: 18,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 100,
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900.withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 70, // Ensure a defined size
                                height: 70,
                                //padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade900,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(100), // Corrected
                                  child: Image.asset(
                                    "toronto.jpg",
                                    fit: BoxFit.cover,
                                    // Use 'cover' to maintain aspect ratio
                                    width: 70,
                                    // Ensure a defined size
                                    height: 70,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Toronto University",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.7, // Ensure it has a height
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ImageCarousel(
                      imagePaths: ["support2.jpg", "field2.jpg", "field3.jpg"],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text.rich(
                            overflow: TextOverflow.visible,
                            TextSpan(
                              text: "Windows-based Online virtual Machine ",
                              style: GoogleFonts.baloo2(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            textAlign: TextAlign.justify,
                            "For hosting dedicated online servers such as ASP.NET\n and MS SQL",
                            style: GoogleFonts.baloo2(fontSize: 25),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.justify,
                          "Custom dedicated online Windows-based server for hosting dedicated online services such\n "
                          "as IIS,ASP.NET Controller,and MS SQL Server. Our online virtual servers can be configured with a\n"
                          "static IP address,remote desktop connection, as well as base system modifications\n "
                          "(kernel modifications).You can also configure script backups (cron jobs) or a complete\n"
                          " snapshot of the server.",
                          style: GoogleFonts.baloo2(
                            fontSize: 18,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 100,
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900.withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 70, // Ensure a defined size
                                height: 70,
                                //padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade900,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(100), // Corrected
                                  child: Image.asset(
                                    "ihi.jpg",
                                    fit: BoxFit.cover,
                                    // Use 'cover' to maintain aspect ratio
                                    width: 70,
                                    // Ensure a defined size
                                    height: 70,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Ifakara health center",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.7, // Ensure it has a height
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ImageCarousel(
                      imagePaths: ["pic1.jpg", "meeting.jpg", "PIC2.jpg"],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text.rich(
                            overflow: TextOverflow.visible,
                            TextSpan(
                              text: "Linux-based Online Virtual Servers",
                              style: GoogleFonts.baloo2(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            textAlign: TextAlign.justify,
                            "Custom dedicated online servers for hosting\ndedicated online applications",
                            style: GoogleFonts.baloo2(fontSize: 25),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.justify,
                          "Custom dedicated online servers for hosting dedicated online applications such\n as web and data servers,"
                          "online repositories, mail clients, and so forth.\n"
                          "Our online virtual servers can be configured for direct secure shell connection (SSH)\n"
                          "as well as base system modifications (kernel modifications).\n "
                          "You can also configure script backups (cron jobs) or a complete snapshot of the server.",
                          style: GoogleFonts.baloo2(
                            fontSize: 18,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 100,
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900.withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 70, // Ensure a defined size
                                height: 70,
                                //padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade900,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(100), // Corrected
                                  child: Image.asset(
                                    "aaph.jpg",
                                    fit: BoxFit.cover,
                                    // Use 'cover' to maintain aspect ratio
                                    width: 70,
                                    // Ensure a defined size
                                    height: 70,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "AAPH",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.7, // Ensure it has a height
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ImageCarousel(
                      imagePaths: ["support2.jpg", "meeting.jpg", "PIC2.jpg"],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text.rich(
                            overflow: TextOverflow.visible,
                            TextSpan(
                              text:
                                  "Bridge Data Migration (DHIS2 Data Linkage)",
                              style: GoogleFonts.baloo2(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            textAlign: TextAlign.justify,
                            " we developed an online bridge application to DHIS2",
                            style: GoogleFonts.baloo2(fontSize: 25),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.justify,
                          "With PACT Tanzania, we developed an online bridge application to DHIS2.\n"
                          "DHIS2 is a famous data warehouse for online data collection via web forms.\n"
                          "DHIS2 can also be configured for different types of data collection\n"
                          "including mobile and machine-to-machine using Access Program Interfaces (APIs).\n"
                          "Despite wide usage, DHIS2 has flexibility limitations on how to manipulate or \n"
                          "modify some specific aspects of its data. With PACT Tanzania, we worked on a custom-designed\n"
                          "solution to specifically address this challenge, and we were able to develop a bridge that acts\n"
                          "as a pipe for advanced features to DHIS2 data.",
                          style: GoogleFonts.baloo2(
                            fontSize: 18,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 100,
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900.withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 70, // Ensure a defined size
                                height: 70,
                                //padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade900,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(100), // Corrected
                                  child: Image.asset(
                                    "pact.jpg",
                                    fit: BoxFit.cover,
                                    // Use 'cover' to maintain aspect ratio
                                    width: 70,
                                    // Ensure a defined size
                                    height: 70,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "PACT",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.7, // Ensure it has a height
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ImageCarousel(
                      imagePaths: ["support2.jpg", "meeting.jpg", "PIC2.jpg"],
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
