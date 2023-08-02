import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/views/auth/login_page.dart';
import 'package:homeeaze_sourcecode/views/home_page.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // -----> Save user Data to Firebase

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

  Future<void> saveUserDataToFirestore(
    BuildContext context,
  ) async {
    try {
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
