import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class PaymentMethodData {
  final String name;
  final String image;
  bool isSelected;

  PaymentMethodData({
    required this.name,
    required this.image,
    required this.isSelected,
  });
}

class _PaymentMethodState extends State<PaymentMethod> {
  List<PaymentMethodData> paymentMethodData = [
    PaymentMethodData(
      name: 'الدفع باستخدام بطاقة الدفع',
      image: 'images/masterCard.png',
      isSelected: true,
    ),
    PaymentMethodData(
      name: 'الدفع باستخدام مدى',
      image: 'images/madaCash.png',
      isSelected: false,
    ),
    PaymentMethodData(
      name: 'الدفع باستخدام ابل باي',
      image: 'images/apple.png',
      isSelected: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 227, 227, 227).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: _buildPaymentMethods(),
      ),
    );
  }

  List<Widget> _buildPaymentMethods() {
    return List.generate(
      paymentMethodData.length,
      (index) => _buildPaymentMethod(index),
    );
  }

  Widget _buildPaymentMethod(int index) {
    final data = paymentMethodData[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          paymentMethodData.forEach((element) {
            element.isSelected = false;
          });
          data.isSelected = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: data.isSelected ? const Color(0xFF13A9B3) : const Color.fromARGB(255, 224, 224, 224),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              activeColor: const Color.fromRGBO(19, 169, 179, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              value: data.isSelected,
              onChanged: (value) {
                setState(() {
                  paymentMethodData.forEach((element) {
                    element.isSelected = false;
                  });
                  data.isSelected = true;
                });
              },
            ),
            Row(
              children: [
                Text(
                  data.name,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 62, 68, 112),
                    fontSize: 14.sp,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Image(
                  image: AssetImage(data.image),
                  width: 45,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
