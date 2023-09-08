import 'package:flutter/material.dart';
import 'package:waste_walking_ba/models/ModelProvider.dart';

class HistoryListItem extends StatelessWidget {
  final WasteWalkRecord record;

  HistoryListItem({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.yellow,
            border:
                Border(top: BorderSide(width: 3, color: Colors.lightGreen))),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              margin: EdgeInsets.fromLTRB(3, 3, 0, 3),
              color: Colors.blue,
            ),
            Expanded(
              child: Container(
                color: Colors
                    .yellow, // Hintergrundfarbe der inneren Container, die die Column enthält
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
                                      fontSize: 25, color: Colors.black)))
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
                        child: Text("Stuttgart")),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
  // @override
  // Widget build(BuildContext context) {
  //   double baseWidth = 262;
  //   double fem = MediaQuery.of(context).size.width / baseWidth;
  //   double ffem = fem * 0.97;
  //   return Container(
  //     width: double.infinity,
  //     child: Container(
  //       //List Item Box
  //       padding: EdgeInsets.all(2),
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Color(0xff000000)),
  //         color: Color(0xffd9d9d9),
  //       ),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Container(
  //             // MapPlaceholder
  //             width: 72 * fem,
  //             height: 85 * fem,
  //             decoration: BoxDecoration(
  //               color: Color(0xffffffff),
  //             ),
  //           ),
  //           Container(
  //             // Top Side Card
  //             margin: EdgeInsets.fromLTRB(0 * fem, 4 * fem, 0 * fem, 0 * fem),
  //             width: 188 * fem,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   // autogroupur71gAK (71bacJDt9dWnPj8wyNUr71)
  //                   padding: EdgeInsets.fromLTRB(
  //                       12 * fem, 0 * fem, 3 * fem, 14 * fem),
  //                   width: double.infinity,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: [
  //                       Container(
  //                         // Date Text
  //                         margin: EdgeInsets.fromLTRB(0, 0, 40, 0),
  //                         child: Text(
  //                           '2/2/23',
  //                         ),
  //                       ),
  //                       Container(
  //                         // autogroupabwm6NT (71baMdyeCsEdy4mXVcAbwm)
  //                         width: double.infinity,
  //                         child: Row(
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: [
  //                             Container(
  //                               // km Text
  //                               margin: EdgeInsets.fromLTRB(
  //                                   0 * fem, 0 * fem, 200, 0 * fem),
  //                               child: Text(
  //                                 '3.7 km',
  //                               ),
  //                             ),
  //                             Text(
  //                               // Go to Walk Overview Page
  //                               '>',
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   // line1tZD (1:4)
  //                   margin:
  //                       EdgeInsets.fromLTRB(0 * fem, 0 * fem, 3 * fem, 2 * fem),
  //                   width: double.infinity,
  //                   height: 1 * fem,
  //                   decoration: BoxDecoration(
  //                     color: Color(0xff000000),
  //                   ),
  //                 ),
  //                 Container(
  //                   // stuttgartd11 (1:5)
  //                   margin:
  //                       EdgeInsets.fromLTRB(6 * fem, 0 * fem, 0 * fem, 0 * fem),
  //                   child: Text(
  //                     'Stuttgart',
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
