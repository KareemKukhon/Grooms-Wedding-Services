import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Rafeed/screen/Booking/termsAndConditions.dart';

class AgreeTermsConditions extends StatefulWidget {
  TextEditingController instruction;
  bool isAgree = false;
  AgreeTermsConditions({
    Key? key,
    required this.instruction,
    required this.isAgree,
  }) : super(key: key);

  @override
  State<AgreeTermsConditions> createState() => _AgreeTermsConditionsState();
}

class _AgreeTermsConditionsState extends State<AgreeTermsConditions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildInstructionsTextField(),
        _buildTermsAndConditionsRow(),
      ],
    );
  }

  Widget _buildInstructionsTextField() {
    return Container(
      height: 350.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        maxLines: null,
        controller: widget.instruction,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'تعليمات لمقدم الخدمة ( اختياري )',
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 16.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w400,
            height: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildTermsAndConditionsRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTermsText(),
        _buildTermsButton(),
        _buildAgreeText(),
        _buildAgreeCheckbox(),
      ],
    );
  }

  Widget _buildTermsText() {
    return Text(
      ' الخاصه بالحجز  ( يجب الموافقة )',
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 12.sp,
        fontFamily: 'Portada ARA',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTermsButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TermsAndConditions(),
        ));
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
          EdgeInsets.symmetric(horizontal: 3.w),
        ),
      ),
      child: Text(
        'الشروط والاحكام',
        style: TextStyle(
          color: Color(0xFF13A9B3),
          fontSize: 12.sp,
          fontFamily: 'Portada ARA',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAgreeText() {
    return Text(
      'اوفق علي ',
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 12.sp,
        fontFamily: 'Portada ARA',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildAgreeCheckbox() {
    return Checkbox(
      value: widget.isAgree,
      activeColor: Color(0xFF13A9B3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      side: BorderSide(color: Colors.grey[300]!, width: 3.w),
      onChanged: (value) {
        setState(() {
          widget.isAgree = !widget.isAgree;
        });
      },
    );
  }
}
