import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguagePicker extends StatefulWidget {
  const LanguagePicker({super.key});

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class LangData {
  String country;
  String flag;
  String lang;
  bool isSelected;
  LangData({
    required this.country,
    required this.flag,
    required this.lang,
    required this.isSelected,
  });
}

class _LanguagePickerState extends State<LanguagePicker> {
  List<LangData> langData = [
    LangData(
      lang: 'اللغة العربية',
      flag: 'SA',
      country: 'ar',
      isSelected: true,
    ),
    LangData(
      lang: 'English',
      flag: 'US',
      country: 'en',
      isSelected: false,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 55),
        child: ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(181.w, 60.h)),
              backgroundColor: MaterialStateProperty.all<Color?>(
                  Color.fromRGBO(19, 169, 179, 1)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side:
                          BorderSide(color: Color.fromRGBO(19, 169, 179, 1)))),
            ),
            onPressed: () {},
            child: Text(
              'حفظ',
              style: TextStyle(
                  fontFamily: 'Portada ARA',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(252, 252, 252, 1)),
            )),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text('اللغة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontFamily: 'Portada ARA',
                    )),
                IconButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder?>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color:
                                        Color.fromARGB(255, 225, 225, 225))))),
                    onPressed: () {Navigator.of(context).pop();},
                    icon: Icon(Icons.arrow_forward))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                suffixText: 'بحث',
                suffixIcon: Icon(
                  Icons.search,
                  color: Color.fromRGBO(202, 202, 202, 1),
                ),
                // hintText: 'بحث',
                floatingLabelAlignment: FloatingLabelAlignment.start,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFEAEAEA),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFEAEAEA),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            for (int i = 0; i < langData.length; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    langData.forEach((element) {
                      element.isSelected = false;
                    });
                    langData[i].isSelected = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                      activeColor: Color.fromRGBO(19, 169, 179, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      value: langData[i].isSelected,
                      onChanged: (value) {
                        setState(() {
                          langData.forEach((element) {
                            element.isSelected = false;
                          });
                          langData[i].isSelected = true;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          langData[i].lang,
                          style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 16.sp,
                            fontFamily: 'DIN Next LT Arabic',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.40,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CountryFlag.fromCountryCode(
                          langData[i].flag,
                          height: 15,
                          width: 20,
                          // borderRadius: 8,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              
          ],
        ),
      ),
    );
  }
}
