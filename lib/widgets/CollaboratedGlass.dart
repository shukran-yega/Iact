import 'package:flutter/material.dart';
import 'package:iact/widgets/glassContainer.dart';

class CompaniesWorkedWith extends StatelessWidget {
  const CompaniesWorkedWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3, // 60% of screen width
      child: GlassmorphicContainer(
        blurStrength: 15,
        opacity: 0.2,
        borderRadius: 30,
        borderColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double
                .infinity, // To ensure the container takes up the full width
            height:
                80, // Set a height constraint for the Stack to work properly
            child: Stack(
              clipBehavior: Clip.none, // Allow logos to overlap
              children: [
                Positioned(
                  left: 3,
                  bottom: 30,
                  child: _companyLogo("/ihi.jpg"), // 1nd logo,
                ),
                Positioned(
                  left: 70,
                  child: _companyLogo(
                      "/pact.jpg"), // 2nd logo, slightly to the left
                ),
                Positioned(
                  left: 135,
                  child: _companyLogo(
                      "/toronto.jpg"), // 3rd logo, slightly to the right
                ),
                Positioned(
                  left: 200,
                  child: _companyLogo(
                      "/twaweza.jpg"), // 3rd logo, slightly to the right
                ),
                Positioned(
                  left: 280,
                  top: 20,
                  child: RichText(
                    text: TextSpan(
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
                            color:
                                Colors.black, // Customize the color as needed
                            fontSize:
                                20, // You can adjust the size for the number
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for Company Logos with Icons (no name shown)
  Widget _companyLogo(String imageAsset) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.white.withOpacity(0.8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.asset(
          imageAsset, // Path to your image
          width: 80, // Set size
          height: 80, // Set size
          fit: BoxFit.fitWidth, // Ensures the image fits well within the circle
        ),
      ),
    );
  }
}
