import 'dart:html' as html show window;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iact/Desktop/AboutUs.dart';
import 'package:iact/Desktop/ServicesPage.dart';
import 'package:iact/Desktop/homepage.dart';
import 'package:iact/Desktop/portfolio.dart';
import 'package:iact/widgets/StaffLoginPopup.dart';


bool isSigned = false; // check for authenticated user
class CustomNavigationBar extends StatefulWidget {
  final TabController tabController;

  CustomNavigationBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  
  //used to check if user is authorized and can upload into a backend
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
                              alignment: Alignment.center,
                              children: [
                                // Realistic Shadow Layer: more offset, blurred, and semi-transparent
                                Positioned(
                                  top: 2, // More offset down
                                  left: 2, // More offset right
                                  child: Image.asset(
                                    "logo.png",
                                    height: 70,
                                    width: 70,
                                    color: Colors.black
                                        .withOpacity(0.18), // Soft, dark shadow
                                    // You can use a blurred version of the logo for even more realism
                                  ),
                                ),
                                // Main Logo Image
                                Image.asset(
                                  "logo.png",
                                  height: 70,
                                  width: 70,
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
                                    controller: widget.tabController,
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
                        Padding(
                          padding: const EdgeInsets.only(right: 40, bottom: 3),
                          child: IconButton(
                            icon: Icon(
                              Icons.person,
                              color: Colors.blue.shade900,
                            ),
                            onPressed: () {
                              showDialog(
                            context: context,
                            builder: (BuildContext context) {
                            return const StaffLoginPopup();
                             },
                            );
                              
                            },
                          ),
                        )
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
        controller: widget.tabController,
        physics: BouncingScrollPhysics(),
        children: [
          Homepage(tabController: widget.tabController),
          ServicePage(tabController: widget.tabController),
          PortfolioPage(),
          Aboutus(),
        
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
