import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonQuestion extends StatelessWidget {
  const CommonQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 242, 242, 242).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text('الأسئلة الشائعة',
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
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 212, 213, 216),
                    ),
                    hintText: 'بحث',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 199, 200, 203)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 212, 213, 216)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 212, 213, 216)),
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              for (int i = 0; i < 5; i++)
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.question_mark_outlined,
                            color: Color(0xFF13A9B3),
                          ),
                          Text(
                            'هذا النص هو مثال لنص يمكن',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF2B2F4E),
                              fontSize: 18.sp,
                              fontFamily: 'DIN Next LT Arabic',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Text(
                        'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF2B2F4E),
                          fontSize: 14.sp,
                          fontFamily: 'DIN Next LT Arabic',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
