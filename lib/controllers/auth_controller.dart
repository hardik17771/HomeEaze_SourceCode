import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/views/auth/first_page.dart';
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
          return const HomePage(currIndex: 0);
        }),
        (route) => false,
      );
    } on FirebaseException catch (e) {
      showCustomDialog(
        context: context,
        title: "Authentication Error",
        message: e.message!,
      );
    }
  }

  Future<void> resetUserPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

      showCustomToast(text: "Password Reset Link sent on entered email");

      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) {
            return const LoginPage();
          }),
        ),
      );
    } on FirebaseException catch (e) {
      showCustomDialog(
        context: context,
        title: "Authentication Error",
        message: e.message!,
      );
    }
  }

  Future<User?> signUpUser({
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
      return user;
    } on FirebaseException catch (e) {
      showCustomDialog(
        context: context,
        title: "Authentication Error",
        message: e.message!,
      );
    }
    return null;
  }

  Future<void> saveUserDataToFirestore({
    required User user,
    required String username,
    required String mobileNumber,
    required String manualAddress,
    required String manualPincode,
    required String liveAddress,
    required String livePincode,
    required double userLongitude,
    required double userLatitude,
    required BuildContext context,
  }) async {
    try {
      UserModel userModel = UserModel(
        username: username,
        userEmail: user.email!,
        userUid: user.uid,
        userMobileNumber: mobileNumber,
        userLatitude: userLatitude,
        userLongitude: userLongitude,
        userManualAddress: manualAddress,
        userManualPincode: manualPincode,
        userLiveAddress: liveAddress,
        userLivePincode: livePincode,
      );

      await _firestore.collection("users").doc(user.uid).set(userModel.toMap());

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomePage(currIndex: 0),
        ),
        (route) => false,
      );
    } on FirebaseException catch (e) {
      showCustomDialog(
        context: context,
        title: "Authentication Error",
        message: e.message!,
      );
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromMap(
              event.data() as Map<String, dynamic>,
            ));
  }

  Future<void> signOut(BuildContext context) async {
    try {
      return await _firebaseAuth.signOut().then((value) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
            return const FirstPage();
          }),
          (route) => false,
        );
      });
    } on FirebaseException catch (e) {
      showCustomDialog(
        context: context,
        title: "Authentication Error",
        message: e.message!,
      );
    }
  }
}
