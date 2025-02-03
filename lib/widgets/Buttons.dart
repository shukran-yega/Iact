import 'package:flutter/material.dart';

class AnimatedHoverButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color hoverColor; // Added hoverColor
  final Color normalColor; // Added normalColor

  const AnimatedHoverButton({
    Key? key,
    required this.label,
    this.icon,
    required this.onPressed,
    required this.hoverColor, // Required hoverColor
    required this.normalColor, // Required normalColor
  }) : super(key: key);

  @override
  _AnimatedHoverButtonState createState() => _AnimatedHoverButtonState();
}

class _AnimatedHoverButtonState extends State<AnimatedHoverButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform:
            _isHovered ? (Matrix4.identity()..scale(1.1)) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.hoverColor
              : widget.normalColor, // Use custom colors
          borderRadius: BorderRadius.circular(30),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null)
              Icon(
                widget.icon,
                color: Colors.black,
              ),
            if (widget.icon != null) const SizedBox(width: 8),
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
