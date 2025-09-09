import 'package:flutter/material.dart';

class StyledImageGrid extends StatefulWidget {
  final String imagePath1;
  final String imagePath2;
  final String imagePath3;

  const StyledImageGrid({
    Key? key,
    required this.imagePath1,
    required this.imagePath2,
    required this.imagePath3,
  }) : super(key: key);

  @override
  _StyledImageGridState createState() => _StyledImageGridState();
}

class _StyledImageGridState extends State<StyledImageGrid>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late Animation<double> _fadeAnimation1;
  late Animation<double> _fadeAnimation2;
  late Animation<double> _fadeAnimation3;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _controller3 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fadeAnimation1 = CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeIn,
    );
    _fadeAnimation2 = CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeIn,
    );
    _fadeAnimation3 = CurvedAnimation(
      parent: _controller3,
      curve: Curves.easeIn,
    );
    try {
      _startAnimations();
    } catch (e) {
      print(e.toString());
    }
  }

  void _startAnimations() {
    Future.delayed(Duration(milliseconds: 400), () => _controller1.forward());
    Future.delayed(Duration(milliseconds: 800), () => _controller2.forward());
    Future.delayed(Duration(milliseconds: 1200), () => _controller3.forward());
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: FadeTransition(
            opacity: _fadeAnimation1,
            child: _buildFirstContainer(widget.imagePath1),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: FadeTransition(
                opacity: _fadeAnimation2,
                child: _buildSecondContainer(widget.imagePath2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: FadeTransition(
                opacity: _fadeAnimation3,
                child: _buildThirdContainer(widget.imagePath3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFirstContainer(String imagePath) => _buildContainer(
      imagePath,
      MediaQuery.of(context).size.width * 0.2, // 20% of screen width
      MediaQuery.of(context).size.height * 0.6, // 60% of screen height
      BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(5),
      ));

  Widget _buildSecondContainer(String imagePath) => _buildContainer(
      imagePath,
      MediaQuery.of(context).size.width * 0.2,
      MediaQuery.of(context).size.height * 0.346, // Adjusted dynamically
      BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(25),
      ));

  Widget _buildThirdContainer(String imagePath) => _buildContainer(
      imagePath,
      MediaQuery.of(context).size.width * 0.2,
      MediaQuery.of(context).size.height * 0.24, // Adjusted dynamically

      BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(0),
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ));

  Widget _buildContainer(String imagePath, double width, double height,
      BorderRadius borderRadius) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 5, // Spread radius
            blurRadius: 15, // Blur radius for softness
            offset: Offset(5, 10), // Offset to create the 3D effect
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
