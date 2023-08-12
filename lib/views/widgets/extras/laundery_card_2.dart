import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnselectedCard extends StatelessWidget {
  const UnselectedCard(
      {super.key,
      required this.otherLaundery,
      required this.amount,
      required this.time,
      required this.type,
      required this.selection});

  final void Function(String selection) selection;
  final String type;
  final int amount;
  final List<String> time;
  final String? otherLaundery;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 170,
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: otherLaundery == null ? const Color(0xFF1EA6D6) : Colors.grey,
          child: Column(children: [
            Text(
              type,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              "Amount - Rs " + amount.toString(),
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              "Available slots -",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                direction: Axis.horizontal,
                children: List.generate(
                    time.length,
                    (index) => Container(
                          width: 90,
                          height: 40,
                          child: FloatingActionButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            onPressed: () {
                              otherLaundery == null
                                  ? selection(time[index])
                                  : print("unclikable");
                            },
                            backgroundColor: Colors.white,
                            child: (Text(
                              time[index],
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        )),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class SelectedCard extends StatelessWidget {
  const SelectedCard(
      {super.key,
      required this.amount,
      required this.selectedTime,
      required this.type});
  final String type;
  final int amount;
  final String selectedTime;

  @override
  Widget build(BuildContext context) {
    const buttonColor = Color(0xFF0793C5);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 130,
        child: Card(
          shadowColor: buttonColor,
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.white,
          child: Column(children: [
            Text(
              type,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              "Amount - Rs " + amount.toString(),
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              selectedTime,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            )
          ]),
        ),
      ),
    );
  }
}
