import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpertSection extends StatelessWidget {
  const ExpertSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Parallax Image
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.black.withOpacity(0.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "experts.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Text Content
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Expertise You Can Trust",
                    style: GoogleFonts.baloo2(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "IACT boasts a team of highly skilled professionals, each an expert in their respective fields."
                    "\nFrom software development to data analytics, our staff excels in creating innovative, scalable solutions."
                    "\n\nWith years of experience, we deliver cutting-edge applications, research tools, and secure hosting services."
                    "\nAt IACT, excellence isn’t just a goal—it’s the standard we uphold in every project we undertake.",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.baloo2(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Contact Information
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900.withOpacity(0.8),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit_note_outlined,
                            color: Colors.blue.shade900,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              children: [
                                const TextSpan(
                                  text: "To learn more about our portfolio: ",
                                ),
                                TextSpan(
                                  text: "info@iact.co.tz",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amberAccent,
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
          ),
        ],
      ),
    );
  }
}
