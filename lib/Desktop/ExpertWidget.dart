import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpertSection extends StatelessWidget {
  const ExpertSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          return true;
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Parallax Image
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedBuilder(
                    animation: Scrollable.of(context).position,
                    builder: (context, child) {
                      double scrollOffset =
                          Scrollable.of(context).position.pixels;
                      double move = (scrollOffset * 0.3).clamp(-10, 10);

                      return Transform.translate(
                        offset: Offset(0, move),
                        child: child,
                      );
                    },
                    child: Image.asset(
                      "experts.jpg",
                      fit: BoxFit.cover,
                    ),
                  );
                },
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
      ),
    );
  }
}
