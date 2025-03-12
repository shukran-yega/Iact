import 'package:flutter/material.dart';

class TextCarousel extends StatefulWidget {
  const TextCarousel({super.key});

  @override
  _TextCarouselState createState() => _TextCarouselState();
}

class _TextCarouselState extends State<TextCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> texts = [
    "Innovative software solutions tailored for businesses.",
    "Data-driven strategies that empower decision-making.",
    "Seamless mobile and web application development.",
    "Secure cloud hosting for high-performance applications.",
    "Advanced research tools to drive impactful change.",
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _pageController.animateToPage(
          (_currentIndex + 1) % texts.length,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentIndex = (_currentIndex + 1) % texts.length;
        });
        _startAutoScroll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Adjust based on UI
      child: PageView.builder(
        controller: _pageController,
        itemCount: texts.length,
        physics:
            const NeverScrollableScrollPhysics(), // Prevent manual scrolling
        itemBuilder: (context, index) {
          return Center(
            child: Text(
              texts[index],
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
