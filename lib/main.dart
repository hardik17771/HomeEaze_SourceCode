import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/animations.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/views/auth/first_page.dart';
import 'package:homeeaze_sourcecode/views/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MaterialApp(
      title: 'Droby',
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ConnectivityResult connectivityResult;
  late StreamSubscription subscription;
  var isConnected = false;

  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternet();
    });
    super.initState();
  }

  checkInternet() async {
    connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      isConnected = true;
    } else {
      isConnected = false;
      showNoInternetDialog();
    }
    // setState(() {});
  }

  showNoInternetDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "No Internet",
            style: GoogleFonts.poppins(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
            ),
          ),
          content: Text(
            "Please Check your internet connection",
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryTextColor,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Retry",
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.tertiaryTextColor,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                checkInternet();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
    );
  }
}
