import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iact/Desktop/Footer.dart';
import 'package:iact/Desktop/News.dart';
import 'package:iact/Desktop/test.dart';
import 'package:iact/widgets/StyledImageContainers.dart';

import 'Client.dart';
import 'Impact.dart';
import 'carauselText.dart';

class Homepage extends StatelessWidget {
  final TabController tabController;

  const Homepage({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimateGradient(
      // the gradient should be at the center  going down leave the top part and use the geomtry property as well
      primaryBegin: Alignment.center,
      // Start from the center
      primaryEnd: Alignment.bottomCenter,
      // Move directly downward
      secondaryBegin: Alignment.centerLeft,
      // Keep secondary gradient aligned
      secondaryEnd: Alignment.centerRight,
      // Also move downward
      primaryBeginGeometry: const AlignmentDirectional(0, 1),
      primaryEndGeometry: const AlignmentDirectional(0, 2),
      secondaryBeginGeometry: const AlignmentDirectional(2, 0),
      secondaryEndGeometry: const AlignmentDirectional(0, -0.8),
      primaryColors: [
        Colors.white, // Keeps the top part untouched
        Colors.white.withOpacity(0.3), // Subtle fade
      ],
      secondaryColors: [
        Colors.white, // Start with no color at the top
        Colors.grey.shade100.withOpacity(0.1), // Gradient intensifies downward
      ],
      child: ListView(
        children: [
          // welcome to iact
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Ideas to Action",
                          style: GoogleFonts.baloo2(
                              fontSize: 25, letterSpacing: 7),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text.rich(
                          overflow: TextOverflow.visible,
                          TextSpan(
                            text: "From ",
                            style: GoogleFonts.baloo2(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: "insights ",
                                style: GoogleFonts.baloo2(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              TextSpan(
                                text: "to",
                                style: GoogleFonts.baloo2(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: " products",
                                style: GoogleFonts.baloo2(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          textAlign: TextAlign.justify,
                          "Transforming bold ideas to breakthrough products, \npowered by innovation and insight",
                          style: GoogleFonts.baloo2(fontSize: 28),
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.justify,
                        "At iACT, we help our clients to turn ideas into actionable"
                        " outcomes\nby providing innovative solutions that bridge the gap between\ntechnology and community impact."
                        "We empower business and\nindividuals to bring their vision to life with efficiency and creativity",
                        style: GoogleFonts.baloo2(
                          fontSize: 18,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const StyledImageGrid(
                  imagePath1: "pic1.jpg",
                  imagePath2: "computer.jpg",
                  imagePath3: "PIC2.jpg",
                ),
              ],
            ),
          ),
          SizedBox(height: 70),
          // carasuel for services
          Padding(
            padding: EdgeInsets.only(
                top: 15, bottom: MediaQuery.of(context).size.height * 0.05),
            child: TextCarousel(),
          ),
          // services offered
          ParallaxImage(
            imagePath: "experts.jpg",
            height: MediaQuery.of(context).size.height,
            tabController: tabController,
            //width: MediaQuery.of(context).size.width,
          ),
          News(tabController: tabController),
          //ExpertSection(),
          InstitutionStats(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ClientLogosGrid(tabController: tabController),
          ),
          // footer
          IACTFooter()
        ],
      ),
    );
  }
}
