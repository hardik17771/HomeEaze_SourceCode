import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderPlacedPage extends StatelessWidget {
  const OrderPlacedPage({super.key});

  @override
  Widget build(BuildContext context) {
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
