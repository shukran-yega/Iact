import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iact/Desktop/Footer.dart';
import 'package:iact/widgets/StyledImageContainers.dart';

import 'carauselText.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // welcome to iact
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Ideas to Action",
                        style:
                            GoogleFonts.baloo2(fontSize: 25, letterSpacing: 7),
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
                                color: Colors.redAccent,
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
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        textAlign: TextAlign.justify,
                        "Transforming bold ideas into actionable insights \nthrough innovation and data-driven strategies",
                        style: GoogleFonts.baloo2(fontSize: 28),
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
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
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
                                        "For general inquiries, email us at: ",
                                  ),
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
                imagePath3: "PIC2.jpg",
              ),
            ],
          ),
        ),
        // carasuel for services
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextCarousel(),
        ),
        // services offered
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.blueGrey.withOpacity(0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // picture
              Container(
                width: MediaQuery.of(context).size.width * 0.40,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 15, // Blur radius for softness
                      offset: Offset(5, 10), // Offset to create the 3D effect
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                  child: Image.asset(
                    "team.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // description
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Expertise You Can Trust",
                      style: GoogleFonts.baloo2(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    "IACT boasts a team of highly skilled professionals,"
                    " each an expert in their respective fields."
                    " \nFrom software development to data analytics,"
                    " our staff excels in creating innovative,\nscalable solutions."
                    " With years of experience, we deliver cutting-edge applications,\nresearch tools, and secure hosting services. "
                    " \nAt IACT, excellence isn’t just a goal—it’s the standard we uphold in every project we undertake.",
                    textAlign: TextAlign.justify,
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
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
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
                            Icons.edit_note_outlined,
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
                                  text: "To Learn more about our portfolio:",
                                ),
                                TextSpan(
                                  text: " info@iact.co.tz",
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
              )
            ],
          ),
        ),

        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          //width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // picture
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Guaranteed support",
                      style: GoogleFonts.baloo2(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    "We proudly provide an extensive three-year software support plan for all our products,"
                    "\nensuring consistent, reliable assistance regardless of whether the software is designed"
                    "\nfor mobile applications, data analysis,or research purposes. With a commitment to excellence,"
                    "\nwe go above and beyond to deliver unmatched transparency at every step of the process,"
                    "\nbuilding trust and confidence with our users.",
                    textAlign: TextAlign.justify,
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
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
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
                            Icons.support_agent,
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
                                      "To Learn more about the services we offer:",
                                ),
                                TextSpan(
                                  text: " info@iact.co.tz",
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

              // description
              Container(
                width: MediaQuery.of(context).size.width * 0.40,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 15, // Blur radius for softness
                      offset: Offset(5, 10), // Offset to create the 3D effect
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                  child: Image.asset(
                    "support.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
        // footer
        IACTFooter()
      ],
    );
  }
}
