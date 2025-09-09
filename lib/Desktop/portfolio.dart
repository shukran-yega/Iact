import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 40.0),
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
                  isImageLeft: false,
                  context,
                  "Scientific Research",
                  "Data collection on water quality assessment for remote sites using LETZTEST mobile equipment",
                  "Ground experience to providing water quality assessment solutions using "
                      "LETZTEST|https://letztest.com/ products, a German-based company manufacturing high quality and reliable water testing products. "
                      "Our approach involves remote sites sample collection and testing using mobile laboratory technology.",
                  "field14.jpg",
                  "emblem.png",
                  "Ministry of Water - Tanzania with support from KfW Bank"),
              SizedBox(height: 60),
              _buildPortfolioItem(
                context,
                "Microbiological water properties assessment",
                "Impact evaluation of the SCRP in the Simiyu Region",
                "As part of the pre-study exercise conducted for the impact evaluation of the "
                    "Simiyu Climate Resilience Project|https://www.simiyu-cr-project.org/index.php/en/ (SCRP), iACT conducted guided field data collection on water samples and "
                    "perform pre-processing to support investigation for physical, chemical and microbiological water properties of the 272 sampled water sources scattered around 90 villages in the Simiyu Region. ",
                "water.png",
                "emblem.png",
                "Ministry of Water - Tanzania with support from KfW Bank",
                isImageLeft: true,
              ),
              SizedBox(height: 60),
              _buildPortfolioItem(
                context,
                "Mbunge Live Project",
                "Exploring the short term and long term effects of Mbunge live show intervention",
                "iDeas in Action conducted a two-pilot study for the survey in two constituencies: "
                    "Tarime Rural and Nzega. The overall purpose of this assignment "
                    "is to explore the short-term and potential long-term effects of the Mbunge live show intervention. The two pilot episodes were screened live using mobile cinema in 10 wards of each of the MPs' constituencies; the screenings were similar to a village meeting. Pre- and post-interviews were conducted with randomly selected respondents. The research team covered about half of the wards in each constituency using a mixed-method exercise, as appropriate to the theme/topic of exploration.",
                "field13.png",
                "twaweza.jpg",
                "Twaweza",
                isImageLeft: false,
                sourceUrl:
                    'https://twaweza.org/wp-content/uploads/2021/02/Brief_MbungeLive-Brief.pdf',
              ),
              SizedBox(height: 60),
              _buildPortfolioItem(
                context,
                "Market Research",
                "Digital data collection on product sales and key performance indicators, Fern marketing Tanzania.",
                "FERN Marketing wished to obtain data on product "
                    "sales and key performance indicators on selected clients."
                    " We provided data management support which included to design data collection tools,"
                    " program digital data captures, online data hosting and data processing "
                    "including data cleaning and analytical investigations. In addition,"
                    " we provided online dash board with summary key performance indicators. Through FERN, we also worked (indirectly) with telecom companies Tigo and Vodacom) and Philip Morris International Tanzania (PMI)",
                "fern_1.png",
                "fernLogo.png",
                "Fern",
                isImageLeft: true,
              ),
              SizedBox(height: 60),
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
              SizedBox(height: 60),
              _buildPortfolioItem(
                context,
                "Data Collection on diagnosing energy",
                "A spatial planning approach on energy-efficient and resilient in urban development, Dar es Salaam",
                "iDeas In Action was engaged to carry out the digitization of the questionnaire/survey and data collection (in the field) for the IGC-Funded Small Project: Diagnosing energy-efficient and resilient urban development in Dar es Salaam. iACT supported field work preparation (i.e., processing COSTECH research permits, introduction letters to local governments and adapting, optimizing and customizing data collection tools), provide help with recruitment and training of field enumerators, translate data collection tools to Kiswahili, provide data management support, and carry out a residential energy use survey for 1328 households in Dar es salaam in eight (8) sampled wards (i.e., Keko, Buguruni, Manzese, Mwananyamala, Sinza, Mbezi beach, Masaki and Kimara) ",
                "field8.jpg",
                "ut.png",
                "The International Growth Centre (IGC),\nLondon School of Economics & University of Toronto, Canada, 2018",
                isImageLeft: true,
              ),
              SizedBox(height: 60),
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
              SizedBox(height: 60),
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
              SizedBox(height: 60),
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
    bool isImageLeft = false,
    String? sourceUrl,
  }) {
    // Build the text spans for the description (keeps your existing link parsing logic)
    final List<TextSpan> descriptionTextSpans = [];

    if (description.contains('Simiyu Climate Resilience Project|')) {
      final regex = RegExp(r'Simiyu Climate Resilience Project\|([^\s]+)');
      final match = regex.firstMatch(description);

      if (match != null) {
        final url = match.group(1)!;
        final parts = description.split(regex);

        if (parts[0].isNotEmpty) {
          descriptionTextSpans.add(
            TextSpan(
              text: parts[0],
              style: GoogleFonts.baloo2(
                  fontSize: 16, color: Colors.black87, height: 1.6),
            ),
          );
        }

        descriptionTextSpans.add(
          TextSpan(
            text: "Simiyu Climate Resilience Project",
            style: GoogleFonts.baloo2(
              fontSize: 16,
              color: Colors.blue.shade900,
              decoration: TextDecoration.underline,
              height: 1.6,
            ),
            recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(url),
          ),
        );

        if (parts.length > 1 && parts[1].isNotEmpty) {
          descriptionTextSpans.add(
            TextSpan(
              text: parts[1],
              style: GoogleFonts.baloo2(
                  fontSize: 16, color: Colors.black87, height: 1.6),
            ),
          );
        }
      }
    } else if (description.contains('|')) {
      final parts = description.split(' ');
      for (int i = 0; i < parts.length; i++) {
        if (parts[i].contains('|')) {
          final linkParts = parts[i].split('|');
          final text = linkParts[0];
          final url = linkParts[1];
          descriptionTextSpans.add(
            TextSpan(
              text: text,
              style: GoogleFonts.baloo2(
                fontSize: 16,
                color: Colors.blue.shade900,
                decoration: TextDecoration.underline,
                height: 1.6,
              ),
              recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(url),
            ),
          );
          if (i < parts.length - 1)
            descriptionTextSpans.add(TextSpan(text: ' '));
        } else {
          descriptionTextSpans.add(
            TextSpan(
              text: parts[i] + (i < parts.length - 1 ? ' ' : ''),
              style: GoogleFonts.baloo2(
                  fontSize: 16, color: Colors.black87, height: 1.6),
            ),
          );
        }
      }
    } else {
      descriptionTextSpans.add(
        TextSpan(
          text: description,
          style: GoogleFonts.baloo2(
              fontSize: 16, color: Colors.black87, height: 1.6),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: Offset(0, 10))
        ],
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final isNarrow =
            constraints.maxWidth < 900; // threshold for responsive switch

        // Image box (keeps intrinsic constraints but allows expansion in wide layout)
        Widget imageBox = ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 420,
            // allow full width on narrow, constrain on wide via Flexible below
            maxWidth: isNarrow ? double.infinity : constraints.maxWidth * 0.45,
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox.expand(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (sourceUrl != null)
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: InkWell(
                    onTap: () => _launchUrl(sourceUrl),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.link, size: 16, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'View Source',
                            style: GoogleFonts.baloo2(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );

        // Details column (title, subtitle, description, partner)
        Widget detailsColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.baloo2(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                subtitle,
                style: GoogleFonts.baloo2(
                    fontSize: 18,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 16),
            // Description: allow wrapping and multiple lines; use Text.rich so recognizers work and text wraps
            Text.rich(
              TextSpan(children: descriptionTextSpans),
              softWrap: true,
            ),
            SizedBox(height: 18),
            // Partner row
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 5))
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(partnerImage, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    partnerName,
                    style: GoogleFonts.baloo2(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade900),
                  ),
                ),
              ],
            ),
          ],
        );

        if (isNarrow) {
          // On narrow screens respect isImageLeft by controlling order
          // NOTE: isImageLeft == true means image should appear on the right
          // (so show details first, image second). When false show image first.
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: isImageLeft
                ? [
                    detailsColumn,
                    SizedBox(height: 20),
                    imageBox,
                  ]
                : [
                    imageBox,
                    SizedBox(height: 20),
                    detailsColumn,
                  ],
          );
        } else {
          // Wide: use Flexible so both sides size predictably
          final imageSide = Flexible(flex: 45, child: imageBox);
          final detailsSide = Flexible(
              flex: 55,
              child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: detailsColumn,
              ));

          // When isImageLeft == true we want the image on the right,
          // therefore the left side must be the details and the right side the image.
          final left = isImageLeft ? detailsSide : imageSide;
          final right = isImageLeft ? imageSide : detailsSide;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              left,
              SizedBox(width: 30),
              right,
            ],
          );
        }
      }),
    );
  }
}
