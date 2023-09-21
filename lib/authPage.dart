import 'package:flutter/material.dart';
import 'package:responsive_login_ui/Dashboard.dart';
import 'package:responsive_login_ui/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class authPage extends StatefulWidget {
  const authPage({Key? key}) : super(key: key);

  @override
  State<authPage> createState() => _authPageState();
}

class _authPageState extends State<authPage> {
  bool _isLoggedIn = false;
  @override
  void initState() {
    _checkLoginStatus();
    super.initState();
  }

  _checkLoginStatus() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    if (token != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _isLoggedIn ? Attendance_Make() : LoginView(),
      ),
    );
  }
}
