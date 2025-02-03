import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double blurStrength;
  final double opacity;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;

  const GlassmorphicContainer({
    Key? key,
    required this.child,
    this.blurStrength = 10.0,
    this.opacity = 0.2,
    this.borderRadius = 20.0,
    this.borderColor = Colors.white,
    this.borderWidth = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            // border: Border.all(
            //     color: borderColor.withOpacity(0.5), width: borderWidth),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
