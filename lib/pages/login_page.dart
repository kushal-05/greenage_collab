//import 'dart:html';

// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greenage/pages/loginPhone.dart';
import 'package:greenage/pages/signup_page.dart';
import 'package:greenage/widgets/home.dart';
import 'package:mysql1/mysql1.dart';

dynamic conn2;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;
  final _formfield = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      conn2 = await MySqlConnection.connect(
        ConnectionSettings(
          host: '34.100.129.80',
          port: 3306,
          user: 'root',
          password: 'root',
          db: 'greenage',
        ),
      );
    });
  }

  // to check if email is valid
  bool isEmailValid(String email) {
    // Regular expression pattern to validate email format
    String pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(pattern);

    return regex.hasMatch(email);
  }

  // on click of sign in
  signIn() async {
    print('Inside Signin');
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      print('authenticated');
      print(emailController.text.trim());
      print(conn2);
      final result3 = await conn2.query(
          'SELECT * FROM SIGNEDUP_USERS WHERE email = "${emailController.text.trim()}"');
          print("Received: $result3");
      //obj.setID = result3;
      for (var row1 in result3) {
        print(row1['id']);
        obj.setID = row1['id'];
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
     
    } catch (Error) {
      if (Error is FirebaseAuthException) {
        if (Error.code == 'wrong-password') {
          print("Incorrect password");
          passwordController.clear(); // Clear the password field
          Fluttertoast.showToast(
              msg: "Please enter valid password",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              textColor: Color.fromARGB(255, 0, 0, 0));
        } else if (Error.code == 'user-not-found') {
          print('Email not registered');
          emailController.clear();
          passwordController.clear();
          Fluttertoast.showToast(
            msg: 'Please use a registered email',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            textColor: Color.fromARGB(255, 0, 0, 0),
          );
        } else {
          print('Authentication failed: ${Error.message}');
        }
      }
    }
  }

  // on click of use mobile number
  void goToPhone() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const loginPhone()),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 13, 17, 23),

        //backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formfield,
                child: Column(children: [
                  SizedBox(height: 80),

                  // logo
                  Image.asset(
                    'lib/images/logo_pages.png',
                    height: 90,
                  ),
                  SizedBox(height: 90),

                  // email textfield

                  SizedBox(
                    height: 55,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            color: Color.fromARGB(212, 255, 255, 255),
                            fontSize: 20),
                        controller: emailController,
                        onEditingComplete: () {
                      if (!isEmailValid(emailController.text)) {
                        Fluttertoast.showToast(
                          msg: 'Invalid email',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                        );
                        emailController.clear();
                      }
                    },
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 18),
                          hintText: "email",
                          prefixIcon: Icon(
                            Icons.mail_rounded,
                            color: Color.fromARGB(255, 166, 166, 166),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 45, 45, 45),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          fillColor: Color.fromARGB(255, 45, 45, 45),
                          filled: true,
                          focusColor: Color.fromARGB(255, 192, 192, 192),
                        ),
                        textInputAction: TextInputAction.next,
                        /*validator: (value) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!);
                          if (value.isEmpty) {
                            return "Enter email";
                          }

                          if (!emailValid) {
                            return "Enter valid email";
                          }
                        },*/
                      ),
                    ),
                  ),

                  // password textfield

                  SizedBox(height: 15),
                  SizedBox(
                    height: 55,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        style: TextStyle(
                            color: Color.fromARGB(212, 255, 255, 255),
                            fontSize: 20),
                        controller: passwordController,
                        obscureText: passToggle,
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 18),
                          hintText: "password",
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: Color.fromARGB(255, 166, 166, 166),
                          ),
                          suffixIconColor: Color.fromARGB(255, 166, 166, 166),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(passToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 45, 45, 45),
                            ),
                            //borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          fillColor: Color.fromARGB(255, 45, 45, 45),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter password";
                          } else if (passwordController.text.length < 6) {
                            return "Password should contain a minimum of 6 characters";
                          }
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(8)],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formfield.currentState!.validate()) {
                        print("data added successfully");
                        emailController.clear();
                        passwordController.clear();
                      }
                    },
                    child: const Text("Tap me"),
                  ),
                  // sign in button
                  GestureDetector(
                    onTap: signIn,
                    child: Container(
                      height: 55,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 76, 175, 79),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),
                  // or
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Or",
                            style: TextStyle(
                                color: Color.fromARGB(255, 158, 158, 158)),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // use phone number button
                  GestureDetector(
                    onTap: goToPhone,
                    child: Container(
                      height: 55,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 22, 33, 126),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          "Use mobile number",
                          style: TextStyle(
                            color: Color.fromARGB(210, 255, 255, 255),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 110),
                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Color.fromARGB(255, 158, 158, 158),
                            fontSize: 15),
                      ),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const signUp()),
                          );
                        },
                        child: Text(
                          "Sign up now",
                          style: TextStyle(
                              color: Color.fromARGB(255, 76, 175, 79),
                              fontSize: 15),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
