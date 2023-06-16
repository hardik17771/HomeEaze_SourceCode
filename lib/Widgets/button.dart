import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttons(String textToWrigth, double screenWidth, double screenHeight) {
  return Container(
    margin: EdgeInsets.only(top: screenHeight * .05, left: screenWidth * .025),
    width: screenWidth * .95,
    height: screenHeight * .10,
    child: GestureDetector(
        onTap: () {

        },
        child: FloatingActionButton(
            onPressed: () {},
            child: Text(
              textToWrigth,
              style: GoogleFonts.poppins(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  fontSize: 17),
            ),
            backgroundColor: Color(0xFF0793C5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ))),
  );
}

AddButton(String text, double screenWidth, double screenHeight) {
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
        Text(text,
            style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
        // SizedBox(
        //   width: scre,
        // ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.add),
          label: Text('Add'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    ),
  );
}

class AddButtons extends StatefulWidget {
  String text;
  AddButtons(this.text);
  @override
  _AddButtonsState createState() => _AddButtonsState(this.text);
}

class _AddButtonsState extends State<Buttons> {
  String text;
  int count = 0; // Keep track of button tap count
  bool isTapped = false; // Keep track of button tap state

  _AddButtonsState(this.text);

  void _onTapDown(TapDownDetails details) {
    setState(() {
      // Update the state when the button is tapped down
      isTapped = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      // Update the state when the button is released
      isTapped = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      // Update the state when the tap is cancelled (e.g., if user swipes away from the button)
      isTapped = false;
    });
  }

  void _onButtonPressed() {
    setState(() {
      // Update the state when the button is pressed
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(color: Colors.black, width: 0.08))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          FloatingActionButton.extended(
            onPressed: () {
              _onButtonPressed();
            },
            icon: Icon(Icons.add),
            label: Text(count > 0 ? 'Clicked $count times' : 'Add'),
            backgroundColor: isTapped
                ? Colors.white
                : Colors.blue, // Update button color when tapped
            foregroundColor: Colors.blue, // Update text color when tapped
          ),
        ],
      ),
    );
  }
}

class Buttons extends StatefulWidget {
  String text;
  Buttons(this.text);
  @override
  _ButtonsState createState() => _ButtonsState(this.text);
}

class _ButtonsState extends State<Buttons> {
  String text;

  _ButtonsState(this.text);

  bool isTapped = false; // Keep track of button tap state

  void _onTapDown(TapDownDetails details) {
    setState(() {
      // Update the state when the button is tapped down
      isTapped = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      // Update the state when the button is released
      isTapped = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      // Update the state when the tap is cancelled (e.g., if user swipes away from the button)
      isTapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin:
          EdgeInsets.only(top: screenHeight * .04, left: screenWidth * .025),
      width: screenWidth * .95,
      height: screenHeight * .12,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: FloatingActionButton(
          onPressed: () {},
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: isTapped
                  ? Colors.black
                  : Color(0xFFFFFFFF), // Update text color based on tap state
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              fontSize: 17,
            ),
          ),
          backgroundColor: isTapped
              ? Colors.white
              : Color(0xFF0793C5), // Update background color based on tap state
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
