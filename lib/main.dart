import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/animations.dart';
import 'package:homeeaze_sourcecode/views/auth/first_page.dart';
import 'package:homeeaze_sourcecode/views/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Droby',
      home: StreamBuilder(
        stream: AuthController().authStateChanges,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ColorLoader();
          } else if (snapshot.hasData) {
            return const HomePage(currIndex: 0);
          } else {
            return const FirstPage();
          }
        },
      ),
    );
  }
}
