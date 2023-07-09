import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homeeaze_sourcecode/UI/User/get_address.dart';
import 'package:homeeaze_sourcecode/UI/User/outlet_details.dart';

import 'Models/auth.dart';
import 'Models/geolocator_functions.dart';
import 'UI/User/LoginPage.dart';
import 'UI/User/checkout_page.dart';




Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage()));
}
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return NearbyVendorsPage();
          }
          else {
            return LoginPage();
          }}
    );
  }
}


