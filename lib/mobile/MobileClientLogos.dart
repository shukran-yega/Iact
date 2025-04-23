import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileClientLogos extends StatefulWidget {
  const MobileClientLogos({super.key});

  @override
  State<MobileClientLogos> createState() => _MobileClientLogosState();
}

class _MobileClientLogosState extends State<MobileClientLogos> {
  final List<Map<String, String>> _logos = [
    {'name': 'Ifakara health center', 'logo': 'ihi.jpg'},
    {'name': 'Aaph', 'logo': 'aaph.png'},
    {'name': 'Pact', 'logo': 'pact.jpg'},
    {'name': 't4d', 'logo': 't4d.jpg'},
    {'name': 'Toronto', 'logo': 'ut.png'},
    {'name': 'twaweza', 'logo': 'twaweza.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Clients / Partners',
            style: GoogleFonts.baloo2(
              color: Colors.blue.shade900,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),

        // Logo Grid
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: _logos
              .map((client) => MobileClientLogoItem(
                    logoPath: client['logo']!,
                    clientName: client['name']!,
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class MobileClientLogoItem extends StatefulWidget {
  final String logoPath;
  final String clientName;

  const MobileClientLogoItem({
    Key? key,
    required this.logoPath,
    required this.clientName,
  }) : super(key: key);

  @override
  State<MobileClientLogoItem> createState() => _MobileClientLogoItemState();
}

class _MobileClientLogoItemState extends State<MobileClientLogoItem> {
  bool _isHovered = false;

  void _handleClick() {
    // Navigate to portfolio page using goRouter
    context.go("/portfolio");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleClick,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 5,
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    spreadRadius: 2,
                  )
                ],
          border: Border.all(
            color: _isHovered ? Colors.blue.shade50 : Colors.transparent,
            width: 1,
          ),
        ),
        transform: _isHovered
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.translationValues(0, 0, 0),
        child: Center(
          child: Image.asset(
            widget.logoPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
