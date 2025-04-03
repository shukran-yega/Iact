import 'dart:html' as html show window;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iact/Desktop/AboutUs.dart';
import 'package:iact/Desktop/ServicesPage.dart';
import 'package:iact/Desktop/homepage.dart';
import 'package:iact/Desktop/portfolio.dart';

class CustomNavigationBar extends StatelessWidget {
  final TabController tabController;

  const CustomNavigationBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: ClampingScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          elevation: 0,
          snap: true,
          floating: true,
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height * 0.15,
          collapsedHeight: MediaQuery.of(context).size.height * 0.15,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.8),
                ],
              ),
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: FlexibleSpaceBar(
                  collapseMode: CollapseMode.none,
                  stretchModes: const [StretchMode.blurBackground],
                  expandedTitleScale: 1,
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left: Logo with hover effect
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05),
                          child: InkWell(
                            onTap: () => html.window.location.reload(),
                            child: Stack(
                              children: [
                                // Shadow Layer
                                Positioned(
                                  top: 4,
                                  left: 4,
                                  child: Opacity(
                                    opacity: 0.3, // Adjust shadow opacity
                                    child: Image.asset(
                                      "logo.png",
                                      height: 80,
                                      width: 80,
                                      color: Colors.grey, // Shadow color
                                    ),
                                  ),
                                ),
                                // Main Image
                                Image.asset(
                                  "logo.png",
                                  height: 80,
                                  width: 80,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Center: TabBar with modern styling
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 85.0,
                                right: MediaQuery.of(context).size.width * 0.15,
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 600,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TabBar(
                                    indicatorSize: TabBarIndicatorSize.label,
                                    splashBorderRadius:
                                        BorderRadius.circular(50),
                                    controller: tabController,
                                    isScrollable: true,
                                    indicatorColor: Colors.blue.shade900,
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    unselectedLabelColor: Colors.grey.shade600,
                                    labelColor: Colors.blue.shade900,
                                    tabs: [
                                      _buildTab('Home', Icons.home_outlined),
                                      _buildTab(
                                          'Services',
                                          Icons
                                              .miscellaneous_services_outlined),
                                      _buildTab(
                                          'Portfolio', Icons.work_outline),
                                      _buildTab(
                                          'About us', Icons.people_outline),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      body: TabBarView(
        controller: tabController,
        physics: BouncingScrollPhysics(),
        children: [
          Homepage(tabController: tabController),
          ServicePage(),
          PortfolioPage(),
          Aboutus()
        ],
      ),
    );
  }

  Widget _buildTab(String text, IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}
