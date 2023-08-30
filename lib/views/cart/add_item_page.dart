import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primaryButtonColor,
          toolbarHeight: 90,
          title: Text(
            widget.service.name,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 12),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.service.items.length,
            itemBuilder: (context, index) {
              final item = widget.service.items[index];
              return Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 8,
                  bottom: 8,
                ),
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      width: 0.5,
                    ),
                  ),
                ),
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item.name,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    (item.quantity == 0)
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                item.quantity++;
                                if (!widget.service.selectedItems
                                    .contains(item)) {
                                  widget.service.selectedItems.add(item);
                                }
                              });
                            },
                            child: Container(
                              height: 36,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColors.primaryButtonColor,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: AppColors.whiteColor,
                                  width: 2,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.primaryBoxShadowColor,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "ADD",
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 36,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: AppColors.primaryButtonColor,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: const Icon(
                                      Icons.remove,
                                      size: 24,
                                      color: AppColors.primaryButtonColor,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (item.quantity > 0) {
                                          item.quantity--;
                                          widget.service.selectedItems
                                              .remove(item);
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  item.quantity.toString(),
                                  style: GoogleFonts.poppins(
                                    color: AppColors.tertiaryTextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: const Icon(
                                      Icons.add,
                                      size: 24,
                                      color: AppColors.primaryButtonColor,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        item.quantity++;
                                        if (!widget.service.selectedItems
                                            .contains(item)) {
                                          widget.service.selectedItems
                                              .add(item);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: AppColors.primaryBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 120, right: 120, bottom: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context, widget.service);
              },
              child: Container(
                width: 120,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryButtonColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.whiteColor,
                    width: 2,
                  ),
                ),
                child: const Text(
                  "DONE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
