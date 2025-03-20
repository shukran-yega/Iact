import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imagePaths;

  const ImageCarousel({Key? key, required this.imagePaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height * 0.6, // Ensure it has a height
      child: CarouselSlider.builder(
        itemCount: imagePaths.length,
        options: CarouselOptions(
          //height: MediaQuery.of(context).size.height * 0.6, // Explicit height
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          enlargeCenterPage: true,
          viewportFraction: 0.8,
        ),
        itemBuilder: (context, index, realIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePaths[index],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
