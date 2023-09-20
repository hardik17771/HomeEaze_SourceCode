import 'package:flutter/material.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/views/cart/service_page.dart';
import 'package:homeeaze_sourcecode/views/orders/my_orders_page.dart';
import 'package:homeeaze_sourcecode/views/profile/my_profile.dart';

class HomePage extends StatefulWidget {
  final int currIndex;
  const HomePage({super.key, required this.currIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _pageIndex;

  List<Widget> pages = [
    const ServicePage(),
    const MyOrdersPage(),
    const MyProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.currIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex!],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        selectedItemColor: Colors.grey.shade900,
        unselectedItemColor: Colors.grey.shade600,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        currentIndex: _pageIndex!,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update, size: 28),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, size: 28),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
