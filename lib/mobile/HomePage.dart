import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iact/mobile/MobileClientLogos.dart';
import 'package:iact/mobile/MobilePortfolioPage.dart';
import 'package:iact/mobile/MobileServicesPage.dart';
import 'package:iact/mobile/MobileTeamPage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Desktop/Footer.dart';
import '../Desktop/carauselText.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Scaffold(
        key: _scaffoldKey,
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        //   leading: IconButton(
        //     icon: Icon(Icons.menu, color: Colors.blue.shade900),
        //     onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        //   ),
        //   title: Image.asset('logo.png', height: 40),
        //   centerTitle: true,
        // ),
        drawer: _buildDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeroSection(),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5, left: 8, right: 8),
                child: TextCarousel(),
              ),
              _buildParallaxSection(),
              _buildNewsSection(),
              _buildStatsSection(),
              // Add the client logos section here
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 24, right: 24, bottom: 5),
                child: MobileClientLogos(),
              ),
              TextButton(
                  onPressed: () {
                    context.go("/portfolio");
                  },
                  child: Text(
                    "and many more ➡",
                    style: TextStyle(color: Colors.blue),
                  )),
              // create a client view that will use the goRouter like context.go("/portfolio")
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade900.withOpacity(0.1),
              ),
              child: Center(
                child: Image.asset('logo.png', height: 80),
              ),
            ),
            _buildDrawerItem(
                context, 'Home', Icons.home_outlined, 0, MobileHomePage()),
            _buildDrawerItem(context, 'Services',
                Icons.miscellaneous_services_outlined, 1, MobileServicesPage()),
            _buildDrawerItem(context, 'Portfolio', Icons.work_outline, 2,
                MobilePortfolioPage()),
            _buildDrawerItem(
                context, 'Team', Icons.people_outline, 3, MobileTeamPage()),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'IACT - Ideas in Action',
                style: GoogleFonts.baloo2(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon,
      int index, Widget page) {
    final bool isSelected = _selectedIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.blue.shade900 : Colors.grey,
      ),
      title: Text(
        title,
        style: GoogleFonts.baloo2(
          color: isSelected ? Colors.blue.shade900 : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pop(context); // Close the drawer
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 370,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(250),
          bottomRight: Radius.circular(250),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.4), // top
                  Colors.blue.shade900.withOpacity(0.4), // bottom
                ],
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ideas to Action",
                  style: GoogleFonts.baloo2(
                    fontSize: 20,
                    letterSpacing: 4,
                    color: Colors.blue.shade900.withOpacity(0.8),
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 24),
                Text.rich(
                  TextSpan(
                    text: "From ",
                    style: GoogleFonts.baloo2(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                    children: [
                      TextSpan(
                        text: "insights ",
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      TextSpan(text: "to "),
                      TextSpan(
                        text: "Products",
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Transforming bold ideas to breakthrough products, powered by innovation and insight",
                  style: GoogleFonts.baloo2(
                    fontSize: 18,
                    color: Colors.blue.shade900.withOpacity(0.6),
                    height: 1.5,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 40, 24, 40),
      height: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "experts.jpg",
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade900.withOpacity(0.1),
                    Colors.blue.shade900.withOpacity(0.3),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Expertise You Can Trust",
                    style: GoogleFonts.baloo2(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Our team excels in software development, data analytics, and AI-driven solutions.",
                    style: GoogleFonts.baloo2(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
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

  Widget _buildNewsSection() {
    final List<Map<String, String>> newsItems = [
      {
        "title": "Scientific Research",
        "description":
            "Data collection on water quality assessment for remote sites using LETZTEST mobile equipment",
        "image": "field14.jpg"
      },
      {
        "title": "Microbiological water properties assessment",
        "description":
            "Exploring the short term and long term effects of Mbunge live show intervention",
        "image": "water.png"
      },
      {
        "title": "Market Research",
        "description":
            "FERN Marketing wished to obtain data on product sales and key performance indicators on selected clients",
        "image": "fern_1.png"
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Latest Updates",
            style: GoogleFonts.baloo2(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 16),
          ...newsItems.map((news) => _buildNewsCard(news)).toList(),
        ],
      ),
    );
  }

  Widget _buildNewsCard(Map<String, String> news) {
    return InkWell(
      onTap: () {
        // navigate to mobile portfolio
        setState(() {
          _selectedIndex = 2;
        });
        context.go("/portfolio");
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                news["image"]!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news["title"]!,
                    style: GoogleFonts.baloo2(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    news["description"]!,
                    style: GoogleFonts.baloo2(
                      fontSize: 16,
                      color: Colors.black87,
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

  Widget _buildStatsSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: "Our ",
              style: GoogleFonts.baloo2(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: "Impact",
                  style: GoogleFonts.baloo2(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                      child: _buildStatItem(
                          "10+", "Creative Staff", Icons.people)),
                  Flexible(
                      child: _buildStatItem("15+", "Projects", Icons.task_alt)),
                  Flexible(
                      child: _buildStatItem("13+", "Clients", Icons.handshake)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
              border: Border.all(color: Colors.blue.shade900, width: 1.5),
            ),
            child: Icon(icon, color: Colors.blue.shade900, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            number,
            style: GoogleFonts.baloo2(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.baloo2(
              fontSize: 14,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.blue.shade900.withOpacity(0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo Section
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset('logo.png', height: 60),
          ),
          const SizedBox(height: 16),
          Text(
            "Ideas in Action - IACT",
            style: GoogleFonts.baloo2(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Innovating solutions for a better future",
            style: GoogleFonts.baloo2(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 32),

          // Quick Links Section
          Column(
            children: [
              Text(
                "Quick Links",
                style: GoogleFonts.baloo2(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              _buildFooterLink("Research reference", () {
                downloadPDFWeb();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text("Download of research reference will start shortly"),
                  backgroundColor: Colors.blue.shade900,
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ));
              }),
              _buildFooterLink("Announcements", () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("There are no announcements right now"),
                    backgroundColor: Colors.blue.shade900,
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),
              _buildFooterLink("Blog", () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("There are no blogs right now"),
                    backgroundColor: Colors.blue.shade900,
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),
              _buildFooterLink("Events", () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("There are no events right now"),
                    backgroundColor: Colors.blue.shade900,
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 32),

          // Contact Section
          Column(
            children: [
              Text(
                "Contact Us",
                style: GoogleFonts.baloo2(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              _buildContactItem(Icons.phone, "+255 743 262 932"),
              _buildContactItem(Icons.email, "support@iact.co.tz"),
              InkWell(
                  onTap: () async {
                    if (!await launchUrl(_url)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Failed to open Google Maps"),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: _buildContactItem(Icons.location_on,
                      "PSSF 2nd floor Dar es Salaam, Tanzania")),
            ],
          ),
          const SizedBox(height: 32),

          // Social Links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.facebook),
              const SizedBox(width: 20),
              _buildSocialIcon(Icons.email),
            ],
          ),
          const SizedBox(height: 32),

          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Copyright
          Text(
            "© 2025 IACT - Ideas in Action. All Rights Reserved.",
            style: GoogleFonts.baloo2(
              fontSize: 12,
              color: Colors.white60,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Version: 1.0.0",
            style: GoogleFonts.baloo2(
              fontSize: 12,
              color: Colors.white60,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: GoogleFonts.baloo2(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white70,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.baloo2(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}

final _url = Uri.parse(
    "https://www.google.com.au/maps/place/PSSSF+COMMERCIAL+COMPLEX/@-6.7791121,39.217825,17.35z/"
    "data=!4m6!3m5!1s0x185c4f1cfe233113:0xa57f6ec7db3aa101!8m2!3d-6.7794547!"
    "4d39.217617!16s%2Fg%2F11qm3t8p9j?entry=ttu&g_ep=EgoyMDI1MDMwOC4wIKXMDSoASAFQAw%3D%3D");
