import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_login_ui/API-CONNECTION/api.dart';
import 'package:responsive_login_ui/Success_Page.dart';
import 'package:responsive_login_ui/authPage.dart';
import 'package:responsive_login_ui/check_in.dart';
import 'package:responsive_login_ui/check_out.dart';
import 'package:responsive_login_ui/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Attendance_Make extends StatefulWidget {
  const Attendance_Make({Key? key}) : super(key: key);

  @override
  State<Attendance_Make> createState() => _Attendance_MakeState();
}

class _Attendance_MakeState extends State<Attendance_Make> {
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

  String uname = '';
  void unames() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var unames = localStorage.getString('username');
    uname = "$unames";
  }

  Future checkAttendanceOperation() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var res = await CallApi().getData('checkAttendance');
    var body = json.decode(res.body);
    print(body['data']['status']);
    // print(body);
    var status = body['data']['status'];
    if (status == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const Checkout()));
    } else if (status == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const SuccessPage()));
    } else if (status == 3) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => Checkin()));
    }
    // print(status);
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
        body: Container(
          child: Container(
              margin: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      uname.toUpperCase(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Container(
                      width: 400,
                      height: 100,
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
                          BoxShadow(
                            color: Color.fromRGBO(0, 128, 128, 1),
                            blurRadius: 0,
                            offset: Offset(-5, 0),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          checkAttendanceOperation();
                        },
                        child: const Text(
                          'Attendance',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 100,
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
                          BoxShadow(
                            color: Color.fromRGBO(255, 0, 0, 1),
                            blurRadius: 0,
                            offset: Offset(-5, 0),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Future Module',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
