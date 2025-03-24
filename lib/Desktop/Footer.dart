import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse(
    "https://www.google.com.au/maps/place/PSSSF+COMMERCIAL+COMPLEX/@-6.7791121,39.217825,17.35z/"
    "data=!4m6!3m5!1s0x185c4f1cfe233113:0xa57f6ec7db3aa101!8m2!3d-6.7794547!"
    "4d39.217617!16s%2Fg%2F11qm3t8p9j?entry=ttu&g_ep=EgoyMDI1MDMwOC4wIKXMDSoASAFQAw%3D%3D");

class IACTFooter extends StatelessWidget {
  const IACTFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      color: Colors.blue.shade900.withOpacity(0.5), // Dark theme
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Section - Logo & Description
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo & Description
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("Quick Links"),
                  InkWell(
                      onTap: () {
                        // Path to the file (ensure it's in the 'assets' folder)
                        const String fileUrl = "assets/IACTProfile.pdf";

                        // Create a downloadable link
                        html.AnchorElement anchor =
                            html.AnchorElement(href: fileUrl)
                              ..setAttribute("download", "IACTProfile.pdf")
                              ..click();
                      },
                      child: footerLink("Research reference")),
                  InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("There are no announcement right now"),
                            backgroundColor: Colors.blueAccent,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: footerLink("Announcements")),
                  InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Web Blog is currently unavailable"),
                            backgroundColor: Colors.blueAccent,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: footerLink("Blog")),
                  InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("No events to report, try again later"),
                            backgroundColor: Colors.blueAccent,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: footerLink("Events")),
                ],
              ),

              // Quick Links
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("Contact Us"),
                  footerText("📞 +255 743 262 932"),
                  const SizedBox(height: 10),
                  footerText("📧 support@iact.co.tz"),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      if (!await launchUrl(_url)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Failed to open Google Maps"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: footerText("📍 Dar es Salaam, Tanzania"),
                  ),
                ],
              ),

              // Contact Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "logo.png", // Replace with actual IACT logo
                    height: 50,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Ideas in Action - IACT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Innovating solutions for a better future.",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Separator Line
          const Divider(color: Colors.white24, thickness: 0.5),

          const SizedBox(height: 15),

          // Bottom Section - Copyright & Socials
          Column(
            children: [
              // Social Media Links
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //socialIcon("assets/facebook.png"),
                  InkWell(
                      onTap: () async {
                        Uri facebok = Uri.parse(
                            "https://web.facebook.com/iact.or.tz?_rdc=1&_rdr#");
                        if (!await launchUrl(facebok)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Failed to open the link"),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Icon(Icons.facebook)),
                  const SizedBox(width: 10),
                  //socialIcon("assets/twitter.png"),
                  Icon(Icons.email),
                  const SizedBox(width: 10),
                  //socialIcon("assets/youtube.png"),
                  Icon(Icons.youtube_searched_for),
                ],
              ),

              const SizedBox(height: 10),

              // Copyright & Version
              Text(
                "© 2025 IACT - Ideas in Action. All Rights Reserved.",
                style: TextStyle(fontSize: 12, color: Colors.white60),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                "Version: 1.0.1",
                style: TextStyle(fontSize: 12, color: Colors.white60),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Footer Section Title
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }

  // Footer Text Links
  Widget footerLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: Colors.white70),
      ),
    );
  }

  // Footer Regular Text
  Widget footerText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: Colors.white70),
      ),
    );
  }

  // Social Media Icon
  Widget socialIcon(String assetPath) {
    return Image.asset(assetPath, height: 24, color: Colors.white70);
  }
}
