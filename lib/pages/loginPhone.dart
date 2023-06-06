import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greenage/pages/first_page.dart';
import 'package:greenage/pages/home_page.dart';
import 'package:greenage/pages/otp.dart';
import 'package:mysql1/mysql1.dart';

class loginPhone extends StatefulWidget {
  const loginPhone({super.key});

  static String Verify = "";

  @override
  State<loginPhone> createState() => _loginPhoneState();
}

class _loginPhoneState extends State<loginPhone> {
  final phoneController = TextEditingController();
  TextEditingController countryCode = TextEditingController();

  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      conn = await MySqlConnection.connect(
        ConnectionSettings(
          host: '34.93.37.194',
          port: 3306,
          user: 'root',
          password: 'root',
          db: 'greenage',
        ),
      );
    });
  }

  dynamic conn;

  Future<void> checkPhoneNumber() async {
    var usersCollection = FirebaseFirestore.instance.collection('users');
  var querySnapshot = await usersCollection
      .where('phone number', isEqualTo: phoneController.text.trim())
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    sendOtp();
  } else {
    Fluttertoast.showToast(
      msg: "Phone number provided is not valid",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      textColor: Color.fromARGB(255, 0, 0, 0),
      fontSize: 16.0,
    );
    phoneController.clear();
  }
    /*var result = await conn.query(
        'SELECT * FROM SIGNEDUP_USERS WHERE phone_number = (?)',[phoneController.text.trim()]);
    if (result != null) {
      sendOtp();
    } else {
      Fluttertoast.showToast(
          msg: "Phone number provided is not valid",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          textColor: Color.fromARGB(255, 0, 0, 0),
          fontSize: 16.0);
      phoneController.clear();
    }*/
  }

  // on click of sign in
  Future sendOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryCode.text + phoneController.text.trim(),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Fluttertoast.showToast(
              msg: "Phone number provided is not valid",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              textColor: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16.0);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        loginPhone.Verify = verificationId;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const otp()),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 13, 17, 23),
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
      //backgroundColor: Colors.black,
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

            // Phone textfield

            SizedBox(
              height: 55,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  style: TextStyle(
                    color: Color.fromARGB(212, 255, 255, 255),
                    fontSize: 18,
                  ),
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone_rounded,
                      color: Color.fromARGB(255, 166, 166, 166),
                    ),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    //hintText: "Enter mobile number",
                    prefixText: "+91 ",

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
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                ),
              ),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [
            //     Flexible(
            //       child: SizedBox(
            //         width: 100,
            //         child: TextField(
            //           style: TextStyle(
            //               color: Color.fromARGB(212, 255, 255, 255), fontSize: 20),
            //           decoration: InputDecoration(
            //             hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
            //             //hintText: "Enter mobile number",
            //             prefixText: "+91",
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(
            //                 color: Color.fromARGB(255, 45, 45, 45),
            //               ),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: Colors.grey),
            //             ),
            //             fillColor: Color.fromARGB(255, 45, 45, 45),
            //             filled: true,
            //             focusColor: Color.fromARGB(255, 192, 192, 192),
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 10),
            //     Flexible(
            //       child: TextField(
            //         style: TextStyle(
            //             color: Color.fromARGB(212, 255, 255, 255), fontSize: 20),
            //         keyboardType: TextInputType.number,
            //         decoration: InputDecoration(
            //           hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
            //           //hintText: "Enter mobile number",

            //           enabledBorder: OutlineInputBorder(
            //             borderSide: BorderSide(
            //               color: Color.fromARGB(255, 45, 45, 45),
            //             ),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.grey),
            //           ),
            //           fillColor: Color.fromARGB(255, 45, 45, 45),
            //           filled: true,
            //           focusColor: Color.fromARGB(255, 192, 192, 192),
            //         ),
            //       ),
            //     )
            //   ],
            // ),

            // OTP

            // SizedBox(height: 15),
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
              onTap: checkPhoneNumber,
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
                    "Send OTP",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
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
