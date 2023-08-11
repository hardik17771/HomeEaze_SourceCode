import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar({required BuildContext context, required String text}) {
  Flushbar(
          backgroundColor: Colors.grey,
          flushbarStyle: FlushbarStyle.FLOATING,
          flushbarPosition: FlushbarPosition.TOP,
          messageText: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          icon: const Icon(
            Icons.info_outline,
            size: 24.0,
            color: Colors.red,
          ),
          duration: const Duration(seconds: 4),
          margin: const EdgeInsets.all(5),
          borderRadius: BorderRadius.circular(10))
      .show(context);
}

class Loader extends StatelessWidget {
  const Loader({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
