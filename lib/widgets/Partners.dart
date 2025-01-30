import 'package:flutter/material.dart';
import 'package:iact/widgets/glassContainer.dart';

class Partners extends StatelessWidget {
  const Partners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.15, // Controls width
        child: GlassmorphicContainer(
          blurStrength: 15,
          opacity: 0.2,
          borderRadius: 30,
          borderColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("IACT"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.device_hub_rounded),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Expanded(
                            child: Text(
                              "Partnering for a \nBetter Future",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye_rounded),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Expanded(child: Text("View all details")),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
