import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greenage/pages/home_page.dart';
import 'package:greenage/pages/loginPhone.dart';
import 'package:pinput/pinput.dart';

class otp extends StatefulWidget {
  const otp({super.key});

  @override
  State<otp> createState() => _otpPage();
}

class _otpPage extends State<otp> {
  // text controllers
  TextEditingController otpController = TextEditingController();
  String otp="";
  FirebaseAuth auth =  FirebaseAuth.instance; 

  // on click of verify
  void verify() async {
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: loginPhone.Verify, smsCode: otpController.text);

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(),),
        );
    }
    catch(e){
      Fluttertoast.showToast(
              msg: "OTP provided is not valid",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              textColor: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16.0);
    }

  }
  

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 17, 23),
      //backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          color: Color.fromARGB(255, 76, 175, 79),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(height: 60),

            // Icon
            Image.asset(
              'lib/images/logo_pages.png',
              height: 90,
            ),
            const SizedBox(height: 150),

            // OTP

            Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 60,
                    width: 50,
                    child: TextField(
                      style: TextStyle(
                          color: Color.fromARGB(212, 255, 255, 255),
                          fontSize: 20),
                      decoration: const InputDecoration(
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
                      onChanged: (value) {
                        if (value.length == 1) {
                          otp=otp + value;
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 50,
                    child: TextField(
                      style: TextStyle(
                          color: Color.fromARGB(212, 255, 255, 255),
                          fontSize: 20),
                      decoration: const InputDecoration(
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
                      onChanged: (value) {
                        if (value.length == 1) {
                          otp=otp + value;
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 50,
                    child: TextField(
                      style: TextStyle(
                          color: Color.fromARGB(212, 255, 255, 255),
                          fontSize: 20),
                      decoration: const InputDecoration(
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
                      onChanged: (value) {
                        if (value.length == 1) {
                          otp=otp + value;
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 50,
                    child: TextField(
                      style: TextStyle(
                          color: Color.fromARGB(212, 255, 255, 255),
                          fontSize: 20),
                      decoration: const InputDecoration(
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
                      onChanged: (value) {
                        if (value.length == 1) {
                          otp=otp + value;
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 50,
                    child: TextField(
                      style: TextStyle(
                          color: Color.fromARGB(212, 255, 255, 255),
                          fontSize: 20),
                      decoration: const InputDecoration(
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
                      onChanged: (value) {
                        if (value.length == 1) {
                          otp=otp + value;
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 50,
                    child: TextField(
                      style: TextStyle(
                          color: Color.fromARGB(212, 255, 255, 255),
                          fontSize: 20),
                      decoration: const InputDecoration(
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
                      onChanged: (value) {
                        if (value.length == 1) {
                          otp=otp + value;
                          otpController.text=otp;
                          FocusScope.of(context).unfocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // const SizedBox(
            //   height: 55,
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 25.0),
            //     child: TextField(
            //       style: TextStyle(
            //           color: Color.fromARGB(212, 255, 255, 255), fontSize: 20),
            //       keyboardType: TextInputType.number,
            //       //controller: passwordController,
            //       obscureText: true,
            //       decoration: InputDecoration(
            //         hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
            //         hintText: "OTP",
            //         prefixIcon: Icon(
            //           Icons.lock_rounded,
            //           color: Color.fromARGB(255, 166, 166, 166),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(
            //             color: Color.fromARGB(255, 45, 45, 45),
            //           ),
            //           //borderSide: BorderSide(color: Colors.white),
            //         ),
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.grey),
            //         ),
            //         fillColor: Color.fromARGB(255, 45, 45, 45),
            //         filled: true,
            //       ),
            //     ),
            //   ),
            // ),

            const SizedBox(
              height: 20,
            ),
            // sign in button
            GestureDetector(
              onTap: verify,
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
                    "Verify",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
