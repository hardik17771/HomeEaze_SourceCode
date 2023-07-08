

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/UI/User/provided_service.dart';

import 'outlet_details.dart';


class OutletTypeTimePage extends StatefulWidget {
  @override
  _OutletTypeTimePageState createState() => _OutletTypeTimePageState();
}

class _OutletTypeTimePageState extends State<OutletTypeTimePage> {
  String outletType = '';
  String selectedDelevery = '';
  String openingHours = '';
  String closingHours = '';
  List<String> openDays = [];

  List<String> deleveryOptions = [
    'Delivery Boy Available',
    'Delivery Boy Not Available',
  ];

  TextEditingController openingHoursController = TextEditingController();
  TextEditingController closingHoursController = TextEditingController();

  @override
  void dispose() {
    openingHoursController.dispose();
    closingHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Outlet Type and Timing",
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 32.0),
          Text('Outlet Type',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16.0),
          Column(
            children: deleveryOptions.map((n) {
              return ListTile(
                iconColor: buttonColor,
                title: Text(n),
                leading: Radio(
                  value: n,
                  groupValue: selectedDelevery,
                  onChanged: (value) {
                    setState(() {
                      selectedDelevery = value.toString();
                    });
                  },
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32.0),
          Text(
            'Outlet Operational Hour',
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Enter Outlet opening and closing hours',
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: openingHoursController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Opening Time *',
                    labelStyle: GoogleFonts.poppins(
                        color: textColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: textColor),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextField(
                  controller: closingHoursController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Closing Time  *',
                    labelStyle: GoogleFonts.poppins(
                        color: textColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: textColor),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32.0),
          Text(' Mark Open Days:',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16.0),
          Text(
            ' do not forget to uncheck your off days !',
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16.0),
          Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: openDays.contains('Monday'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          openDays.add('Monday');
                        } else {
                          openDays.remove('Monday');
                        }
                      });
                    },
                  ),
                  const Text('Monday'),
                  SizedBox(width: screenWidth - 250),
                  Checkbox(
                    value: openDays.contains('Tuesday'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          openDays.add('Tuesday');
                        } else {
                          openDays.remove('Tuesday');
                        }
                      });
                    },
                  ),
                  const Text('Tuesday'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: openDays.contains('Wednesday'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          openDays.add('Wednesday');
                        } else {
                          openDays.remove('Wednesday');
                        }
                      });
                    },
                  ),
                  const Text('Wednesday'),
                  SizedBox(width: screenWidth - 271),
                  Checkbox(
                    value: openDays.contains('Thrusday'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          openDays.add('Thrusday');
                        } else {
                          openDays.remove('Thrusday');
                        }
                      });
                    },
                  ),
                  const Text('Thrusday'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: openDays.contains('Friday'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          openDays.add('Friday');
                        } else {
                          openDays.remove('Friday');
                        }
                      });
                    },
                  ),
                  const Text('Friday'),
                  SizedBox(width: screenWidth - 237),
                  Checkbox(
                    value: openDays.contains('Saturday'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          openDays.add('Saturday');
                        } else {
                          openDays.remove('Saturday');
                        }
                      });
                    },
                  ),
                  const Text('Saturday'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: openDays.contains('Sunday'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          openDays.add('Sunday');
                        } else {
                          openDays.remove('Sunday');
                        }
                      });
                    },
                  ),
                  const Text('Sunday'),
                ],
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                height: 51,
                width: MediaQuery.of(context).size.width - 32,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OutletServicesPage(),
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
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ]),
      ),
    ));
  }
}
