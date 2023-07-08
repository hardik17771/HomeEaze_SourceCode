import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Widgets/customRowWithTwoTextFields.dart';

class Createitem extends StatefulWidget {
  @override
  _CreateitemState createState() => _CreateitemState();
}

class _CreateitemState extends State<Createitem>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  TextEditingController firstController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // final _form1 = GlobalKey<FormState>();
  // void _saveForm1() {
  //   final isValid = _form1.currentState?.validate();
  //   if (!isValid!) {
  //     return;
  //   }
  // }
  // final _form2 = GlobalKey<FormState>();
  // void _saveForm2() {
  //   final isValid = _form2.currentState?.validate();
  //   if (!isValid!) {
  //     return;
  //   }
  // }final _form3 = GlobalKey<FormState>();
  // void _saveForm3() {
  //   final isValid = _form3.currentState?.validate();
  //   if (!isValid!) {
  //     return;
  //   }
  // }final _form4 = GlobalKey<FormState>();
  // void _saveForm4() {
  //   final isValid = _form4.currentState?.validate();
  //   if (!isValid!) {
  //     return;
  //   }
  // }final _form5 = GlobalKey<FormState>();
  // void _saveForm5() {
  //   final isValid = _form5.currentState?.validate();
  //   if (!isValid!) {
  //     return;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double heigh = MediaQuery.of(context).size.height;
    double widt = MediaQuery.of(context).size.width;
    List<String> options = [

      'Unit Type 1',
      'Unit Type 2',
      'Unit Type 3',
      'Unit Type 4',

    ];

    String? selectedOption1;
    String? selectedOption2;


    return SafeArea(

      child: Scaffold(
        resizeToAvoidBottomInset:false ,
        bottomNavigationBar: const BottomAppBar(
          color: Colors.white,



        ),
        floatingActionButton: Stack(

          children: <Widget>[Positioned(
            bottom: 0,
            left: widt*0.25,
            right:widt*0.2,

            child: Container(

              width: widt*0.6,
              height: heigh*0.05,
              child: FloatingActionButton(

                backgroundColor: const Color(0xFFFFCC00),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                onPressed: null,
                child: Text(
                  'save'.tr,
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ],
        ),

        backgroundColor: const Color(0xFFF4E5FF),
        appBar: AppBar(
          backgroundColor: const Color(0xFF4B49AC),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 22,
            ),
            onPressed: () {
              setState(() {
                var locale=Locale('hi','IN');
                Get.updateLocale(locale);
              });
            },
          ),
          title: Text(
            'create_item'.tr,
            style: GoogleFonts.publicSans(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: heigh * 0.28,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(widt * 0.045),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: heigh * 0.009,
                      ),
                      Container(
                        height: heigh * 0.055,
                        child: TextFormField(
                          decoration: InputDecoration(
                            focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFFB6B6B6),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'please_enter_item_name'.tr,
                            labelText: 'item_name'.tr,
                            labelStyle: GoogleFonts.publicSans(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B49AC),
                                fontSize: 20,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFFB6B6B6),
                              ),
                            ),
                          ),
                          controller: firstController,
                        ),
                      ),
                      SizedBox(
                        height: heigh * 0.026,
                      ),
                      Container(
                        height: heigh * 0.056,
                        child: TextFormField(
                          decoration: InputDecoration(
                            focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFFB6B6B6),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'please_enter_print_name'.tr,
                            labelText: 'print_name'.tr,
                            labelStyle: GoogleFonts.publicSans(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B49AC),
                                fontSize: 20,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFFB6B6B6),
                              ),
                            ),
                          ),
                          controller: firstController,
                        ),
                      ),
                      SizedBox(
                        height: heigh * 0.022,
                      ),

                      Container(


                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFB6B6B6),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DropdownSearch<String>(

                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                          ),
                          items: options,
                          onChanged: (value) {
                            setState(() {
                              selectedOption1 = value;
                            });
                          },
                          dropdownButtonProps: DropdownButtonProps(
                            isVisible: true,

                          ),

                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              floatingLabelStyle: TextStyle(

                              ),
                              floatingLabelBehavior:
                              FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),



                              hintText: 'select_group_name'.tr,
                              border: InputBorder.none,
                            ),),

                          selectedItem: selectedOption1,
                        ),

                      ),
                    ],
                  ),
                ),
              ),

            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                color: Colors.white,
              ),
              // color: Color(0xFFF4E5FF),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: const Color(0xFF4B49AC),
                controller: _tabController,
                tabs: [
                  Tab(
                    text: null,
                    child: Text(
                      'General',
                      style: GoogleFonts.publicSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4B49AC),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    text: null,
                    child: Text(
                      'Add Specification',
                      style: GoogleFonts.publicSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4B49AC),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    text: null,
                    child: Text(
                      'Store Specification',
                      style: GoogleFonts.publicSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4B49AC),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(

                  color: Colors.white,
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                      children: <Widget>[
                        SizedBox(
                          height: heigh * 0.04,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Container(

                                height: heigh * 0.08,

                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    focusedBorder:  OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFB6B6B6),
                                      ),
                                    ),
                                    filled: true,

                                    fillColor: Colors.white,
                                    hintText: 'XXXXX',
                                    labelText: 'item_code'.tr,
                                    labelStyle: GoogleFonts.publicSans(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4B49AC),
                                        fontSize: 16,
                                      ),
                                    ),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 8),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFB6B6B6),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: widt * 0.02),
                            Container(

                              margin: const EdgeInsets.only(right:8),

                              width: widt*0.46,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(0xFFB6B6B6),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:  DropdownSearch<String>(
                                popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                ),
                                items: options,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption2 = value;
                                  });
                                },
                                dropdownButtonProps: DropdownButtonProps(

                                ),


                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    floatingLabelStyle: TextStyle(

                                    ),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 8),



                                    hintText: 'unit_type'.tr,
                                    border: InputBorder.none,
                                  ),),
                                enabled: true,
                                selectedItem: selectedOption2,
                              ),
                            ),


                          ],
                        ),

                        CustomRowWithTwoTextFields(hinttext1: '00.00', labeltext1: 'opening_qty'.tr, textController1: firstController,
                            hinttext2: '00.00', labeltext2: 'closing_qty'.tr, textController2: firstController),
                        SizedBox(
                          height: heigh * 0.008,
                        ),
                        CustomRowWithTwoTextFields(hinttext1: '00.00', labeltext1: 'purchase_rate'.tr, textController1: firstController,
                            hinttext2: '00.00', labeltext2: 'sale_rate'.tr, textController2: firstController),
                        SizedBox(
                          height: heigh * 0.008,
                        ),
                        CustomRowWithTwoTextFields(hinttext1: '00.00'.tr, labeltext1: 'min_sale_rate'.tr, textController1: firstController,
                            hinttext2: '00.00', labeltext2:  'mrp'.tr, textController2: firstController),
                        SizedBox(
                          height: heigh * 0.008,
                        ),
                        CustomRowWithTwoTextFields(hinttext1: '00.00', labeltext1: 'opening_stock_value'.tr, textController1: firstController,
                            hinttext2: '00.00', labeltext2: 'closing_stock_value'.tr, textController2: firstController),

                        SizedBox(
                          height: heigh * 0.008,
                        ),
                      ],
                    ),
                    ListView(
                      children: <Widget>[
                        SizedBox(
                          height: heigh * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: heigh * 0.08,
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB6B6B6),
                                    ),
                                  ),
                                  hintText: 'XXXXXXXXXX',
                                  labelText: 'PAN Number',
                                  labelStyle: GoogleFonts.publicSans(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4B49AC),
                                      fontSize: 16,
                                    ),
                                  ),

                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 8),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB6B6B6),
                                    ),
                                  ),
                                ),
                                controller: firstController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: heigh * 0.01,
                        ),
                        Container(
                          height: heigh * 0.08,
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            decoration: InputDecoration(
                              focusedBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB6B6B6),
                                ),
                              ),
                              hintText: 'Ex: State Bank Of India',
                              labelText: 'Bank Name',
                              labelStyle: GoogleFonts.publicSans(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4B49AC),
                                  fontSize: 16,
                                ),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB6B6B6),
                                ),
                              ),
                            ),
                            controller: firstController,
                          ),
                        ),
                        SizedBox(
                          height: heigh * 0.01,
                        ),
                        Container(
                          height: heigh * 0.08,
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            decoration: InputDecoration(
                              focusedBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB6B6B6),
                                ),
                              ),

                              labelText: 'Bank A/C Number',
                              hintText: 'Ex: 000000000',
                              labelStyle: GoogleFonts.publicSans(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4B49AC),
                                  fontSize: 16,
                                ),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB6B6B6),
                                ),
                              ),
                            ),
                            controller: firstController,
                          ),
                        ),
                        SizedBox(
                          height: heigh * 0.01,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: heigh * 0.08,
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB6B6B6),
                                    ),
                                  ),
                                  labelText: 'IFSC Code',
                                  hintText: 'SBINXXXXX',
                                  labelStyle: GoogleFonts.publicSans(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4B49AC),
                                      fontSize: 16,
                                    ),
                                  ),
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 8),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB6B6B6),
                                    ),
                                  ),
                                ),
                                controller: firstController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: heigh * 0.01,
                        ),
                        Container(
                          color: Colors.white,
                          height: heigh * 0.08,
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            decoration: InputDecoration(
                              focusedBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB6B6B6),
                                ),
                              ),

                              labelText: 'GSTIN Number',
                              hintText: 'XXXXXXXXXXXXXXXX',
                              labelStyle: GoogleFonts.publicSans(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4B49AC),
                                  fontSize: 16,
                                ),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB6B6B6),
                                ),
                              ),
                            ),
                            controller: firstController,
                          ),
                        ),
                        SizedBox(
                          height: heigh * 0.01,
                        ),
                      ],
                    ),
                    ListView(
                      children: <Widget>[
                        SizedBox(
                          height: heigh * 0.04,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                height: heigh * 0.08,
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    focusedBorder:  OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFB6B6B6),
                                      ),
                                    ),
                                    labelText: 'City',
                                    hintText: 'London',
                                    labelStyle: GoogleFonts.publicSans(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4B49AC),
                                        fontSize: 16,
                                      ),
                                    ),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 8),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Color(0xFFB6B6B6),
                                      ),
                                    ),
                                  ),
                                  controller: firstController,
                                ),
                              ),
                            ),

                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: heigh * 0.08,
                                    padding: const EdgeInsets.all(8),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        focusedBorder:  OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB6B6B6),
                                          ),
                                        ),
                                        labelText: 'Pincode',
                                        hintText: 'Ex: 262402',
                                        labelStyle: GoogleFonts.publicSans(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF4B49AC),
                                            fontSize: 16,
                                          ),
                                        ),
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        contentPadding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 8),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB6B6B6),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: heigh * 0.01,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: heigh * 0.08,
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB6B6B6),
                                    ),
                                  ),
                                  labelText: 'Email ID',
                                  hintText: 'Ex: rajeev17@gmail.com',
                                  labelStyle: GoogleFonts.publicSans(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4B49AC),
                                      fontSize: 16,
                                    ),
                                  ),
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 8),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB6B6B6),
                                    ),
                                  ),
                                ),
                                controller: firstController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: heigh * 0.01,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: heigh * 0.08,
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB6B6B6),
                                    ),
                                  ),
                                  labelText: 'Contact Number',
                                  hintText: 'Ex: 9999999999',
                                  labelStyle: GoogleFonts.publicSans(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4B49AC),
                                      fontSize: 16,
                                    ),
                                  ),
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 8),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFB6B6B6),
                                    ),
                                  ),
                                ),
                                controller: firstController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: heigh * 0.01,
                        ),
                        Container(
                          height: heigh * 0.08,
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            decoration: InputDecoration(
                              focusedBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB6B6B6),
                                ),
                              ),
                              labelText: 'Paylimit',
                              hintText: '00.00',
                              labelStyle: GoogleFonts.publicSans(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4B49AC),
                                  fontSize: 16,
                                ),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB6B6B6),
                                ),
                              ),
                            ),
                            controller: firstController,
                          ),
                        ),
                        SizedBox(
                          height: heigh * 0.01,
                        ),
                        Container(
                          height: heigh * 0.08,
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            decoration: InputDecoration(
                              focusedBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB6B6B6),
                                ),
                              ),
                              labelText: 'Credit Days',
                              hintText: '00',
                              labelStyle: GoogleFonts.publicSans(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4B49AC),
                                  fontSize: 16,
                                ),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB6B6B6),
                                ),
                              ),
                            ),
                            controller: firstController,
                          ),
                        ),
                        SizedBox(
                          height: heigh * 0.01,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
