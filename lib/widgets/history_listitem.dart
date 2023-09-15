import 'package:flutter/material.dart';
import 'package:waste_walking_ba/models/ModelProvider.dart';

class HistoryListItem extends StatelessWidget {
  final WasteWalkRecord record;

  HistoryListItem({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 3, color: Color.fromARGB(1, 230, 229, 226))),
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              margin: EdgeInsets.fromLTRB(3, 3, 0, 3),
              color: Colors.blue,
            ),
            Expanded(
              child: Container(
                // Hintergrundfarbe der inneren Container, die die Column enthält
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        width: double.infinity,
                        child: Text("1/1/2000")),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "0.00 km",
                                style: TextStyle(fontSize: 25),
                              )),
                          TextButton(
                              onPressed: () => {},
                              child: Text(">",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)))
                        ]),
                    Container(
                      height: 2,
                      color: Colors.black,
                      width: double
                          .infinity, // Die Linie nimmt die maximale Breite ein
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10, 2, 0, 0),
                        child: Text("Stuttgart",
                            style:
                                TextStyle(fontSize: 8, color: Colors.black))),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
