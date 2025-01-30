import 'package:flutter/material.dart';
import 'package:iact/widgets/Buttons.dart';
import 'package:iact/widgets/CollaboratedGlass.dart';
import 'package:iact/widgets/Partners.dart';
import 'package:iact/widgets/schedule.dart';

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
          expandedHeight: MediaQuery.of(context).size.height * 0.15,
          collapsedHeight: MediaQuery.of(context).size.height * 0.155,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Column
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 60),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Turn ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: "bold ideas",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red.shade700),
                              ),
                              const TextSpan(
                                text: " into cutting-edge solutions with",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Ideas in Action",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 54,
                            color: Colors.red.shade700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Empowering businesses with ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: "state-of-the-art tools ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red.shade700),
                              ),
                              const TextSpan(
                                text:
                                    "that seamlessly integrate strategy, \ninnovation, and decision-making at scale.",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: AnimatedHoverButton(
                            hoverColor: Colors.redAccent,
                            normalColor: Colors.white,
                            label: "Start program",
                            onPressed: () {}),
                      ),
                    ],
                  ),
                  // Right Column
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        clipBehavior: Clip.none,
                        // Allows Positioned to move outside the parent boundaries
                        children: [
                          // Background Logo with Padding
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: Image.asset(
                              "/_logo.png", // Ensure the asset path is correct
                            ),
                          ),

                          // Move CompaniesWorkedWith widget down
                          Positioned(bottom: 100, child: Partners()),

                          Positioned(bottom: 50, child: schedule()),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: CompaniesWorkedWith(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: CompaniesWorkedWith(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: CompaniesWorkedWith(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
