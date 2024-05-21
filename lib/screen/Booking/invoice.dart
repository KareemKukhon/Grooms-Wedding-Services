import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Rafeed/models/serviceModel.dart';
import 'package:Rafeed/screen/Booking/cardInformation.dart';
import 'package:Rafeed/screen/Booking/pymentMethod.dart';

class Invoice extends StatelessWidget {
  ServiceModel service;
  Invoice({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 55),
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(double.infinity, 55)),
            backgroundColor: MaterialStateProperty.all<Color?>(
              Color.fromRGBO(19, 169, 179, 1),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(color: Color.fromRGBO(19, 169, 179, 1)),
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CardInformation(),
              ),
            );
          },
          child: Text(
            'دفع قيمة الخدمة',
            style: TextStyle(
              fontFamily: 'Portada ARA',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(252, 252, 252, 1),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildHeader(context),
              SizedBox(height: 25),
              _buildCouponInput(),
              SizedBox(height: 20),
              _buildInvoiceSection(),
              SizedBox(height: 30),
              _buildPaymentMethodSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Text(
          'حجز الخدمة',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontFamily: 'Portada ARA',
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_forward),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder?>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Color.fromARGB(255, 225, 225, 225),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCouponInput() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 224, 224, 224)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          TextButton(onPressed: () {}, child: Text('تطبيق')),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: 'كوبون الخصم',
                hintTextDirection: TextDirection.rtl,
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 16.sp,
                  fontFamily: 'Portada ARA',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Icon(Icons.discount_rounded, color: Color(0xFF13A9B3)),
        ],
      ),
    );
  }

  Widget _buildInvoiceSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 224, 224, 224)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildInvoiceItem('${service.price} ريال', 'قيمة حجز الخدمة'),
          SizedBox(height: 20),
          // _buildInvoiceItem('- 60 ريال', 'الخصم'),
          SizedBox(height: 20),
          _buildInvoiceItem('${service.price} ريال', 'الاجمالى',
              textColor: Color(0xFF13A9B3)),
        ],
      ),
    );
  }

  Widget _buildInvoiceItem(String value, String title, {Color? textColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: textColor ?? Color(0xFF2B2F4E),
            fontSize: 14.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: textColor ?? Color(0xFF2B2F4E),
            fontSize: 14.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'اختر طريقة الدفع المناسبه',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFF086C6A),
            fontSize: 16.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20),
        PaymentMethod(),
      ],
    );
  }
}
