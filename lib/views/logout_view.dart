import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_login_ui/check_out.dart';
import 'package:responsive_login_ui/views/login_view.dart';

import '../constants.dart';
import '../controller/simple_ui_controller.dart';

class LogoutView extends StatefulWidget {
  const LogoutView({Key? key}) : super(key: key);

  @override
  State<LogoutView> createState() => _LogoutViewState();
}

class _LogoutViewState extends State<LogoutView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Color gradientStart = Colors.teal.shade900;
  Color gradientEnd = Colors.teal.shade900;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SimpleUIController simpleUIController = Get.find<SimpleUIController>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildSmallScreen(size, simpleUIController);
            } else {
              return _buildSmallScreen(size, simpleUIController);
            }
          },
        ),
      ),
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Center(
      child: _buildMainBody(
        size,
        simpleUIController,
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 647,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [gradientStart, gradientEnd],
                          begin: const FractionalOffset(0.5, 0.0),
                          end: const FractionalOffset(0.0, 0.5),
                          stops: const [0.0, 1.0],
                          tileMode: TileMode.clamp)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 100, left: 20.0, right: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 60)),
                          Center(
                            child: Text(
                              'LogOut',
                              style: kLoginTitleStyle(size),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Container(
                            width: 340,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(top: 30, left: 5)),

                                  /// Email
                                  SizedBox(
                                    width: 300,
                                    child: TextFormField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email_rounded),
                                        hintText: 'Email',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                      ),
                                      // The validator receives the text that the user has entered.
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
                                        obscureText:
                                            simpleUIController.isObscure.value,
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.lock_open),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              simpleUIController.isObscure.value
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
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
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

                                  const Padding(
                                      padding: EdgeInsets.only(top: 10)),
                                  SizedBox(
                                    width: 250,
                                    height: 50,
                                    child: ElevatedButton(
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
                                      onPressed: () {
                                        // Validate returns true if the form is valid, or false otherwise.
                                        if (_formKey.currentState!.validate()) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const Checkout()));
                                        }
                                      },
                                      child: const Text('Logout'),
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 10)),

                                  /// Navigate To Login Screen
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const LoginView()));
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Don\'t have an account?',
                                        style: kHaveAnAccountStyle(size),
                                        children: [
                                          TextSpan(
                                            text: " Login",
                                            style: kLoginOrSignUpTextStyle(
                                              size,
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
    );
  }
}
