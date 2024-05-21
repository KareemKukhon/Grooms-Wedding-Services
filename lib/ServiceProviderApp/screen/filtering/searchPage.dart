import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/SocketService.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/filtering/sort.dart';

import 'filtering.dart';

class Data {
  String? title;
  String? subTitle;
  Icon? icon;
  Data({
    this.title,
    this.subTitle,
    this.icon,
  });
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _sliding = 0;
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
      subTitle: 'المدينة المنورة',
    ),
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color.fromRGBO(229, 231, 235, 1),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.tune,
                        color: Color.fromRGBO(19, 169, 179, 1),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          SocketService.socketService.search(value);
                        },
                        decoration: InputDecoration(
                          suffixText: 'بحث',
                          suffixIcon: Icon(
                            Icons.search,
                            color: Color.fromRGBO(202, 202, 202, 1),
                          ),
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 228, 228, 228),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _sliding = 1;
                            });
                          },
                          child: Text(
                            'ضبط الترتيب',
                            style: TextStyle(
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w800,
                              fontSize: 14.sp,
                              color: _sliding == 1
                                  ? Color.fromRGBO(19, 169, 179, 1)
                                  : Color.fromRGBO(176, 176, 176, 1),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _sliding = 0;
                            });
                          },
                          child: Text(
                            'فلتر البحث',
                            style: TextStyle(
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w800,
                              fontSize: 14.sp,
                              color: _sliding == 0
                                  ? Color.fromRGBO(19, 169, 179, 1)
                                  : Color.fromRGBO(176, 176, 176, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    if (_sliding == 0)
                      for (int i = 0; i < 4; i++) Filtering(index: i)
                    else
                      Sort(),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: BorderSide(
                                              color: Color.fromRGBO(
                                                  237, 237, 237, 1)))),
                                  fixedSize: MaterialStateProperty.all<Size?>(
                                      Size(125, 70.h)),
                                  side: MaterialStateProperty.all<BorderSide?>(
                                      BorderSide(color: Color.fromRGBO(235, 235, 235, 1)))),
                              onPressed: () {},
                              child: Text(
                                'اعادة ضبط',
                                style: TextStyle(
                                    fontFamily: 'Portada ARA',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                    color: Color.fromRGBO(176, 176, 176, 1)),
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(181.w, 70.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                  color: Color.fromRGBO(237, 237, 237, 1),
                                ),
                              ),
                              backgroundColor:
                                  const Color.fromRGBO(19, 169, 179, 1),
                            ),
                            child: Text(
                              'تطبيق',
                              style: TextStyle(
                                fontFamily: 'Portada ARA',
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
