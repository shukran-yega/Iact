import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileLayout extends StatefulWidget {
  final Widget child;
  const MobileLayout({super.key, required this.child});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor:
            Colors.white.withOpacity(0.2), // semi-transparent glass look
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              color: Colors.white
                  .withOpacity(0.2), // Optional: overlay for frosty feel
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.blue.shade900),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Image.asset('logo.png', height: 40),
        centerTitle: true,
      ),
      drawer: _buildDrawer(context),
      body: widget.child,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'logo.png',
                  height: 40,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  'Ideas in Action',
                  style: GoogleFonts.baloo2(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            Icons.home,
            'Home',
            '/',
            location == '/',
          ),
          _buildDrawerItem(
            context,
            Icons.work,
            'Services',
            '/services',
            location == '/services',
          ),
          _buildDrawerItem(
            context,
            Icons.folder,
            'Portfolio',
            '/portfolio',
            location == '/portfolio',
          ),
          _buildDrawerItem(
            context,
            Icons.people,
            'Team',
            '/team',
            location == '/team',
          ),
          _buildDrawerItem(
            context,
            Icons.info,
            'About',
            '/about',
            location == '/about',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    String route,
    bool isSelected,
  ) {
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
        Navigator.pop(context); // Close drawer
        if (!isSelected) {
          context.go(route);
        }
      },
    );
  }
}
