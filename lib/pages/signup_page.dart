import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greenage/data/user_data.dart';
import 'package:greenage/pages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greenage/widgets/home.dart';
import 'package:mysql1/mysql1.dart';
import 'package:greenage/widgets/home.dart';

dynamic conn;

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<signUp> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      conn = await MySqlConnection.connect(
        ConnectionSettings(
          host: '34.93.225.253',
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

  // on click of sign up
  Future signIn() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    //var result = await conn.query('INSERT INTO SIGNEDUP_USERS (name,email,password,phone_number) VALUES (${nameController.text.trim()},${emailController.text.trim()},${phoneController.text.trim()},${passwordController.text.trim()})');
    //var result = await conn.query('INSERT INTO SIGNEDUP_USERS (name, email, password, phone_number) VALUES ("${nameController.text.trim()}", "${emailController.text.trim()}", "${passwordController.text.trim()}", "${phoneController.text.trim()}")');
    var result = await conn.query('INSERT INTO SIGNEDUP_USERS (name, email, password, phone_number) VALUES (?, ?, ?, ?)',
    [nameController.text.trim(), emailController.text.trim(), passwordController.text.trim(), phoneController.text.trim()]);
        print(result); 

    final resultForID = await conn.query(
          'SELECT * FROM SIGNEDUP_USERS WHERE email = "${emailController.text.trim()}"');
          print("Received: $resultForID");
      //obj.setID = result3;
      for (var row1 in resultForID) {
        print(await row1['id']);
        obj.setID = await row1['id'];
      }
    // add user details
    addUserDetails(nameController.text.trim(), emailController.text.trim(),
        phoneController.text.trim());
    
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  Future addUserDetails(
      String fullName, String emailId, String phoneNumber) async {
    await FirebaseFirestore.instance.collection('users').add({
      'full name': fullName,
      'email': emailId,
      'phone number': phoneNumber,
    });
   
  }

  // on click of sign in with google
  Future signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // finally, let's sign in
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    nameController.dispose();
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
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 0),

              // logo
              Image.asset(
                'lib/images/logo_pages.png',
                height: 90,
              ),

              SizedBox(height: 50),

              // Name textfield
              SizedBox(
                height: 55,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    style: TextStyle(
                        color: Color.fromARGB(212, 255, 255, 255),
                        fontSize: 20),
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      hintText: "Full name",
                      prefixIcon: Icon(
                        Icons.account_circle_rounded,
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
                  ),
                ),
              ),

              SizedBox(height: 15),

              // email textfield

              SizedBox(
                height: 55,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    style: TextStyle(
                        color: Color.fromARGB(212, 255, 255, 255),
                        fontSize: 20),
                    controller: emailController,
                    /*onEditingComplete: () {
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
                    },*/
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
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
                  ),
                ),
              ),

              // password textfield

              SizedBox(height: 15),
              SizedBox(
                height: 55,
                //height: MediaQuery.of(context).size.height * 0.05,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    style: const TextStyle(
                        color: Color.fromARGB(212, 255, 255, 255),
                        fontSize: 20),
                    controller: passwordController,
                    obscureText: true,
                    onEditingComplete: () {
                      if (passwordController.text.trim().length < 6) {
                        passwordController.clear();
                        Fluttertoast.showToast(
                          msg: 'Password must be at least 6 characters long',
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                        );
                      } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(passwordController.text.trim())) {
                        passwordController.clear();
                        Fluttertoast.showToast(
                          msg:
                              'Password must only contain alphanumeric characters',
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                        );
                      }
                    },
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      hintText: "password (min 6 characters)",
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: Color.fromARGB(255, 166, 166, 166),
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
                    // textInputAction: TextInputAction.next,
                  ),
                ),
              ),
             const SizedBox(height: 15),

              // Phone number textfield

              SizedBox(
                height: 55,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    style: const TextStyle(
                        color: Color.fromARGB(212, 255, 255, 255),
                        fontSize: 20),
                    controller: phoneController,
                    onEditingComplete: () {
                      if (phoneController.text.trim().length != 10) {
                        phoneController.clear();
                        Fluttertoast.showToast(
                          msg: 'Please enter a valid 10-digit phone number',
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          textColor: Color.fromARGB(255, 0, 0, 0),
                        );
                      }
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      hintText: "mobile number",
                      prefixIcon: Icon(
                        Icons.phone_rounded,
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
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
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
                      "Sign up",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),
              // or
              /*Padding(
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

              // Sign up with google
              GestureDetector(
                onTap: signInWithGoogle,
                child: Container(
                  height: 55,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    //color: Color.fromARGB(255, 22, 33, 126),
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    // child: OutlinedButton.icon(
                    //   onPressed: () {},
                    //   icon: Image.asset(
                    //     'lib/images/google.png',
                    //     width: 20.0,
                    //   ),
                    //   label: const Text("Sign up with google"),
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/images/google.png',
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        const Text(
                          "Sign up with google",
                          style: TextStyle(
                            //color: Color.fromARGB(210, 255, 255, 255),
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/
            ]),
          ),
        ),
      ),
    );
  }
}
