import 'package:flutter/material.dart';
import 'package:iact/widgets/glassContainer.dart';

class CompaniesWorkedWith extends StatelessWidget {
  const CompaniesWorkedWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Ensures elements can overflow
      children: [
        // Glassmorphic Container
        SizedBox(
          width: 430,
          height: 100,
          child: GlassmorphicContainer(
            blurStrength: 15,
            opacity: 0.2,
            borderRadius: 30,
            borderColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(), // Empty container to preserve structure
            ),
          ),
        ),

        // Logos and Text Overlapping the Container
        Positioned(left: 10, top: 25, child: _companyLogo("ihi.jpg")),
        Positioned(right: 10, top: 20, child: _companyLogo("aaph.png")),
        Positioned(right: 100, top: 100, child: _companyLogo("pact.jpg")),
        Positioned(left: 40, bottom: 40, child: _companyLogo("t4d.jpg")),
        Positioned(left: 150, top: 15, child: _companyLogo("ut.png")),
        Positioned(right: 40, bottom: 10, child: _companyLogo("twaweza.jpg")),

        // Happy Customers Text
        Positioned(
          left: 295,
          top: 25,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              children: [
                TextSpan(
                  text: "6+",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                  text: "\nHappy customers",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget for Company Logos with Icons
  Widget _companyLogo(String imageAsset) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.white.withOpacity(0.8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.asset(
          imageAsset,
          width: 80,
          height: 80,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
