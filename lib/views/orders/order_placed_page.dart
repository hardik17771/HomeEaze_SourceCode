import 'dart:async';
import 'package:flutter/material.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/views/home_page.dart';

class OrderPlacedPage extends StatefulWidget {
  const OrderPlacedPage({super.key});

  @override
  State<OrderPlacedPage> createState() => _OrderPlacedPageState();
}

class _OrderPlacedPageState extends State<OrderPlacedPage> {
  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const HomePage(currIndex: 3); // Order Placed Page
          },
        ),
        (route) => false,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: AppAssets.orderPlacedBgImage,
          ),
          Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: AppAssets.orderPlacedTickMarkImage,
            ),
          ),
        ],
      ),
    );
  }
}
