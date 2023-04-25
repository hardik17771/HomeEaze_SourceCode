import 'package:flutter/material.dart';
import 'package:homeeaze_sourcecode/AddItemPage.dart';
import 'package:homeeaze_sourcecode/FirstPage.dart';
import 'package:homeeaze_sourcecode/LoginPage.dart';
import 'package:homeeaze_sourcecode/ServicePage.dart';
import 'package:homeeaze_sourcecode/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainPage(), ));
}
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ServicePage();
          }
          else {
            return LoginPage();
          }}
    );
  }
}


