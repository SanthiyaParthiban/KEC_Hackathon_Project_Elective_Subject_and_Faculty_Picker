library my_prj.globals;

//importing Cell data type from gsheets
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:gsheets/gsheets.dart';

//global screen width and height
double? globalHeight;
double? globalWidth;

//list of departments
List<String> list = <String>['Course?', 'BSC', 'MSC'];
String dropdownValue = list.first;

//read students information
List<Cell> studentList = [];
//declaring for storing shopping from gsheets by its column
List<Cell> gsheetElectivescolumn = [];
List<Cell> gsheetElectivesrow = [];

//to get roll no one by one using for loop
String? readedRollno;
String? selectedCourse;

//read current row from elective displayed in home [index]
int? currentrow;

String? finalCourse;
List<Cell> stock = [];
List<Cell> Teachers = [];

//to get current available stock in int to change
int? currentstockinint;
String? currentstockinstring;
String? gsheetsubjectvalue;
int? stucurrentrow;
