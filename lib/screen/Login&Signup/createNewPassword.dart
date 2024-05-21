import 'dart:async';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/bottomSheetCard.dart';
import 'package:Rafeed/component/customTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CreateNewPassword extends StatefulWidget {
  final bool forgetPasswordFlag;

  const CreateNewPassword({Key? key, required this.forgetPasswordFlag})
      : super(key: key);

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  int _seconds = 10; // Initial countdown value
  late Timer _timer;
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer.cancel(); // Stop the timer when countdown reaches 0
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(height: 50.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_forward_rounded),
                ),
                SizedBox(height: 20.h),
                Center(
                    child: Image(
                        image: AssetImage("images/createNewPassword.png"))),
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    'إنشاء كلمة سر جديدة',
                    style: TextStyle(
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: Color.fromRGBO(43, 47, 78, 1),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'يرجى اضافة كلمة سر جديده للحفاظ على بياناتك حسابك ..',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Portada ARA',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(176, 176, 176, 1),
                  ),
                ),
                SizedBox(height: 50.h),
                CustomTextField(
                    text: 'ادخال كلمة السر الجديدة',
                    controller: _newPasswordController),
                SizedBox(height: 20.h),
                CustomTextField(
                    text: 'اعادة ادخال كلمة السر الجديدة',
                    controller: _confirmPasswordController),
                SizedBox(height: 20.h),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_newPasswordController.text ==
                          _confirmPasswordController.text) {
                        Provider.of<LoginSignup>(context, listen: false)
                            .resetPassword(_newPasswordController.text);
                      } else {
                        // Show error message
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'تأكيد',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: "Portada ARA",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(19, 169, 179, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          // side: BorderSide(color: Colors.red)
                        ))),
                  ),
                ),
              ],
            ),
            widget.forgetPasswordFlag ? buildFooterText() : Container(),
          ],
        ),
      ),
    );
  }

  // Widget buildTextField(String hintText) {
  //   return TextFormField(
  //     textDirection: TextDirection.rtl,
  //     textAlign: TextAlign.right,
  //     textInputAction: TextInputAction.done,
  //     obscureText: true,
  //     // cursorColor: kPrimaryColor,
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(15),
  //         borderSide: BorderSide(color: Color.fromRGBO(245, 245, 245, 1)),
  //       ),
  //       hintText: hintText,
  //       alignLabelWithHint: true,
  //       suffixIcon: Padding(
  //         padding: EdgeInsets.all(5),
  //         child: Icon(Icons.lock_outline_rounded),
  //       ),
  //     ),
  //   );
  // }

  Widget buildFooterText() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'انشاء حساب جديد ',
            style: TextStyle(
              fontFamily: 'Portada ARA',
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: Color.fromRGBO(19, 169, 179, 1),
            ),
          ),
          Text(
            'ليس لديك حساب ؟ ',
            style: TextStyle(
              fontFamily: 'Portada ARA',
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: Color.fromRGBO(43, 47, 78, 1),
            ),
          ),
        ],
      ),
    );
  }
}
