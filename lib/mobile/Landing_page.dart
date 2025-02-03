import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iact/widgets/Buttons.dart';
import 'package:iact/widgets/CollaboratedGlass.dart';
import 'package:lottie/lottie.dart';

class LandingPageMobile extends StatefulWidget {
  const LandingPageMobile({super.key});

  @override
  State<LandingPageMobile> createState() => _LandingPageMobileState();
}

class _LandingPageMobileState extends State<LandingPageMobile>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20),

                    // Center: TabBar Navigation
                    Expanded(
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        controller: tabController,
                        isScrollable: true,
                        indicatorPadding: const EdgeInsets.only(right: 30),
                        indicatorColor: Colors.black,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black, // Plain black text
                        ),
                        unselectedLabelColor: Colors.grey,
                        labelColor:
                            Colors.red, // Ensure active tab is also black
                        tabs: const [
                          Tab(text: 'Home   /'),
                          Tab(text: 'Services   /'),
                          Tab(text: 'Portfolio   /'),
                          Tab(text: 'About   /'),
                          Tab(text: 'Contact'),
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: Text(
                "Ideas to Action",
                style: GoogleFonts.baloo2(
                    fontSize: 24,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ),
          ),

          // Subtitle
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: Text(
                "From insights to innovation",
                style: GoogleFonts.baloo2(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Text(
                "Transforming bold ideas into actionable insights through \n innovation and data-driven strategies.",
                style: GoogleFonts.baloo2(
                    fontSize: 28,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ),
          ),

          Center(
            child: Lottie.asset("assets/tech.json",
                width: 540, height: 500, fit: BoxFit.contain),
          ),

          // Animation
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Our Work",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Share an idea",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ),

          // Sections
          const SizedBox(height: 20),
          Center(child: CompaniesWorkedWith()),
          const SizedBox(height: 20),
          //Center(child: WhatIactDoes()),
        ],
      ),
    );
  }
}
