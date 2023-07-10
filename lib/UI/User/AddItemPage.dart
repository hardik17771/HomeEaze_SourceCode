import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/button.dart';
import '../../Models/cart_model.dart';

class AddItem extends StatefulWidget {
  late final Service service;

AddItem({required this.service});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0793C5),
          title: Text("Pick your item",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w500)),
        ),
        body: ListView.builder(
          itemCount: widget.service.items.length,
          itemBuilder: (context, index) {
            final item = widget.service.items[index];
            return Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              width: screenWidth,
              height: screenHeight * .08,
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(color: Colors.black, width: .08))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(item.name,
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (item.quantity > 0) {
                              item.quantity--;
                              widget.service.selectedItems.remove(item);
                            }
                          });
                        },
                      ),
                      Text(item.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            item.quantity++;
                            if (!widget.service.selectedItems.contains(item)) {
    widget.service.selectedItems.add(item);}
                          });
                        },
                      ),
                    ],
                  ),

                ],
              ),
            );

          },
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: () {
          final cartItem = CartItem(service: widget.service, items: widget.service.items);
          // Add the cart item to your cart or perform any other necessary actions
          // For example: cart.add(cartItem);
          Navigator.pop(context, widget.service);// Return to the service selection page
        },
      ),);
  }
}
