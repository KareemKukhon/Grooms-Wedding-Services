import 'dart:developer';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/bottomSheetCard.dart';
import 'package:Rafeed/var/var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MarriageCalculator extends StatefulWidget {
  const MarriageCalculator({Key? key}) : super(key: key);

  @override
  State<MarriageCalculator> createState() => _MarriageCalculatorState();
}

class _MarriageCalculatorState extends State<MarriageCalculator> {
  TextEditingController yearController = TextEditingController();

  String selectedMonth = 'يناير';
  String selectedDay = 'الأحد';
  DateTime? marriageDate;
  List<String> months = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  List<String> days = [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
  ];

  @override
  void initState() {
    super.initState();
    marriageDays != null
        ? WidgetsBinding.instance!.addPostFrameCallback((_) {
            _showBottomSheet();
          })
        : Container();
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetCard(
          onClicked: () {},
          title: 'مبروك تبقي $marriageDays يوم على زفافك',
          subTitle: 'شارك موعد زفافك مع اصدقاءك الان\nلدعوتهم لموعد الزفاف',
          image: 'images/couples.png',
          btn1: '',
          btn2: 'حسنا',
          btn1Color: Colors.black,
          isBtn1: false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    marriageDate = Provider.of<LoginSignup>(context).user!.marriageDate!;
    final daysLeft = calculateDaysToWedding();
    String daysLeftMessage = '';
    if (daysLeft >= 0) {
      marriageDays = daysLeft;
      daysLeftMessage = 'تبقى $daysLeft يوم على زفافك';
    } else {
      daysLeftMessage = 'اختر تاريخ الزفاف';
    }

    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 55),
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(double.infinity, 55)),
            backgroundColor: MaterialStateProperty.all<Color?>(
                Color.fromRGBO(19, 169, 179, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Color.fromRGBO(19, 169, 179, 1)))),
          ),
          onPressed: () async {
            if (marriageDate != null) {
              log(marriageDate.toString());
              await Provider.of<LoginSignup>(context, listen: false)
                  .marriageDateCalc(dateTime: marriageDate ?? DateTime.now());
            }
          },
          child: Text(
            "احسب تاريخ زفافك",
            style: TextStyle(
                fontFamily: 'Portada ARA',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(252, 252, 252, 1)),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text('حاسبة الزواج',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontFamily: 'Portada ARA',
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_forward))
                ],
              ),
              SizedBox(height: 60),
              Image(
                image: AssetImage('images/love.png'),
                width: 155.w,
                height: 155.h,
              ),
              SizedBox(height: 40),
              _buildDatePicker(context),
              SizedBox(height: 15),
              Text(
                daysLeftMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontFamily: 'Portada ARA',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    DateTime marriageDate =
        Provider.of<LoginSignup>(context).user!.marriageDate!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color.fromARGB(255, 179, 179, 179)),
      ),
      child: TextFormField(
        textAlign: TextAlign.right,
        readOnly: true,
        controller: TextEditingController(
          text: marriageDate != null
              ? ('${marriageDate!.year}-${marriageDate!.month}-${marriageDate!.day}')
              : '',
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          suffixIcon: IconButton(
            onPressed: _showDatePicker,
            icon: Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    // DateTime marriageDate = Provider.of<LoginSignup>(context).user!.marriageDate!;
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.teal,
            colorScheme: ColorScheme.light(
              primary: Colors.white,
              onPrimary: Colors.teal,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      // setState(() {
      marriageDate =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
      // });
    }
  }

  int calculateDaysToWedding() {
    DateTime marriageDate =
        Provider.of<LoginSignup>(context).user!.marriageDate!;
    if (marriageDate != null) {
      final today = DateTime.now();
      final difference = marriageDate!.difference(today).inDays;
      return difference;
    } else {
      return -1;
    }
  }
}
