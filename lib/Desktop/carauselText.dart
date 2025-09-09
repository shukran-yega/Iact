import 'package:flutter/material.dart';

class TextCarousel extends StatefulWidget {
  const TextCarousel({super.key});

  @override
  _TextCarouselState createState() => _TextCarouselState();
}

class _TextCarouselState extends State<TextCarousel> {
  int _currentIndex = 0;

  final List<String> texts = [
    "Small minds discuss people. Average minds discuss events.Great minds discuss ideas.",
    "An idea that is developed and put into action is more important that an idea that exists only as an idea.",
    "Conceptualize, Co-design & Test, Implement & validate, Monitor & evaluate.",
    "Innovation distinguishes between a leader and a follower.",
    "The future belongs to those who believe in the beauty of their dreams.",
    "Success is not final, failure is not fatal: it is the courage to continue that counts.",
    "The only way to do great work is to love what you do."
  ];

  @override
  void initState() {
    super.initState();
    _startAutoFade();
  }

  void _startAutoFade() {
    try {
      // Schedule the next fade transition after 5 seconds
      Future.delayed(const Duration(seconds: 8), () {
        if (mounted) {
          setState(() {
            _currentIndex = (_currentIndex + 1) % texts.length;
          });
          // Continue the auto-fade cycle
          _startAutoFade();
        }
      });
    } catch (e) {
      // Print error code to terminal as per user requirements
      print('Error in _startAutoFade: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // Adjust based on UI
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 2000), // Fade duration
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: Center(
          key: ValueKey<int>(_currentIndex), // Unique key for each text
          child: Text(
            texts[_currentIndex],
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    try {
      // Clean up any resources if needed
      super.dispose();
    } catch (e) {
      // Print error code to terminal as per user requirements
      print('Error in dispose: $e');
    }
  }
}
