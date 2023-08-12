import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/views/cart/add_item_page.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 90,
          backgroundColor: AppColors.primaryButtonColor,
          title: Text(
            "How can we serve you today?",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Container(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, bottom: 6, top: 6),
                child: GestureDetector(
                  onTap: () async {
                    final updatedService = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AddItem(service: service);
                        },
                      ),
                    );

                    if (updatedService != null) {
                      setState(() {
                        service.selectedItems = updatedService.selectedItems;
                      });
                    }
                  },
                  child: Container(
                    height: 91,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: AppColors.primaryButtonColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColors.whiteColor,
                        width: 4,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.primaryBoxShadowColor,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        service.name,
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
