import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'outlet_type_timing.dart';


Color textColor = Color(0xFFA8A7A7);
Color buttonColor = Color(0xFF0793C5);

class OutletPage extends StatelessWidget {
  final TextEditingController outletNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController ownerFirstNameController =
      TextEditingController();
  final TextEditingController ownerLastNameController = TextEditingController();
  final TextEditingController ownerContactNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text("Outlet Details",
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                " Enter your outlet details to create an account",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: outletNameController,
                decoration: InputDecoration(
                  labelText: 'Outlet Name *',
                  labelStyle: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: textColor, width: 10),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: mobileNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Customer Mobile Number *',
                  labelStyle: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: textColor),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              SizedBox(height: 16.0),
              Text("Outlet Address",
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 51,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {},
                  child: Text(
                    'Use My Current Address',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                alignment: Alignment.center,
                child: Text('Or',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700, fontSize: 16)),
              ),
              SizedBox(height: 16.0),
              Text('Enter Address Manually',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(height: 16.0),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address *',
                  labelStyle: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: textColor),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: pinCodeController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Pin Code *',
                  labelStyle: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: textColor),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text('Owner Details',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: ownerFirstNameController,
                    decoration: InputDecoration(
                      labelText: 'Owner First Name *',
                      labelStyle: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: textColor),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  )),
                  SizedBox(width: 16.0),
                  Expanded(
                      child: TextField(
                    controller: ownerLastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name*',
                      labelStyle: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: textColor),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  )),
                ],
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: ownerContactNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Owner Contact Number *',
                  labelStyle: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: textColor),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 51,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OutletTypeTimePage(),
                      ),
                    );
                  },
                  child: Text(
                    'Next',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
