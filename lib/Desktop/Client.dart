import 'package:flutter/material.dart';

class ClientLogosGrid extends StatefulWidget {
  final TabController tabController;

  const ClientLogosGrid({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  _ClientLogosGridState createState() => _ClientLogosGridState();
}

class _ClientLogosGridState extends State<ClientLogosGrid> {
  final List<Map<String, String>> _clients = [
    {'name': 'Ifakara health center', 'logo': 'ihi.jpg'},
    {'name': 'Aaph', 'logo': 'aaph.png'},
    {'name': 'Pact', 'logo': 'pact.jpg'},
    {'name': 't4d', 'logo': 't4d.jpg'},
    {'name': 'Toronto', 'logo': 'ut.png'},
    {'name': 'twaweza', 'logo': 'twaweza.jpg'},
    {'name': 'Apotheker', 'logo': 'apo.jpeg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(
            'Clients / Partners',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),

        // Logo Grid
        Wrap(
          spacing: 60,
          runSpacing: 40,
          alignment: WrapAlignment.center,
          children: _clients
              .map((client) => ClientLogoItem(
                    logoPath: client['logo']!,
                    clientName: client['name']!,
                    tabController: widget.tabController,
                  ))
              .toList(),
        ),

        // "Many More" Option
        // Padding(
        //   padding: const EdgeInsets.only(top: 20),
        //   child: TextButton(
        //     onPressed: () {
        //       // Add navigation or show more clients logic
        //     },
        //     child: Text(
        //       '+ Many more →',
        //       style: TextStyle(
        //         color: Colors.teal,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),

        // ),
      ],
    );
  }
}

class ClientLogoItem extends StatefulWidget {
  final String logoPath;
  final String clientName;
  final TabController tabController;

  const ClientLogoItem({
    Key? key,
    required this.logoPath,
    required this.clientName,
    required this.tabController,
  }) : super(key: key);

  @override
  _ClientLogoItemState createState() => _ClientLogoItemState();
}

class _ClientLogoItemState extends State<ClientLogoItem> {
  bool _isHovered = false;

  void _handleClick() {
    widget.tabController.animateTo(2);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _handleClick,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 220,
          height: 140,
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
              color: _isHovered ? Colors.teal.shade50 : Colors.transparent,
              width: 1,
            ),
          ),
          transform: _isHovered
              ? Matrix4.translationValues(0, -5, 0)
              : Matrix4.translationValues(0, 0, 0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                widget.logoPath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      widget.clientName,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
