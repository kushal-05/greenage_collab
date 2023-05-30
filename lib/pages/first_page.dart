import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greenage/widgets/home.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'package:greenage/widgets/home.dart';

class FirstPage extends StatelessWidget{
  const FirstPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            Text(snapshot.error.toString());
            return Center(child: Text('Something went wrong'));
          }
          else if (snapshot.hasData){
            print("Home");
            //return HomePage();
            return Home();
          } 
          else {
            print("Login");
            return LoginPage();
          }

          // if(snapshot.connectionState==ConnectionState.active){
          //   if(snapshot.hasData){
          //     return HomePage();
          //   }
          //   else{
          //     return LoginPage();
          //   }
          // }
          // else return LoginPage();
        },
      ),
    );
  }


}