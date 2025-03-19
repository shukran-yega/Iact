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
          collapsedHeight: MediaQuery.of(context).size.height * 0.1,
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              stretchModes: const [StretchMode.blurBackground],
              expandedTitleScale: 1,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Space out elements
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left: Logo
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "iact.png",
                        height: 70,
                        width: 70,
                      ),
                    ),

                    // Center: TabBar wrapped in Column to align center
                    Expanded(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Center vertically
                        children: [
                          TabBar(
                            splashBorderRadius: BorderRadius.circular(50),
                            controller: tabController,
                            isScrollable: true,
                            //indicatorPadding: const EdgeInsets.only(right: 30),
                            indicatorColor: Colors.redAccent,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            unselectedLabelColor: Colors.grey,
                            labelColor: Colors.redAccent,
                            tabs: const [
                              Tab(text: 'Home'),
                              Tab(text: 'Services'),
                              Tab(text: 'Portfolio'),
                              Tab(text: 'Team'),
                              //   Tab(text: 'Contact'),
                            ],
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
