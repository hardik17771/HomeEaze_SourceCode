import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/views/cart_services/add_item_page.dart';
import '../../../models/cart_model.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    const buttonColor = Color(0xFF0793C5);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: screenHeight * 0.09,
        backgroundColor: buttonColor,
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
              padding:
                  const EdgeInsets.only(left: 12, right: 12, bottom: 6, top: 6),
              child: GestureDetector(
                onTap: () async {
                  final updatedService = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AddItem(service: service);
                    }),
                  );

                  if (updatedService != null) {
                    setState(() {
                      service.selectedItems = updatedService.selectedItems;
                    });
                  }
                },
                child: Container(
                  height: 96,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white,
                      width: 6,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFD0D2D5),
                        offset: Offset(4.0, 4.0),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      service.name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
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
    );
  }
}
