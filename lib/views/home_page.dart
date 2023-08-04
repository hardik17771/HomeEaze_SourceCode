import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/controllers/data_controller.dart';
import 'package:homeeaze_sourcecode/views/auth/location_page.dart';
import 'package:homeeaze_sourcecode/views/cart_services/cart_page.dart';
import 'package:homeeaze_sourcecode/views/cart_services/service_page.dart';
import 'package:homeeaze_sourcecode/views/order_placed_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  List<Widget> pages = [
    const ServicePage(),
    const CartPage(),
    Center(
      child: Builder(builder: (context) {
        return TextButton(
          onPressed: () {
            AuthController().signOut(context);
            // DataController().putVendorOutletData(context);
          },
          child: const Text("LogOut"),
        );
      }),
    ),
    // Center(
    //   child: Builder(builder: (context) {
    //     return TextButton(
    //       child: const Text("Location Page"),
    //       onPressed: () {
    //         Navigator.of(context).push(
    //           MaterialPageRoute(
    //             builder: (context) {
    //               // return const LocationPage();
    //             },
    //           ),
    //         );
    //       },
    //     );
    //   }),
    // ),
    OrderPlacedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey.shade900,
        unselectedItemColor: Colors.grey.shade600,
        unselectedFontSize: 1,
        selectedFontSize: 1,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset("assets/icons/home_icon.svg"),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset("assets/icons/cart_icon.svg"),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset("assets/icons/profile_icon.svg"),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 25,
              height: 25,
              child: SvgPicture.asset("assets/icons/history_icon.svg"),
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
