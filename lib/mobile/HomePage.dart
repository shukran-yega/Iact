import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iact/mobile/MobilePortfolioPage.dart';
import 'package:iact/mobile/MobileServicesPage.dart';
import 'package:iact/mobile/MobileTeamPage.dart';

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.blue.shade900),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          title: Image.asset('logo.png', height: 40),
          centerTitle: true,
        ),
        drawer: _buildDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeroSection(),
              _buildParallaxSection(),
              _buildNewsSection(),
              _buildStatsSection(),
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
                color: Colors.blue.shade900,
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
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 100, 24, 40),
            decoration: BoxDecoration(
              color: Colors.blue.shade900.withOpacity(0.1),
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
                        text: "innovation",
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
                  "Transforming bold ideas into actionable insights through innovation and data-driven strategies.",
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
              "assets/experts.jpg",
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade900.withOpacity(0.8),
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
        "title": "Research Innovation",
        "description": "IACT launches new AI-driven data collection platforms.",
        "image": "assets/computer.jpg"
      },
      {
        "title": "Training Excellence",
        "description": "Cutting-edge training for field researchers.",
        "image": "assets/field3.jpg"
      },
      {
        "title": "Tech Solutions",
        "description": "Custom software for streamlined data analysis.",
        "image": "assets/PIC2.jpg"
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
    return Container(
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildStatItem("15+", "Projects", Icons.work),
          _buildStatItem("13+", "Clients", Icons.people),
          _buildStatItem("5+", "Years", Icons.calendar_today),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade900,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(number,
                  style: GoogleFonts.baloo2(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900)),
              Text(label,
                  style:
                      GoogleFonts.baloo2(fontSize: 16, color: Colors.black87)),
            ],
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
              _buildFooterLink("Research reference", () {}),
              _buildFooterLink("Announcements", () {}),
              _buildFooterLink("Blog", () {}),
              _buildFooterLink("Events", () {}),
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
              _buildContactItem(Icons.location_on, "Dar es Salaam, Tanzania"),
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
              const SizedBox(width: 20),
              _buildSocialIcon(Icons.youtube_searched_for),
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
            "Version: 1.0.5",
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
