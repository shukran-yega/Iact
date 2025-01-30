import 'package:flutter/material.dart';
import 'package:iact/mobile/Landing_page.dart';
import 'package:iact/widgets/NavBar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (screenWidth > 1000) {
          // Desktop layout
          return Scaffold(
              backgroundColor: Color(0xffeeeeee),
              body: CustomNavigationBar(
                  tabController: _tabController,
                  scrollController: _scrollController));
        } else {
          // Fallback for mobile layout
          return LandingPageMobile();
        }
      },
    );
  }
}
