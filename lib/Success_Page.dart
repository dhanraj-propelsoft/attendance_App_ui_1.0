import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_login_ui/Dashboard.dart';
import 'package:responsive_login_ui/authPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  void logout() async {
    // print("logout");
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.clear();
    if (kDebugMode) {
      print("logouted");
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const authPage()),
    );
    // }
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // print('back button pressed!');
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 249, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.home, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const Attendance_Make()));
                }),
            const Spacer(),
            Center(
              child: Column(
                children: const [
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
            const Spacer(),
            IconButton(
              icon: const Icon(
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
            margin: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
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
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  const Padding(
                      padding: EdgeInsets.only(
                    top: 60,
                    left: 60,
                  )),
                  const Center(
                    child: SizedBox(
                      // width: 200,
                      child: Text(
                        'Today',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const Center(
                    child: SizedBox(
                      // width: 200,
                      child: Text(
                        'Attendance',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const Center(
                    child: SizedBox(
                      // width: 200,
                      child: Text(
                        'Successfully ',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const Center(
                    child: SizedBox(
                      // width: 200,
                      child: Text(
                        'Completed',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.teal),
                      ),
                      child: const Icon(Icons.home),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const Attendance_Make()));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
