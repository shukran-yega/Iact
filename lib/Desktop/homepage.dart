import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iact/Desktop/Footer.dart';
import 'package:iact/widgets/StyledImageContainers.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
                        child: RichText(
                          text: TextSpan(
                            text: "From ",
                            style: GoogleFonts.baloo2(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Default color
                            ),
                            children: [
                              TextSpan(
                                text: "insights ",
                                style: GoogleFonts.baloo2(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent, // Highlighted in red
                                ),
                              ),
                              TextSpan(
                                  text: "to",
                                  style: GoogleFonts.baloo2(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black, //
                                  )),
                              TextSpan(
                                text: " innovation",
                                style: GoogleFonts.baloo2(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent, // Default color
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Transforming bold ideas into actionable insights \nthrough innovation and data- driven strategies",
                          style: GoogleFonts.baloo2(
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Text(
                        "At IACT, we turn ideas into reality by providing innovative solutions\nthat bridge the gap between technology and community impact. "
                        "\nwe empower businesses and individuals to bring their visions to life \nwith efficiency and creativity.",
                        style: GoogleFonts.baloo2(
                          fontSize: 18,
                          color: Colors.black87, // Adjust as needed
                          height: 1.5, // Improves readability
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.23,
                        height: 100,
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.shade100
                              .withOpacity(0.2), // Light red background
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
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 20),
                      //   child: ElevatedButton(
                      //     onPressed: () {},
                      //     style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius:
                      //             BorderRadius.circular(30), // Rounded button
                      //       ),
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 24, vertical: 20), // Better padding
                      //       backgroundColor:
                      //           Colors.redAccent, // Customize as needed
                      //     ),
                      //     child: const Text(
                      //       "Book Appointment",
                      //       style: TextStyle(color: Colors.white, fontSize: 16),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                const StyledImageGrid(
                    imagePath1: "pic1.jpg",
                    imagePath2: "meeting.jpg",
                    imagePath3: "PIC2.jpg")
                // Lottie.asset("tech.json",
                //     width: 540, height: 500, fit: BoxFit.contain)
              ],
            ),
            // second row
            // Padding(
            //   padding: const EdgeInsets.only(left: 80, right: 80),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     //spacing: 10,
            //     children: [CompaniesWorkedWith(), WhatIactDoes()],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 30),
            //   child: AboutIact(),
            // ),
            //Ideas()
            SizedBox(
              height: 50,
            ),
            IACTFooter()
          ],
        ),
      ),
    );
  }
}
