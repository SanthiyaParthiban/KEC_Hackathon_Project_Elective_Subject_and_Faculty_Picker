import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gsheets/gsheets.dart';
import 'package:kec/api/sheets.dart';
import 'package:kec/page/Login.dart';
import 'package:kec/page/Subject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global.dart';

class home extends StatefulWidget {
  const home({super.key});
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: Text('Logout'),
                onTap: () async {
                  List<Cell> gsheetElectives = [];
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove('Name');
                  sharedPreferences.remove('Number');
                  sharedPreferences.remove('Course');
                  Get.to(() => login());
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.only(
              left: screenWidth / 20,
              right: screenWidth / 20,
              top: screenWidth / 20),
          child: SizedBox(
            height: screenHeight,
            child: GridView.builder(
              itemCount: gsheetElectivescolumn
                  .length, //creating dynamic grid container according to Shop gsheets img url length
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: ((screenHeight / 16) / (screenHeight / 45)),
              ),
              //calling dyamic widget in gridview
              itemBuilder: ((context, index) =>
                  getWidget(gsheetElectivescolumn[index], index)),
            ),
          ),
        ),
      ),
    );
  }

//Dynamic widget declaration
  Widget getWidget(
    Cell electiveName,
    int index,
  ) {
    //GestureDetector to do task when clicked on Widget
    return GestureDetector(
      //onTap: what to do on tap of its child widgets
      onTap: () {
        setState(
          () {
            currentrow = index + 2;
          },
        );
        readSubject().then((value) {
          //page route to
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => subject(),
            ),
          );
        });
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Card(
          elevation: 12,
          shadowColor: Color.fromARGB(255, 1, 138, 5),
          color: Colors.black,
          child: Center(
              child: Text(
            electiveName.value,
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
