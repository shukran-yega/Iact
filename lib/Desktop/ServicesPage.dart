import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 1200 ? 2 : 3; // Responsive Grid
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title Section
            Text(
              "Our Services",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "We provide innovative solutions tailored to your needs.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            const SizedBox(height: 30),

            // Services in a Grid Layout
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return _buildServiceCard(
                    services[index]["title"]!,
                    services[index]["description"]!,
                    services[index]["animation"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
      String title, String description, String animationPath) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
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
        mainAxisSize: MainAxisSize.max,
        children: [
          Lottie.asset(animationPath, height: 100),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// List of Services
List<Map<String, String>> services = [
  {
    "title": "Software Development",
    "description":
        "We specialize in crafting tailored software for desktop, web, and mobile platforms, "
            "ensuring high-quality, scalable solutions that drive business success."
            " Our expert team transforms your unique ideas into innovative, user-friendly applications.",
    "animation": "code.json",
  },
  {
    "title": "Research Implementation",
    "description": "Our commitment to conducting ethical and structured"
        " research ensures that we provide valuable and actionable insights"
        ". We meticulously gather and analyze"
        " data to deliver impactful findings that"
        " drive informed decision-making.",
    "animation": "research.json",
  },
  {
    "title": "Mobile Application",
    "description":
        "We develop robust iOS and Android applications designed to deliver exceptional performance and user experiences. Our tailored solutions ensure that your mobile apps are reliable, fast,"
            " and optimized for success in a competitive market.",
    "animation": "mobile.json",
  },
  {
    "title": "Data Hosting",
    "description":
        "We provide secure cloud-based database solutions designed to meet the needs of modern businesses. Our services ensure data safety, accessibility, and scalability,"
            " empowering your business with reliable and efficient data management.",
    "animation": "tech.json",
  },
  {
    "title": "Data Analytics",
    "description":
        "We specialize in turning raw data into meaningful and actionable insights. Through advanced analytics and data processing,"
            " we help businesses uncover valuable trends and make informed decisions that drive success.",
    "animation": "stats.json",
  },
  {
    "title": "Data Collection",
    "description":
        "We offer efficient mobile and web-based data collection solutions that streamline the process of gathering, storing, and analyzing data. Our tools are designed to enhance data accuracy and accessibility,"
            " enabling businesses to make informed decisions quickly and effectively.",
    "animation": "collection.json",
  },
];
