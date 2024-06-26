import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/controllers/cart_controller.dart';
import 'package:homeeaze_sourcecode/controllers/notification_controller.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/Models/cart_model.dart';
// import 'package:homeeaze_sourcecode/views/auth/email_password/email_verifly_page.dart';
import 'package:homeeaze_sourcecode/views/auth/first_page.dart';
import 'package:homeeaze_sourcecode/views/auth/user_info_page.dart';
import 'package:homeeaze_sourcecode/views/home_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/refresh_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    const MaterialApp(
      title: 'Droby',
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isConnected = false;
  late StreamSubscription subscription;
  late ConnectivityResult connectivityResult;
  final AuthController _authController = AuthController();
  final NotificationController _notificationController =
      NotificationController();
  final CartController _cartController = CartController();

  @override
  void initState() {
    // Notifications
    _notificationController.requestNotificationPermission();
    _notificationController.isTokenRefresh();
    _notificationController.getDeviceToken().then(
          (value) => debugPrint("Device Token $value"),
        );
    _notificationController.initializeFirebaseMessaging(context);
    _notificationController.setUpInteractMessage(context);

    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternet();
    });

    readCartItems();
    super.initState();
  }

  Future<void> readCartItems() async {
    for (int idx = 0; idx < services.length; idx++) {
      bool isServiceExist =
          await _cartController.isServiceExist(services[idx].name);
      if (isServiceExist) {
        services[idx] = await _cartController.read(services[idx].name);
        debugPrint(services[idx].toString());
      }
    }
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
      stream: _authController.authStateChanges,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const RefreshPage();
        } else if (snapshot.hasData) {
          User? currentUser = _authController.currentUser;

          // --- Email Password  ---->
          // if (currentUser!.emailVerified) {
          //   return FutureBuilder(
          //     future: _authController.checkUserCredentials(currentUser),
          //     builder: (BuildContext context, AsyncSnapshot snapshot) {
          //       if (snapshot.hasData && snapshot.data == true) {
          //         // Restore Cart Data from Shared preferences
          //         return const HomePage(currIndex: 0);
          //       } else if (snapshot.hasData && snapshot.data == false) {
          //         return UserInfoPage(user: currentUser);
          //       } else {
          //         return const RefreshPage();
          //       }
          //     },
          //   );
          // } else {
          //   return const EmailVerificationPage();
          // }

          // --- Phone OTP ---->
          return FutureBuilder(
            future: _authController.checkUserCredentials(currentUser!),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return const HomePage(currIndex: 0);
              } else if (snapshot.hasData && snapshot.data == false) {
                return UserInfoPage(user: currentUser);
              } else {
                return const RefreshPage();
              }
            },
          );
        } else {
          return const FirstPage();
        }
      },
    );
  }
}
