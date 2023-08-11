import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/controllers/data_controller.dart';
import 'package:homeeaze_sourcecode/models/order_model.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/views/widgets/no_orders_widget.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final AuthController _authController = AuthController();
  final DataController _dataController = DataController();

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFFA8A7A7);
    const buttonColor = Color(0xFF0793C5);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        appBar: AppBar(
          toolbarHeight: 72,
          backgroundColor: buttonColor,
          title: Text(
            "My Orders",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: StreamBuilder<UserModel>(
          stream: _authController.getUserData(_authController.currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const NoOrdersWidget();
            } else if (snapshot.hasData) {
              debugPrint("has User");
              UserModel userModel = snapshot.data!;
              return StreamBuilder<List<OrderModel>>(
                stream: _dataController.fetchUserOrdersData(
                    userUid: userModel.userUid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<OrderModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const NoOrdersWidget();
                  } else if (snapshot.hasData) {
                    debugPrint("has Orders");
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        OrderModel orderModel = snapshot.data![index];
                        return ListTile(
                          title:
                              Text("Order Status :- ${orderModel.orderStatus}"),
                          subtitle: Text(
                              "Order Placing Time :- ${orderModel.orderReceivingTime}"),
                        );
                      },
                    );
                  } else {
                    return const NoOrdersWidget();
                  }
                },
              );
            } else {
              return const NoOrdersWidget();
            }
          },
        ),
      ),
    );
  }
}
