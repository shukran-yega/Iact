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
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blue.shade900.withOpacity(0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Section - Logo & Description
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Links
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("Quick Links"),
                  _buildHoverableLink(
                    context,
                    "Research reference",
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Download of research reference will start shortly"),
                        backgroundColor: Colors.blue.shade900,
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ));
                      const String fileUrl = "assets/IACTProfile.pdf";
                    },
                  ),
                  _buildHoverableLink(
                    context,
                    "Announcements",
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("There are no announcements right now"),
                          backgroundColor: Colors.blue.shade900,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                  _buildHoverableLink(
                    context,
                    "Blog",
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Web Blog is currently unavailable"),
                          backgroundColor: Colors.blue.shade900,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                  _buildHoverableLink(
                    context,
                    "Events",
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("No events to report, try again later"),
                          backgroundColor: Colors.blue.shade900,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              // Contact Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("Contact Us"),
                  _buildContactItem(Icons.phone, "+255 743 262 932"),
                  _buildContactItem(Icons.email, "support@iact.co.tz"),
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
                    child: _buildContactItem(
                        Icons.location_on, "Dar es Salaam, Tanzania"),
                  ),
                ],
              ),

              // Logo & Description
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      "logo.png",
                      height: 60,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Ideas in Action - IACT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Innovating solutions for a better future.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Separator Line
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Bottom Section - Copyright & Socials
          Column(
            children: [
              // Social Media Links
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(
                    context,
                    Icons.facebook,
                    "https://web.facebook.com/iact.or.tz?_rdc=1&_rdr#",
                  ),
                  const SizedBox(width: 20),
                  _buildSocialIcon(
                    context,
                    Icons.email,
                    "mailto:support@iact.co.tz",
                  ),
                  const SizedBox(width: 20),
                  _buildSocialIcon(
                    context,
                    Icons.youtube_searched_for,
                    "https://www.youtube.com/@iact",
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Copyright & Version
              Text(
                "© 2025 IACT - Ideas in Action. All Rights Reserved.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white60,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                "Version: 1.0.6",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white60,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHoverableLink(
      BuildContext context, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white70,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () async {
          if (!await launchUrl(Uri.parse(url))) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Failed to open the link"),
                backgroundColor: Colors.redAccent,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
