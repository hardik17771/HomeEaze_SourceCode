import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/views/auth/location_page.dart';
import 'package:homeeaze_sourcecode/views/auth/login_page.dart';
import 'package:homeeaze_sourcecode/views/home_page.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getters
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Methods
  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return const HomePage();
        }),
        (route) => false,
      );
    } on FirebaseException catch (e) {
      showSnackBar(
        context: context,
        text: e.message!,
      );
    }
  }

  Future<void> signUpUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = userCredential.user!;
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return LocationPage(user: user);
        }),
        (route) => false,
      );
    } on FirebaseException catch (e) {
      showSnackBar(
        context: context,
        text: e.message!,
      );
    }
  }

  Future<void> saveUserDataToFirestore({
    required User user,
    required double userLongitude,
    required double userLatitude,
    required BuildContext context,
  }) async {
    try {
      UserModel userModel = UserModel(
        username: "username",
        userEmail: user.email!,
        userUid: user.uid,
        userMobileNumber: "9898989898",
        userLatitude: userLatitude,
        userLongitude: userLongitude,
      );

      await _firestore.collection("users").doc(user.uid).set(userModel.toMap());

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      );
    } on FirebaseException catch (e) {
      showSnackBar(
        context: context,
        text: e.message!,
      );
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _firestore.collection("users").doc(uid).snapshots().map(
          (event) => UserModel.fromMap(
            event.data() as Map<String, dynamic>,
          ),
        );
  }

  Future<void> signOut(BuildContext context) async {
    try {
      return await _firebaseAuth.signOut().then((value) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
            return const LoginPage();
          }),
          (route) => false,
        );
      });
    } on FirebaseException catch (e) {
      showSnackBar(
        context: context,
        text: e.message!,
      );
    }
  }
}
