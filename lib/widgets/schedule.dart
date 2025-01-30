import 'package:flutter/material.dart';
import 'package:iact/widgets/glassContainer.dart';

class schedule extends StatelessWidget {
  const schedule({Key? key}) : super(key: key);

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
            child: Row(
              children: [
                Icon(Icons.schedule_send),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Schedule an appointment",
                      overflow: TextOverflow.ellipsis),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
