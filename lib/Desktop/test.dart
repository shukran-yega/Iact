import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParallaxImage extends StatelessWidget {
  final String imagePath;
  final double height;
  final TabController tabController;

  const ParallaxImage({
    Key? key,
    required this.imagePath,
    required this.height, // Ensure height is properly passed from parent
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Apply a scaling factor to shrink the widget a bit.
    final double effectiveHeight = height * 0.9; // Use 90% of provided height

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 70, // Apply horizontal padding
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(25), // Rounded corners for the image
        child: SizedBox(
          height: effectiveHeight, // Use scaled height
          child: Stack(
            children: [
              // Image container with parallax effect
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return AnimatedBuilder(
                      animation: Scrollable.of(context)!
                          .position, // Listen to scroll position
                      builder: (context, child) {
                        // Calculate vertical movement based on scroll offset
                        double scrollOffset =
                            Scrollable.of(context)!.position.pixels;
                        double move = (scrollOffset * 0.3)
                            .clamp(-effectiveHeight, effectiveHeight);
                        return Transform.translate(
                          offset: Offset(0, move), // Apply parallax translation
                          child: child,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black
                              .withOpacity(0.5), // Semi-transparent overlay
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover, // Fill container with the image
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Content overlay
              Positioned.fill(
                top: 200,
                child: Padding(
                  padding: const EdgeInsets.all(20), // Padding for text content
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center content vertically
                    children: [
                      // Title text
                      Text(
                        "Expertise You Can Trust",
                        style: GoogleFonts.baloo2(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Description text
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
                      // Contact information container
                      Container(
                        width: MediaQuery.of(context).size.width *
                            0.4, // Responsive width for contact info
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
                            // Icon container
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
                            // Contact text
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  tabController.animateTo(2);
                                },
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      const TextSpan(
                                          text:
                                              "To learn more about our portfolio: "),
                                      TextSpan(
                                        text: "click here",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amberAccent,
                                        ),
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }
}
