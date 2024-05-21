import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 55),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(181.w, 60.h)),
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Color(0xFFF75555)))),
                ),
                onPressed: () {},
                child: Text(
                  'حذف الحساب',
                  style: TextStyle(
                      fontFamily: 'Portada ARA',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFF75555)),
                )),
            ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(181.w, 60.h)),
                  backgroundColor: MaterialStateProperty.all<Color?>(
                      Color.fromRGBO(19, 169, 179, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                              color: Color.fromRGBO(19, 169, 179, 1)))),
                ),
                onPressed: () {},
                child: Text(
                  'لا',
                  style: TextStyle(
                      fontFamily: 'Portada ARA',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(252, 252, 252, 1)),
                ))
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text('حذف الحساب',
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
                      onPressed: () {Navigator.of(context).pop();},
                      icon: Icon(Icons.arrow_forward))
                ],
              ),
            ),
            // SizedBox(
            //   height: 45,
            // ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              padding:
                  EdgeInsets.only(right: 20, left: 20, top: 25, bottom: 50),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'حذف حسابك نهائي !!',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF2B2F4E),
                        fontSize: 18.sp,
                        fontFamily: 'Portada ARA',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.do_not_disturb_on_sharp,
                      color: Colors.red,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'سوف تفقد بياناتك بشكل نهائي من خلال حذف حسابك',
                  style: TextStyle(
                    color: Color(0xFFFB0000),
                    fontSize: 16.sp,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى',
                  style: TextStyle(
                    color: Color(0xFF2B2F4E),
                    fontSize: 16.sp,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w400,
                  ),
                  textDirection: TextDirection.rtl,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
