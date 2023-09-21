import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:responsive_login_ui/API-CONNECTION/api.dart';
import 'package:responsive_login_ui/Dashboard.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../controller/simple_ui_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Color gradientStart = const Color.fromRGBO(237, 242, 249, 1);
  Color gradientEnd = const Color.fromRGBO(237, 242, 249, 1);
  bool _isLoggedIn = true;
  LocalAuthentication auth = LocalAuthentication();
  Future authenticate() async {
    final bool isBiometricsAvailable = await auth.isDeviceSupported();
    if (!isBiometricsAvailable) return false;
    try {
      return await auth.authenticate(
        localizedReason: 'Scan Fingerprint To Enter Vault',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException {
      return;
    }
  }

  @override
  void initState() {
    _checkLoginStatus();
    super.initState();
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
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

  String msg = "";
  _login() async {
    var data = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);

    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['data']['token']);
      localStorage.setString('username', body['data']['name']);
      if (kDebugMode) {
        print(body['data']['name']);
      }
      Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => const Attendance_Make()));
    } else {
      setState(() {
        msg = "Authentication Failure";
        return;
      });
    }
  }

  @override
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  SimpleUIController simpleUIController = Get.put(SimpleUIController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildSmallScreen(size, simpleUIController, theme);
              } else {
                return _buildSmallScreen(size, simpleUIController, theme);
              }
            },
          )),
    );
  }

  Widget _buildSmallScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Center(
      child: _buildMainBody(
        size,
        simpleUIController,
        theme,
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                        boxShadow: const [
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
                        gradient: LinearGradient(
                            colors: [gradientStart, gradientEnd],
                            begin: const FractionalOffset(0.5, 0.0),
                            end: const FractionalOffset(0.0, 0.5),
                            stops: const [0.0, 1.0],
                            tileMode: TileMode.clamp)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 100, left: 20.0, right: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 30)),
                            Center(
                              child: Text(
                                'Login',
                                style: kLoginTitleStyle(size),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Container(
                              width: 340,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: CupertinoColors.white,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(
                                      top: 10,
                                    )),
                                    Text(
                                      msg,
                                      style: const TextStyle(color: Colors.red),
                                    ),

                                    const Padding(
                                        padding:
                                            EdgeInsets.only(top: 20, left: 5)),

                                    /// Email
                                    SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        style: kTextFormFieldStyle(),
                                        textInputAction: TextInputAction.next,
                                        controller: emailController,
                                        enabled: _isLoggedIn,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.email_rounded),
                                          hintText: 'Email',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(value)) {
                                            return 'Enter a valid email!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),

                                    /// password
                                    const Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 5)),
                                    SizedBox(
                                      width: 300,
                                      child: Obx(
                                        () => TextFormField(
                                          style: kTextFormFieldStyle(),
                                          controller: passwordController,
                                          enabled: _isLoggedIn,
                                          obscureText: simpleUIController
                                              .isObscure.value,
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                const Icon(Icons.lock_open),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                simpleUIController
                                                        .isObscure.value
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                              onPressed: () {
                                                simpleUIController
                                                    .isObscureActive();
                                              },
                                            ),
                                            hintText: 'Password',
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                          ),
                                          // The validator receives the text that the user has entered.
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter password';
                                            } else if (value.length < 6) {
                                              return 'please enter valid password';
                                            } else if (value.length > 20) {
                                              return 'maximum character is 20';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),

                                    /// login Button
                                    const Padding(
                                        padding: EdgeInsets.only(top: 20)),
                                    areFieldsEmpty()
                                        ? ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    side: const BorderSide(
                                                        color: Colors.teal)),
                                              ),
                                            ),
                                            onPressed: null,
                                            child: const Text(
                                              'Login',
                                              style:
                                                  TextStyle(color: Colors.teal),
                                            ),
                                          )
                                        : ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.teal),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                            child: Text('Login'),
                                            onPressed: () async {
                                              bool isAuthenticated =
                                                  await authenticate();
                                              if (isAuthenticated) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return const Attendance_Make();
                                                    },
                                                  ),
                                                );
                                              } else {
                                                Container();
                                              }
                                              // if (_formKey.currentState!
                                              //     .validate()) {
                                              //   _login();
                                              // }
                                            },
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool areFieldsEmpty() {
    return emailController.text.toString().isEmpty ||
        passwordController.text.toString().isEmpty;
  }
}
