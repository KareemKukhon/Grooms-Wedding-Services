import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Rafeed/component/customRadio.dart';
import 'package:Rafeed/models/orderModel.dart';
import 'package:Rafeed/models/serviceModel.dart';
import 'package:Rafeed/screen/Booking/cardInformation.dart';
import 'package:Rafeed/screen/Booking/pays.dart';
import 'package:Rafeed/screen/Booking/pymentMethod.dart';

class SendTip extends StatefulWidget {
  ServiceModel service;
  Order order;
  SendTip({
    Key? key,
    required this.service,
    required this.order,
  }) : super(key: key);

  @override
  State<SendTip> createState() => _SendTipState();
}

class _SendTipState extends State<SendTip> {
  int _value = 0;
  TextEditingController tipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      side:
                          BorderSide(color: Color.fromRGBO(19, 169, 179, 1)))),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CardInformation(
                  serviceModel: widget.service,
                  order: widget.order,
                  tip: _value == 1
                      ? 100
                      : _value == 2
                          ? 300
                          : _value == 3
                              ? 500
                              : _value == 4
                                  ? 200
                                  : _value == 5
                                      ? 400
                                      : int.parse(tipController.text),
                ),
              ));
            },
            child: Text(
              'ارسال اكرامية',
              style: TextStyle(
                  fontFamily: 'Portada ARA',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(252, 252, 252, 1)),
            )),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 35, right: 20, left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text('ارسال اكرامية',
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
                height: 35,
              ),
              Text(
                'اختيار قيمة الاكرامية ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF086C6A),
                  fontSize: 16.sp,
                  fontFamily: 'Portada ARA',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomRadio(
                        checkButton: false,
                        textValue: '200 ريال',
                        value: 4,
                        groupValue: _value,
                        filledColor: true,
                        onChange: (int? p0) {
                          setState(() {
                            _value = p0!;
                            tipController.clear();
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomRadio(
                        checkButton: false,
                        textValue: '400 ريال',
                        value: 5,
                        groupValue: _value,
                        filledColor: true,
                        onChange: (int? p0) {
                          setState(() {
                            _value = p0!;
                            tipController.clear();
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: 180.w,
                          height: 60.h,
                          child: TextField(
                            controller: tipController,
                            onTap: () => setState(() {
                              _value = 0;
                            }),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFEAEAEA), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      CustomRadio(
                        checkButton: false,
                        textValue: '100 ريال',
                        value: 1,
                        groupValue: _value,
                        filledColor: true,
                        onChange: (int? p0) {
                          setState(() {
                            _value = p0!;
                            tipController.clear();
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomRadio(
                        checkButton: false,
                        textValue: '300 ريال',
                        value: 2,
                        groupValue: _value,
                        filledColor: true,
                        onChange: (int? p0) {
                          setState(() {
                            _value = p0!;
                            tipController.clear();
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomRadio(
                        checkButton: false,
                        textValue: '500 ريال',
                        value: 3,
                        groupValue: _value,
                        filledColor: true,
                        onChange: (int? p0) {
                          setState(() {
                            _value = p0!;
                            tipController.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
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
              SizedBox(
                height: 20,
              ),
              PaymentMethod()
            ],
          ),
        ),
      ),
    );
  }
}
