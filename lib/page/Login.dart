import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kec/page/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/sheets.dart';
import '../global.dart';

class login extends StatefulWidget {
  const login({super.key});
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/Keclogo.png'),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  onChanged: (text) {
                    getrollno(text);
                  },
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'ENTER YOUR ROLL NO',
                  ),
                ),
                TextFormField(
                  onChanged: (text) {
                    getname(text);
                  },
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'ENTER YOUR NAME',
                  ),
                ),
                DropdownButtonExample(),
                Container(
                  height: screenHeight / 18,
                  width: screenWidth / 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString('Rollno', Rollno!);
                      sharedPreferences.setString('Name', Name!);
                      sharedPreferences.setString('Course', dropdownValue);
                      finalCourse = sharedPreferences.getString('Course') ?? '';
                      readStudent().then((value) {
                        if ((Rollno != '' &&
                                Name != '' &&
                                dropdownValue != 'Course?') ||
                            Rollno != '' ||
                            Name != '' ||
                            dropdownValue != 'Course?') {
                          for (int i = 0; i < studentList.length; i++) {
                            if (studentList[i].value == Rollno) {
                              stucurrentrow = i;
                              readElectives().then((value) {
                                Get.to(() => home());
                              });
                            }
                          }
                        } else {
                          Get.snackbar(
                              'Fill all details', 'Must Enter valid details');
                        }
                      });
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 25),
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

  //get Onchanged Rollno and Name from textfield
  String? Rollno = '';
  String? Name = '';
//for rollno
  getrollno(val) async {
    setState(() {
      Rollno = val;
    });
  }

//for name
  getname(val) async {
    setState(() {
      Name = val;
    });
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

//Drop Down for Department
class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      underline: Container(
        height: 2,
        color: Colors.green,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          selectedCourse = dropdownValue;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
