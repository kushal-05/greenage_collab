import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenage/pages/first_page.dart';
import 'package:greenage/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(user.email != null)  Text('Signed in'),
            //if (user.email != null) Text("Signed in as " + user.displayName!),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                //Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirstPage(),
                  ),
                );
                //Navigator.pop(context);
                //Navigator.popUntil(context, (route) => route.isFirst);
                // Navigator.of(context).popUntil((route) => route.isFirst);
                //Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                
              },
              color: Colors.deepPurple,
              child: Text("Sign out"),
            )
          ],
        ),
      ),
    );
  }
}
