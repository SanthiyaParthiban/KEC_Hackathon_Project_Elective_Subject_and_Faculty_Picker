import 'package:flutter/material.dart';
import 'package:kec/api/sheets.dart';
import 'package:kec/global.dart';
import 'package:kec/page/Home.dart';
import 'package:kec/page/Login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

//first run main function
void main() {
  validate();
}

//validate roll no and name then determine which page to route
Future<void> validate() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? finalRollno = prefs.getString('Rollno') ?? '';
  String? finalName = prefs.getString('Name') ?? '';
  finalCourse = prefs.getString('Course') ?? '';
  if (finalRollno != '' && finalName != '') {
    readElectives().then((value) async {
      runApp(GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KEC',
        theme: ThemeData(primarySwatch: Colors.green),
        home: home(),
      ));
    });
  } else {
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KECH68',
        theme: ThemeData(primarySwatch: Colors.green),
        home: login(),
      ),
    );
  }
}
