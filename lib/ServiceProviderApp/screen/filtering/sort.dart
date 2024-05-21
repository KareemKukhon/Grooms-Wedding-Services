import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customRadio.dart';


class Sort extends StatefulWidget {
  const Sort({Key? key}) : super(key: key);

  @override
  State<Sort> createState() => _SortState();
}

class _SortState extends State<Sort> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomRadio(
            filledColor: false,
            textValue: 'الاكثر شهرة',
            value: 0,
            groupValue: _value,
            onChange: (int? value) {
              setState(() {
                _value = value!;
              });
            },
          ),
          CustomRadio(
            filledColor: false,
            textValue: 'السعر من الأعلى إلى الأقل',
            value: 1,
            groupValue: _value,
            onChange: (int? value) {
              setState(() {
                _value = value!;
              });
            },
          ),
          CustomRadio(
            filledColor: false,
            textValue: 'السعر من الاقل للأعلي',
            value: 2,
            groupValue: _value,
            onChange: (int? value) {
              setState(() {
                _value = value!;
              });
            },
          ),
          CustomRadio(
            filledColor: false,
            textValue: 'الاحدث فقط',
            value: 3,
            groupValue: _value,
            onChange: (int? value) {
              setState(() {
                _value = value!;
              });
            },
          ),
          CustomRadio(
            filledColor: false,
            textValue: 'الاقدم فقط',
            value: 4,
            groupValue: _value,
            onChange: (int? value) {
              setState(() {
                _value = value!;
              });
            },
          ),
          CustomRadio(
            filledColor: false,
            textValue: 'الاقرب فقط',
            value: 5,
            groupValue: _value,
            onChange: (int? value) {
              setState(() {
                _value = value!;
              });
            },
          ),
          CustomRadio(
            filledColor: false,
            textValue: 'خدمات بدون تقييم',
            value: 6,
            groupValue: _value,
            onChange: (int? value) {
              setState(() {
                _value = value!;
              });
            },
          ),
          SizedBox(height: 55.h),
        ],
      ),
    );
  }
}
