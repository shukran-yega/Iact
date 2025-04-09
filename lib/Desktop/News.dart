import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class News extends StatelessWidget {
  final TabController tabController;

  const News({
    super.key,
    required this.tabController,
  });

  void _navigateToServices() {
    tabController.animateTo(1); // Navigate to Services tab (index 1)
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> allNewsData = [
      {
        "title": "Research Innovation",
        "description":
            "IACT launches new data collection platforms integrating AI and machine learning for more efficient  operations.",
        "image": "computer.jpg"
      },
      {
        "title": "Training Excellence",
        "description":
            "Our comprehensive training program equips field researchers with cutting-edge digital tools and research methodologies.",
        "image": "field3.jpg"
      },
      {
        "title": "Tech Solutions",
        "description":
            "IACT develops custom software solutions to streamline data collection and analysis for research institutions.",
        "image": "PIC2.jpg"
      },
      {
        "title": "Field Operations",
        "description":
            "Implementing innovative mobile data collection systems across multiple research sites.",
        "image": "field.jpg"
      },
      {
        "title": "Cloud Infrastructure",
        "description":
            "Expanding our cloud-based research infrastructure to support large-scale data operations.",
        "image": "cloud.jpg"
      },
      {
        "title": "Community Impact",
        "description":
            "Supporting local research teams with technology-driven solutions and capacity building.",
        "image": "field2.jpg"
      },
      {
        "title": "Mobile Development",
        "description":
            "Using the latest technologies to build custom mobile apps from the ground up.",
        "image": "mobile.jpg"
      },
      {
        "title": "Research Support",
        "description":
            "Providing technical expertise and support for complex research projects.",
        "image": "field5_2.jpg"
      },
      {
        "title": "Digital Innovation",
        "description":
            "Creating new digital tools to enhance research efficiency and data quality.",
        "image": "field11_2.jpg"
      },
    ];

    // Randomly select 3 news items
    final random = Random();
    final List<Map<String, String>> shuffledNews = List.from(allNewsData)
      ..shuffle(random);
    final displayedNews = shuffledNews.take(3).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "More from",
                        style: GoogleFonts.baloo2(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Ideas in action",
                        style: GoogleFonts.baloo2(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Innovation in Research Technology",
                style: GoogleFonts.baloo2(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: displayedNews
                .map((news) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _buildNewsCard(news),
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: _navigateToServices,
          child: Text(
            "View all updates →",
            style: GoogleFonts.baloo2(
              fontSize: 16,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildNewsCard(Map<String, String> news) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              news["image"]!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news["title"]!,
                  style: GoogleFonts.baloo2(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  news["description"]!,
                  style: GoogleFonts.baloo2(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _navigateToServices,
                  child: Text(
                    "Learn more →",
                    style: GoogleFonts.baloo2(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
