import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:responsive_login_ui/API-CONNECTION/api.dart';
import 'package:responsive_login_ui/Dashboard.dart';
import 'package:responsive_login_ui/Success_Page.dart';
import 'package:responsive_login_ui/authPage.dart';
import 'package:responsive_login_ui/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const Checkout());

void attendance_Out() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var res = await CallApi().getData('attendance_Out');
  var body = json.decode(res.body);
}

class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Welcome to Flutter',
      home: const Scaffold(
        body: MyBody1(),
      ),
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyBody1 extends StatefulWidget {
  const MyBody1({Key? key}) : super(key: key);

  @override
  State<MyBody1> createState() => _MyBody1State();
}

class _MyBody1State extends State<MyBody1> {
  String time = "";
  String day = DateFormat("day").format(DateTime.now());
  var now = DateTime.now();
  String current = DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now());
  @override
  void initState() {
    Timer mytimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime timenow = DateTime.now(); //get current date and time
      time = "${timenow.hour}:${timenow.minute}";
      setState(() {});
    });
    super.initState();
  }

  String uname = '';
  void unames() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var unames = localStorage.getString('username');
    uname = "$unames";
  }

  void logout() async {
    // print("logout");
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.clear();
    var res = await CallApi().getData('logout');
    var token = localStorage.getString('token');
    var body = json.decode(res.body);
    print("logouted");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const authPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<bool?> showWarning(BuildContext context) async => showDialog<bool?>(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Do you want to exit an App?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          ),
        );

    unames();
    return WillPopScope(
      onWillPop: () async {
        // print('back button pressed!');
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(237, 242, 249, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => Attendance_Make()));
                }),
            Spacer(),
            Center(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Text(
                    'Propel Soft',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'Accelerative Business Ahead',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                logout();
              },
            ),
          ],
        ),
        body: Center(
            child: Container(
          width: 400,
          height: 400,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(65, 69, 88, 0.1),
                spreadRadius: 0,
                blurRadius: 14,
                offset: Offset(0, 7),
              ),
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.07),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 50)),
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Form(
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 250,
                                  color: Colors.grey.shade50,
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20)),
                                      Text('User Name:',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Center(
                                        child: Text(
                                          uname.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 10)),
                                Container(
                                  width: 250,
                                  color: Colors.grey.shade50,
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20)),
                                      Text('Date:',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Center(
                                        child: Text(
                                          (DateFormat("dd-MM-yyyy")
                                              .format(DateTime.now())),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Container(
                                  width: 250,
                                  color: Colors.grey.shade50,
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20)),
                                      Text('Day:',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Center(
                                        child: Text(
                                          (DateFormat(DateFormat.WEEKDAY)
                                              .format(now)),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 10)),
                                Container(
                                  width: 250,
                                  color: Colors.grey.shade50,
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20)),
                                      Text('Current out time:',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Center(
                                        child: Text(
                                          time,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Widget cancelButton = TextButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                        },
                      );
                      Widget continueButton = TextButton(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                        onPressed: () {
                          attendance_Out();
                          alertDialog(context);
                        },
                      );
                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text(
                          "Attention Please!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: Text(
                            "Would you like to exit completely from this app?"),
                        actions: [
                          cancelButton,
                          continueButton,
                        ],
                      );

                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                      // attendance_Out();
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (ctx) => const SuccessPage()));
                    },
                    child: const Text('Check - Out'),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

alertDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          title: const Text(
            "Successfully",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
              "Thank You For Joining Us, Today's Progress Is Completed"),
          actions: [
            TextButton(
              child: const Text(
                'Exit',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const SuccessPage()));
              },
            ),
          ],
          elevation: 5,
        ),
      );
    },
  );
}
