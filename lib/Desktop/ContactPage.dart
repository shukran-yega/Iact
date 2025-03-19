import 'package:flutter/material.dart';
import 'package:org_chart/org_chart.dart';

class Contactpage extends StatefulWidget {
  Contactpage({super.key});

  @override
  State<Contactpage> createState() => _ContactpageState();
}

class _ContactpageState extends State<Contactpage> {
  // Controller for the OrgChart
  final OrgChartController<Map> orgChartController = OrgChartController<Map>(
      boxSize: const Size(150, 80),
      items: [
        {
          "id": '0',
          "text": 'Manager',
        },
        {
          "id": '1',
          "text": 'Head of research',
          "to": '0',
        },
        {
          "id": '2',
          "text": 'Head of finance',
          "to": '0',
        },
        {
          "id": '3',
          "text": 'Software development team',
          "to": '0',
        },
        {
          "id": '4',
          "text": 'Finance & admin officer',
          "to": '2',
        },
        {
          "id": '5',
          "text": 'Field Supervisor',
          "to": '1',
        },
        {
          "id": '6',
          "text": 'Data manager',
          "to": '1',
        },
        {
          "id": '7',
          "text": 'Data analyst',
          "to": '1',
        },
        {
          "id": '8',
          "text": 'Pool of field enumerator',
          "to": '6',
        },
      ],
      idProvider: (data) => data["id"],
      toProvider: (data) => data["to"],
      toSetter: (data, newID) => data["to"] = newID,
      orientation: OrgChartOrientation.topToBottom);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade100,
                Colors.blue.shade200,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                OrgChart<Map>(
                  arrowStyle: const DashedGraphArrow(pattern: [20, 10, 5, 10]),
                  cornerRadius: 10,
                  controller: orgChartController,
                  isDraggable: true,
                  linePaint: Paint()
                    ..color = Colors.black
                    ..strokeWidth = 5
                    ..style = PaintingStyle.stroke
                    ..strokeCap = StrokeCap.round
                    ..color = Colors.grey,
                  builder: (details) {
                    return Column(
                      children: [
                        GestureDetector(
                          // onTap: () {
                          //   orgChartController.addItem({
                          //     "id": orgChartController.uniqueNodeId,
                          //     "text": 'New Block',
                          //     "to": details.item["id"],
                          //   });
                          // },
                          // onDoubleTap: () async {
                          //   String? text =
                          //       await getBlockText(context, details.item);
                          //   if (text != null) {
                          //     setState(() => details.item["text"] = text);
                          //   }
                          // },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: details.isBeingDragged
                                  ? Colors.green.shade100
                                  : details.isOverlapped
                                      ? Colors.red.shade200
                                      : Colors.teal.shade50,
                            ),
                            //elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 40, // Adjust size as needed
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                    ),
                                    child: Icon(
                                      Icons.person, // Placeholder icon
                                      size: 20,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          2), // Spacing between image and text
                                  Text(
                                    textAlign: TextAlign.center,
                                    details.item["text"],
                                    style: TextStyle(
                                      color: Colors.purple.shade900,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     details.hideNodes(!details.nodesHidden);
                        //   },
                        //   child: Text(
                        //     details.nodesHidden
                        //         ? 'Press to Unhide'
                        //         : 'Press to Hide',
                        //   ),
                        // ),
                      ],
                    );
                  },
                  // optionsBuilder: (item) {
                  //   return [
                  //     const PopupMenuItem(
                  //       value: 'Remove',
                  //       child: Text('Remove'),
                  //     ),
                  //   ];
                  // },
                  onOptionSelect: (item, value) {
                    if (value == 'Remove') {
                      orgChartController.removeItem(
                          item["id"], ActionOnNodeRemoval.unlink);
                    }
                  },
                  onDrop: (dragged, target, isTargetSubnode) {
                    if (dragged["to"] == target["id"]) {
                      orgChartController.calculatePosition();
                      return;
                    }
                    if (isTargetSubnode) {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    'You cannot drop a node on a subnode'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ]);
                          });
                      orgChartController.calculatePosition();

                      return;
                    }
                    dragged["to"] = target["id"];
                    orgChartController.calculatePosition();
                  },
                ),
                const Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                      'Tap to add a node, double tap to change text\ndrag and drop to change hierarchy\nright click / tap and hold to remove \nDrag in the empty space to pan the chart\n& pinch to zoom in and out.'),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
                label: const Text('Reset & Change Orientation'),
                onPressed: () {
                  orgChartController.switchOrientation();
                }),
          ),
        ),
      ],
    );
  }

  Future<String?> getBlockText(
      BuildContext context, Map<dynamic, dynamic> item) async {
    final String? text = await showDialog(
      context: context,
      builder: (context) {
        String text = item["text"];
        return AlertDialog(
          title: const Text('Enter Text'),
          content: TextFormField(
            initialValue: item["text"],
            onChanged: (value) {
              text = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(text);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return text;
  }
}
