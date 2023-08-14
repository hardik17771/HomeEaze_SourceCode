import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/views/cart/cart_page.dart';
import 'package:homeeaze_sourcecode/views/cart/service_page.dart';
import 'package:homeeaze_sourcecode/views/orders/my_orders_page.dart';
import 'package:homeeaze_sourcecode/views/profile/my_profile.dart';
import 'package:homeeaze_sourcecode/views/widgets/no_orders_widget.dart';

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
    const CartPage(),
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
    var _itemCount = 0;
    setState(() {
      for (int i = 0; i < services.length; i++) {
        _itemCount += services[i].selectedItems.length;
      }
    });

    return Scaffold(
      body: pages[_pageIndex!],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        selectedItemColor: Colors.grey.shade900,
        unselectedItemColor: Colors.grey.shade600,
        unselectedFontSize: 1,
        selectedFontSize: 1,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        currentIndex: _pageIndex!,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _itemCount == 0
                ? const Icon(Icons.shopping_cart, size: 24)
                : badges.Badge(
                    badgeContent: Text(
                      _itemCount.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    position: badges.BadgePosition.topEnd(top: -12, end: -12),
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: AppColors.primaryButtonColor,
                      padding: EdgeInsets.all(5),
                    ),
                    child: const Icon(Icons.shopping_cart, size: 24),
                  ),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.update, size: 28),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, size: 28),
            label: "",
          ),
        ],
      ),
    );
  }
}
