import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homeeaze_sourcecode/views/orders/my_orders_page.dart';

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
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return const MyOrdersPage();
          },
        ),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: SvgPicture.asset("assets/order_placed_bg.svg"),
          ),
          Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: Image.asset("assets/tick_mark.png"),
            ),
          ),
        ],
      ),
    );
  }
}
