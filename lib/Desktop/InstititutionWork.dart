import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstitutionsWorkedWith extends StatefulWidget {
  final VoidCallback onSeeMore;

  const InstitutionsWorkedWith({super.key, required this.onSeeMore});

  @override
  _InstitutionsWorkedWithState createState() => _InstitutionsWorkedWithState();
}

class _InstitutionsWorkedWithState extends State<InstitutionsWorkedWith> {
  double _borderRadius = 20.0;

  void _onCardTap() {
    setState(() {
      _borderRadius = _borderRadius == 10.0 ? 10.0 : 10.0;
    });
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _borderRadius = 20.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text.rich(
            overflow: TextOverflow.visible,
            TextSpan(
              text: "Our ",
              style: GoogleFonts.baloo2(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: "Clients",
                  style: GoogleFonts.baloo2(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInstitutionCard(
              imagePath: "toronto.jpg",
              title: "University of Toronto",
              description:
                  "One of the world's top universities, advancing research and education.",
            ),
            _buildInstitutionCard(
              imagePath: "ihi.jpg",
              title: "Ifakara Health Institute",
              description:
                  "A leading research institute in health innovation and impact.",
            ),
            _buildInstitutionCard(
              imagePath: "aaph.jpg",
              title: "AAHP",
              description:
                  "Providing advanced analytics and health policy research, in Africa",
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: widget.onSeeMore,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade900,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: Text(
            "See More",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildInstitutionCard(
      {required String imagePath,
      required String title,
      required String description}) {
    return GestureDetector(
      onTap: _onCardTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width * 0.25,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              child: Image.asset(imagePath, height: 120, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
