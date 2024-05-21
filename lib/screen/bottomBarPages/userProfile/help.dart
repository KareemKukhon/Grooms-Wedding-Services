import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/models/settingsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpData {
  final String title;
  final Widget icon;

  HelpData({required this.title, required this.icon});
}

class Help extends StatelessWidget {
  Help({super.key});

  final List<HelpData> helpData = [
    HelpData(
        title: 'تحدث معنا',
        icon: Icon(
          Icons.mark_email_read_sharp,
          color: Color(0xFF13A9B3),
        )),
    HelpData(
        title: 'واتساب',
        icon: Icon(
          Icons.phone,
          color: Color(0xFF13A9B3),
        )),
    HelpData(
        title: 'موقع التطبيق',
        icon: Icon(
          Icons.web_sharp,
          color: Color(0xFF13A9B3),
        )),
    HelpData(
        title: 'تويتر',
        icon: Icon(
          Icons.close,
          color: Color(0xFF13A9B3),
        )),
    HelpData(
        title: 'قيسبوك',
        icon: Icon(
          Icons.facebook,
          color: Color(0xFF13A9B3),
        )),
  ];

  @override
  Widget build(BuildContext context) {
    SettingsModel? settingsModel = Provider.of<LoginSignup>(context).settings;
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text('المساعدة',
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
                                      color: Color.fromARGB(
                                          255, 225, 225, 225))))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_forward))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'من نحن',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF2B2F4E),
                  fontSize: 14.sp,
                  fontFamily: 'Portada ARA',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Color(0xFFEEEEEE),
              ),
              Text(
                settingsModel!.description ?? "",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF2B2F4E),
                  fontSize: 14.sp,
                  fontFamily: 'Portada ARA',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'تواصل معنا ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF2B2F4E),
                  fontSize: 14.sp,
                  fontFamily: 'Portada ARA',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Divider(
                color: Color(0xFFEEEEEE),
              ),
              GestureDetector(
                onTap: () {
                  _launchEmailComposer();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 224, 224, 224)),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        helpData[0].title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16.sp,
                          fontFamily: 'DIN Next LT Arabic',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      helpData[0].icon
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchURL("whatsapp://send?phone=+966538570501");
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 224, 224, 224)),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        helpData[1].title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16.sp,
                          fontFamily: 'DIN Next LT Arabic',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      helpData[1].icon
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchURL('https://rafeed.sa/');
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 224, 224, 224)),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        helpData[2].title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16.sp,
                          fontFamily: 'DIN Next LT Arabic',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      helpData[2].icon
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchURL(settingsModel.twitter);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 224, 224, 224)),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        helpData[3].title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16.sp,
                          fontFamily: 'DIN Next LT Arabic',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      helpData[3].icon
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchURL(settingsModel.facebook);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 224, 224, 224)),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        helpData[4].title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16.sp,
                          fontFamily: 'DIN Next LT Arabic',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      helpData[4].icon
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void _launchURL(String? facebookUrl) async {
    final Uri url = Uri.parse(facebookUrl ?? "");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      await launchUrl(url);
    }
  }

  Future<void> _launchEmailComposer() async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: 'info@rafeed.sa',
    );
    if (!await launchUrl(url)) {
      throw 'Could not launch email app';
    }
  }
}
