import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/filtering/searchPage.dart';


class Filtering extends StatefulWidget {
  int index;
  Filtering({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<Filtering> createState() => _FilteringState();
}

class _FilteringState extends State<Filtering> {
  List<String> question = ['ما الذي تبحث عنه؟', 'المدينة', 'السعر', 'التقييم'];
  List<String> list1 = <String>['قاعات زفاف', 'مصور', 'فرقة زفه', 'تزيين زفاف'];
  List<String> list2 = <String>['جدة', 'الرياض', 'المدينة المنورة', 'مكة'];
  List<String> list3 = <String>['أقل سعر', 'اعلى سعر'];
  List<String> list4 = <String>['5 نجوم', '4 نجوم', '3 نجوم', 'نجمتين', 'نجمة'];
  List<List<String>>? lists;
  List<Data> data = [
    Data(
        icon: Icon(Icons.location_on),
        title: 'المدينه',
        subTitle: 'المدينة المنورة'),
  ];
  List<String>? dropdownValue = [
    'قاعات زفاف',
    'المدينة المنورة',
    'اعلى سعر',
    '5 نجوم'
  ];

  @override
  void initState() {
    super.initState();
    lists = [list1, list2, list3, list4];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  question[widget.index],
                  style: TextStyle(
                      fontFamily: "Portada ARA",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(43, 47, 78, 1)),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Icon(Icons.keyboard_arrow_down_outlined),
                    Expanded(
                      child: DropdownButton<String>(
                        value: dropdownValue?[widget.index],
                        elevation: 16,
                        // isExpanded: true,
                        style: const TextStyle(
                          color: Colors.black45,
                        ),
                        isExpanded: true,
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        // isExpanded: true,
                        iconSize: 1,

                        // padding: EdgeInsets.only(
                        //     left: screenWidth - 120),
                        iconDisabledColor: Colors.transparent,
                        iconEnabledColor: Colors.transparent,
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue?[widget.index] = value!;
                          });
                        },
                        items: lists?[widget.index]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                dropdownValue?[widget.index] == value
                                    ? Icon(Icons.keyboard_arrow_down_outlined)
                                    : Container(), // Icon
                                SizedBox(
                                    width:
                                        8), // Add space between icon and text
                                Text(
                                  value,
                                  textDirection: TextDirection.rtl,
                                ), // Text
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.category_rounded,
              size: 24, color: Color.fromRGBO(19, 169, 179, 1)),
        ],
      ),
    );
  }
}
