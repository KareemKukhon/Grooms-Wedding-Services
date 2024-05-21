import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/bottomSheetCard.dart';
import 'package:Rafeed/component/customTextField.dart';
import 'package:Rafeed/models/orderModel.dart';
import 'package:Rafeed/models/serviceModel.dart';
import 'package:Rafeed/screen/Booking/pays.dart';
import 'package:Rafeed/screen/bottomBarPages/bottomBar.dart';

class CardInformation extends StatelessWidget {
  int? tip;
  ServiceModel? serviceModel;
  Order? order;
  CardInformation({
    Key? key,
    this.tip,
    this.serviceModel,
    this.order,
  }) : super(key: key);
  TextEditingController _cardNameController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // bottomNavigationBar: _buildBottomNavigationBar(context),
      body: CardPaymentMethods(
        service:
            serviceModel ?? Provider.of<LoginSignup>(context).slectedService!,
        order: order,
        price: tip,
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 55.h),
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheetCard(
              onClicked: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BottomBar(),
                ));
              },
              image: 'images/approve.png',
              title: 'تم طلب الخدمة بنجاح ',
              subTitle: 'شكرا لاستخدامكم تطبيق رفيد نتمني لك تجربة ممتعة ️',
              btn1: 'الرئيسية',
              btn2: 'متابعة الطلب',
              btn1Color: Color(0xFF13A9B3),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 55.h),
          backgroundColor: Color.fromRGBO(19, 169, 179, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Color.fromRGBO(19, 169, 179, 1)),
          ),
        ),
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
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildPageHeader(context),
            SizedBox(height: 80.h),
            Center(
                child: Image(
                    image: AssetImage('images/masterCard.png'), width: 200.w)),
            Text(
              'بيانات بطاقة الدفع ',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF086C6A),
                fontSize: 16.sp,
                fontFamily: 'Portada ARA',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20.h),
            _buildCardDetailsForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
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
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Color.fromARGB(255, 225, 225, 225)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardDetailsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
            text: "الاسم على البطاقة", controller: _cardNameController),
        SizedBox(height: 10.h),
        CustomTextField(
          text: 'رقم البطاقة',
          controller: _cardNumberController,
          type: TextInputType.number,
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                onSaved: (value) {},
                inputFormatters: [LengthLimitingTextInputFormatter(2)],
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFEAEAEA)),
                  ),
                  hintText: "سنة",
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                onSaved: (value) {},
                inputFormatters: [LengthLimitingTextInputFormatter(2)],
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0xFFEAEAEA)),
                  ),
                  hintText: "شهر",
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        TextFormField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          onSaved: (value) {},
          inputFormatters: [LengthLimitingTextInputFormatter(3)],
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xFFEAEAEA)),
            ),
            hintText: 'الرقم السري',
          ),
        ),
      ],
    );
  }
}
