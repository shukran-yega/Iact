import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Ideas extends StatelessWidget {
  const Ideas({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Transforming Ideas in Tanzania & Beyond",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Great ideas are often generated, but the majority do not reach maturity or become reality.",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // Vision & Mission
              Row(
                children: [
                  const Icon(Icons.phone_android, color: Colors.red),
                  const SizedBox(width: 10),
                  Text(
                    "Vision & Mission",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "Our vision is to provide solutions that can transform great ideas into \ntangible products with direct benefits to the community while ensuring value for money.",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // Core Values
              Row(
                children: [
                  const Icon(Icons.umbrella, color: Colors.red),
                  const SizedBox(width: 10),
                  Text(
                    "Core Values",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "Ideas In Action Ltd’s core values are: Innovation, Efficiency, Quality.",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),

        // Right: Text Content
        Lottie.asset("bulb.json", height: 400, width: 400, fit: BoxFit.contain),
      ],
    );
  }
}
