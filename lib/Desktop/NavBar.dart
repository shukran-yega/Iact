import 'package:flutter/material.dart';
import 'package:iact/Desktop/ServicesPage.dart';
import 'package:iact/Desktop/homepage.dart';
import 'package:iact/Desktop/portfolio.dart';

import 'ContactPage.dart';

class CustomNavigationBar extends StatelessWidget {
  final TabController tabController;

  const CustomNavigationBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      //controller: scrollController,
      physics: ClampingScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          elevation: 0,
          snap: true,
          floating: true,
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height * 0.15,
          collapsedHeight: MediaQuery.of(context).size.height * 0.12,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              stretchModes: const [StretchMode.blurBackground],
              expandedTitleScale: 1,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Space out elements
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left: Logo
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Image.asset(
                          "logo.png",
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ),

                    // Center: TabBar wrapped in Column to align center
                    Expanded(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Center vertically
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TabBar(
                                indicatorSize: TabBarIndicatorSize.label,
                                splashBorderRadius: BorderRadius.circular(50),
                                controller: tabController,
                                isScrollable: true,
                                //indicatorPadding: const EdgeInsets.only(right: 30),
                                indicatorColor: Colors.blue.shade900,
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                unselectedLabelColor: Colors.grey,
                                labelColor: Colors.blue.shade900,
                                tabs: const [
                                  Tab(text: 'Home'),
                                  Tab(text: 'Services'),
                                  Tab(text: 'Portfolio'),
                                  Tab(text: 'Team'),
                                  //   Tab(text: 'Contact'),
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
            ),
          ),
        ),
      ],
      body: TabBarView(
        controller: tabController,
        children: [
          Homepage(),
          ServicePage(),
          PortfolioPage(),
          Contactpage(),
        ],
      ),
    );
  }
}
