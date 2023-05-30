import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greenage/pages/first_page.dart';
import 'package:greenage/pages/loginPhone.dart';
import 'package:greenage/pages/otp.dart';
import 'package:greenage/pages/signup_page.dart';
import 'package:mysql1/mysql1.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),() {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context)=> const FirstPage()),
      );
    },);
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 17, 23),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/images/logo_home.png",height: 250,),
            const SizedBox(height: 30,),
            
            const CupertinoActivityIndicator(
              color: Color.fromARGB(255, 76, 175, 79),
              radius: 20,
            )
            
            
          ],
        ),
      )
    );
  }
}