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

    _startAnimations();
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
      300,
      500,
      BorderRadius.only(
        topLeft: Radius.circular(100),
        topRight: Radius.circular(100),
        bottomLeft: Radius.circular(100),
        bottomRight: Radius.circular(5),
      ));

  Widget _buildSecondContainer(String imagePath) => _buildContainer(
      imagePath,
      300,
      275,
      BorderRadius.only(
        topLeft: Radius.circular(100),
        topRight: Radius.circular(50),
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(20),
      ));

  Widget _buildThirdContainer(String imagePath) => _buildContainer(
      imagePath,
      300,
      210,
      BorderRadius.only(
        topLeft: Radius.circular(100),
        topRight: Radius.circular(0),
        bottomLeft: Radius.circular(100),
        bottomRight: Radius.circular(100),
      ));

  Widget _buildContainer(String imagePath, double width, double height,
      BorderRadius borderRadius) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
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
