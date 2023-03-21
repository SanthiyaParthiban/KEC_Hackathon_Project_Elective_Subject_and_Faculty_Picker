import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

import 'dart:convert';
import '../api/sheets.dart';
import '../global.dart';

class subject extends StatefulWidget {
  const subject({super.key});

  @override
  State<subject> createState() => _subjectState();
}

class _subjectState extends State<subject> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    globalHeight = screenHeight;
    globalWidth = screenWidth;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 20, right: 20),
              itemCount: gsheetElectivesrow.length,
              separatorBuilder: (context, index) =>
                  SizedBox(width: double.infinity),
              itemBuilder: (context, index) =>
                  getWidget(gsheetElectivesrow[index], index, stock[index])),
        ),
      ),
    );
  }

  //dynamic widget to display featured image fro  m gsheets
  Widget getWidget(
    Cell subject,
    int subjectindex,
    Cell stock,
  ) {
    return StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 5))
            .asyncMap((i) => readSubject()),
        builder: (context, snapshot) {
          print(snapshot.data);
          return Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                      width: globalWidth! / 2, child: Text(subject.value)),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  /*int i = -1;
                                Future<void> read() async {
                                  while (i == -1) {
                                    await readSubject();
                                  }
                                }*/
                                  readSubject().then((value) {
                                    currentstockinint =
                                        ((int.parse(stock.value)) - 1);
                                    currentstockinstring =
                                        currentstockinint.toString();
                                    updateStock();
                                    updateBooked();
                                  });
                                },
                                child: Text('Book')),
                          ],
                        ),
                        Text(snapshot.data[subjectindex].value)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
