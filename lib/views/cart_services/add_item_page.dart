import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/cart_model.dart';

class AddItem extends StatefulWidget {
  final Service service;
  const AddItem({
    super.key,
    required this.service,
  });

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    const buttonColor = Color(0xFF0793C5);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: buttonColor,
        toolbarHeight: screenHeight * 0.1,
        title: Text(
          "Pick your items",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.service.items.length,
        itemBuilder: (context, index) {
          final item = widget.service.items[index];
          return Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            decoration: const BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(color: Colors.black, width: .08),
              ),
            ),
            width: screenWidth,
            height: screenHeight * .08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  item.name,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                (item.quantity == 0)
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            item.quantity++;
                            if (!widget.service.selectedItems.contains(item)) {
                              widget.service.selectedItems.add(item);
                            }
                          });
                        },
                        child: Container(
                          height: 48,
                          width: 120,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "ADD",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 48,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: buttonColor,
                            width: 2,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(4.0, 4.0),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                                size: 16,
                                color: buttonColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (item.quantity > 0) {
                                    item.quantity--;
                                    widget.service.selectedItems.remove(item);
                                  }
                                });
                              },
                            ),
                            Text(
                              item.quantity.toString(),
                              style: GoogleFonts.poppins(
                                color: buttonColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                size: 16,
                                color: buttonColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  item.quantity++;
                                  if (!widget.service.selectedItems
                                      .contains(item)) {
                                    widget.service.selectedItems.add(item);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(left: 120, right: 120, bottom: 16),
          child: GestureDetector(
            onTap: () {
              final cartItem = CartItem(
                service: widget.service,
                items: widget.service.items,
              );
              // Add the cart item to your cart or perform any other necessary actions
              // For example: cart.add(cartItem);
              Navigator.pop(context, widget.service);
            },
            child: Container(
              height: 51,
              width: 120,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: const Text(
                "DONE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
