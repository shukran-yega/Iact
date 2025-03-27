import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ServicePage extends StatelessWidget {
  ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFECECEC),
        body: AnimateGradient(
          primaryBegin: Alignment.topRight, // Start from the center
          primaryEnd: Alignment.bottomLeft, // Move directly downward
          secondaryBegin:
              Alignment.centerLeft, // Keep secondary gradient aligned
          secondaryEnd: Alignment.centerRight, // Also move downward
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
            Colors.grey.withOpacity(0.1), // Gradient intensifies downward
          ],
          child: Padding(
            padding: const EdgeInsets.only(
              left: 60,
              right: 60,
              top: 10,
            ),
            child: SizedBox(
              height: MediaQuery.of(context)
                  .size
                  .height, // Adjust height as needed,
              child: GridView.custom(
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 4,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: [
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 2),
                    QuiltedGridTile(1, 1),
                    //QuiltedGridTile(1, 2),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: 9,
                  (context, index) => _buildServiceCard(
                    bgColor: services[index]['bgColor'],
                    description: services[index]['description'],
                    imagePath: services[index]['imagePath'],
                    title: services[index]['title'],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required String imagePath,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor, // Custom background color
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: bgColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon/Image
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Image.asset(
              imagePath,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          // Description (Limited to 3 sentences)
          Text(
            _limitSentences(description, 3),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  final _scaleController =
      ValueNotifier<double>(1.0); // Controller to handle scaling

// Function to limit text to a specific number of sentences
  String _limitSentences(String text, int sentenceLimit) {
    List<String> sentences = text.split(RegExp(r'\. ')); // Split into sentences
    return sentences.take(sentenceLimit).join('. ') +
        (sentences.length > sentenceLimit ? '.' : '');
  }

// List of Services with images and colors
  List<Map<String, dynamic>> services = [
    {
      "title": "Software Development",
      "description":
          "We craft software for web, mobile, and desktop platforms. Our team delivers high-quality and scalable solutions. We turn your ideas into user-friendly applications.",
      "imagePath": "coding.png",
      "bgColor": const Color(0xFFFFFFFF),
    },
    {
      "title": "Research Implementation",
      "description":
          "We conduct ethical and structured research. Our approach ensures valuable and actionable insights. We analyze data to drive informed decision-making.",
      "imagePath": "search.png",
      "bgColor": const Color(0xFFFFFFFF),
    },
    {
      "title": "Mobile Application",
      "description":
          "We develop high-performance mobile apps. Our solutions ensure reliability and user engagement. Optimized for success in a competitive market.",
      "imagePath": "phone.png",
      "bgColor": const Color(0xFFFFFFFF),
    },
    {
      "title": "Data Hosting",
      "description":
          "We offer secure cloud-based hosting solutions. Our services ensure data safety and scalability. Reliable and efficient for modern businesses.",
      "imagePath": "host.png",
      "bgColor": const Color(0xFFFFFFFF),
    },
    {
      "title": "Data Analytics",
      "description":
          "We turn raw data into actionable insights. Our analytics uncover trends and patterns. Helping businesses make data-driven decisions.",
      "imagePath": "data.png",
      "bgColor": const Color(0xFFFFFFFF),
    },
    {
      "title": "Data Collection",
      "description":
          "We streamline mobile and web data collection. Our tools enhance data accuracy and accessibility. Enabling businesses to make informed decisions faster.",
      "imagePath": "datacollect.png",
      "bgColor": const Color(0xFFFFFFFF),
    },
    {
      "title": "Recruit and Train enumerators",
      "description":
          "We can recruit and train enumerators to perform ethical field interviews.",
      "imagePath": "meeting.png",
      "bgColor": const Color(0xFFFFFFFF),
    },
    {
      "title": "Support & mentorship",
      "description":
          "We provide mentorship to bachelors,Masters and phD students with a hands on approach",
      "imagePath": "cap.png",
      "bgColor": const Color(0xFFFFFFFF),
    },
    {
      "title": "Adaption and Deployment of research proposal",
      "description":
          "Adaption and Deployment of research proposal to local context following all legal procedures",
      "imagePath": "legal.png",
      "bgColor": const Color(0xFFFFFFFF),
    },
  ];
}
