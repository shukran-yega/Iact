import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iact/Desktop/Footer.dart';
import 'package:iact/widgets/StyledImageContainers.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        //physics: ClampingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Ideas to Action",
                              style: GoogleFonts.baloo2(
                                  fontSize: 25, letterSpacing: 7),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
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
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  TextSpan(
                                      text: "to",
                                      style: GoogleFonts.baloo2(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                  TextSpan(
                                    text: " innovation",
                                    style: GoogleFonts.baloo2(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              textAlign: TextAlign.justify,
                              "Transforming bold ideas into actionable insights \nthrough innovation and data- driven strategies",
                              style: GoogleFonts.baloo2(
                                fontSize: 28,
                              ),
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.justify,
                            "At IACT, we turn ideas into reality by providing innovative solutions\nthat bridge the gap between technology and community impact. "
                            "\nwe empower businesses and individuals to bring their visions to life \nwith efficiency and creativity.",
                            style: GoogleFonts.baloo2(
                              fontSize: 18,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.23,
                            height: 100,
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.shade100.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent.shade200,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                      children: [
                                        TextSpan(
                                            text:
                                                "For general inquiries, email us at: "),
                                        TextSpan(
                                          text: "info@iact.co.tz",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent.shade700,
                                          ),
                                        ),
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
                    const StyledImageGrid(
                        imagePath1: "pic1.jpg",
                        imagePath2: "meeting.jpg",
                        imagePath3: "PIC2.jpg")
                  ],
                ),
              ],
            ),
          ),
          Baseline(
              baseline: 100,
              baselineType: TextBaseline.alphabetic,
              child: IACTFooter())
        ],
      ),
    );
  }
}
