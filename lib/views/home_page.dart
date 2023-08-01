import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homeeaze_sourcecode/views/cart_services/cart_page.dart';
import 'package:homeeaze_sourcecode/views/cart_services/service_page.dart';

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
      child: TextButton(
        onPressed: () {
          // AuthController().signOut(context);
        },
        child: const Text("LogOut"),
      ),
    ),
    Container(), // Previous Orders
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
