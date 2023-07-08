import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'outlet_details.dart';

class OutletServicesPage extends StatefulWidget {
  const OutletServicesPage({super.key});

  @override
  _OutletServicesPageState createState() => _OutletServicesPageState();
}

class _OutletServicesPageState extends State<OutletServicesPage> {
  List<String> selectedServices = [];

  List<String> availableServices = [
    'Washing',
    'Ironing',
    'Dry Cleaning',
    'Stitching',
  ];

  TextEditingController otherServiceController = TextEditingController();

  @override
  void dispose() {
    otherServiceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 51,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            onPressed: () {},
            child: Text(
              'Next',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 64,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "Outlet Services",
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'You are almost done!',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Check the services you provide',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: availableServices.map((service) {
                  return Row(
                    children: [
                      Checkbox(
                        value: selectedServices.contains(service),
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              selectedServices.add(service);
                            } else {
                              selectedServices.remove(service);
                            }
                          });
                        },
                      ),
                      Text(
                        service,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Add any other service you provide',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: otherServiceController,
                decoration: const InputDecoration(
                  labelText: 'Other Service',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "Thanks for your inputs. Based on customer feedback, new services coming soon!",
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic),
              )
            ],
          ),
        ),
      ),
    );
  }
}
