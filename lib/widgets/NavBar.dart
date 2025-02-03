import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iact/widgets/Buttons.dart';
import 'package:iact/widgets/CollaboratedGlass.dart';
import 'package:iact/widgets/whatWeDO.dart';
import 'package:lottie/lottie.dart';

class CustomNavigationBar extends StatelessWidget {
  final TabController tabController;
  final ScrollController scrollController;

  const CustomNavigationBar({
    Key? key,
    required this.tabController,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          snap: true,
          floating: true,
          pinned: false,
          expandedHeight: MediaQuery.of(context).size.height * 0.1,
          //collapsedHeight: MediaQuery.of(context).size.height * 0.155,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: FlexibleSpaceBar(
              stretchModes: const [StretchMode.blurBackground],
              expandedTitleScale: 1,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left: Logo Button
                    AnimatedHoverButton(
                      hoverColor: Colors.white,
                      normalColor: Colors.white,
                      label: "IACT",
                      onPressed: () {
                        print("Iact logo clicked");
                      },
                    ),
                    const SizedBox(width: 20),

                    // Center: TabBar Navigation
                    TabBar(
                      dividerColor: Colors.transparent,
                      controller: tabController,
                      isScrollable: true,
                      indicatorPadding: const EdgeInsets.only(right: 30),
                      indicatorColor: Colors.black,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.redAccent,
                      tabs: const [
                        Tab(text: 'Home   /'),
                        Tab(text: 'Services   /'),
                        Tab(text: 'Portfolio   /'),
                        Tab(text: 'About   /'),
                        Tab(text: 'Contact'),
                      ],
                    ),

                    // Spacer to align right items
                    const Spacer(),

                    // Right: Buttons (Share Idea, Menu)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: AnimatedHoverButton(
                        hoverColor: Colors.red,
                        normalColor: Colors.white,
                        icon: Icons.lightbulb_rounded,
                        label: "Share Idea",
                        onPressed: () {
                          print("Share Idea clicked");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: AnimatedHoverButton(
                        hoverColor: Colors.red,
                        normalColor: Colors.white,
                        label: "Menu",
                        icon: Icons.menu,
                        onPressed: () {
                          print("Menu clicked");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Ideas to Action",
                          style: GoogleFonts.baloo2(
                              fontSize: 24, letterSpacing: 10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "From insights to innovation",
                          style: GoogleFonts.baloo2(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Transforming bold ideas into actionable insights through \n innovation and data- driven strategies",
                          style: GoogleFonts.baloo2(
                            fontSize: 28,
                          ),
                        ),
                      ),
                      ElevatedButton(onPressed: () {}, child: Text("Our work"))
                    ],
                  ),
                ),
                Lottie.asset("tech.json",
                    width: 540, height: 500, fit: BoxFit.contain)
              ],
            ),
            // second row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //spacing: 10,
              children: [
                CompaniesWorkedWith(),
                CompaniesWorkedWith(),
                WhatIactDoes()
              ],
            )
          ],
        ),
      ),
    );
  }
}
