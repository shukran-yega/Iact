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
        backgroundColor: Colors.white,
        elevation: 0,
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
              context,
              'Home',
              Icons.home_outlined,
              '/',
            ),
            _buildDrawerItem(
              context,
              'Services',
              Icons.miscellaneous_services_outlined,
              '/services',
            ),
            _buildDrawerItem(
              context,
              'Portfolio',
              Icons.work_outline,
              '/portfolio',
            ),
            _buildDrawerItem(
              context,
              'Team',
              Icons.people_outline,
              '/team',
            ),
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

  Widget _buildDrawerItem(
      BuildContext context, String title, IconData icon, String route) {
    final bool isSelected = ModalRoute.of(context)?.settings.name == route;

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
          context.go(route); // Navigate using GoRouter
        }
      },
    );
  }
}
