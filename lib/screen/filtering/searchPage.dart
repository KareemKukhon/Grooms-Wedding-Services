import 'dart:developer';

import 'package:Rafeed/apiServices/SocketService.dart';
import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/serviceCard.dart';
import 'package:Rafeed/models/categoryModel.dart';
import 'package:Rafeed/models/serviceModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Rafeed/screen/filtering/filtering.dart';
import 'package:Rafeed/screen/filtering/sort.dart';
import 'package:provider/provider.dart';

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

  List<List<String>>? lists;
  List<Data> data = [
    Data(
      icon: Icon(Icons.location_on),
      title: 'المدينه',
      subTitle: 'المدينة المنورة',
    ),
  ];
  String? selectedCategory;
  String? selectedCity;
  String? selectedRating;
  List<String>? dropdownValue = [
    'قاعات زفاف',
    'المدينة المنورة',
    'اعلى سعر',
    '5 نجوم'
  ];
  List<String> cat = [];

  @override
  void initState() {
    super.initState();
  }

  List<ServiceModel> service = [];
  bool _hasPopulatedCategories = false;

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<LoginSignup>(context).user!;
    List<ServiceModel> services = Provider.of<LoginSignup>(context).services;
    if (!_hasPopulatedCategories) {
      // Populate categories only once

      for (Category category in user.categories ?? []) {
        cat.add(category.name!);
      }
      _hasPopulatedCategories = true; // Set flag to prevent further execution
    }
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
        ),
        padding: EdgeInsets.only(top: 40.h),
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
                          if (value != "") {
                            SocketService.socketService.search(value);

                            SocketService.socketService.onSearchResults =
                                (List services) {
                              service = services
                                  .map((map) => ServiceModel.fromMap(map))
                                  .toList();
                              print(
                                  '-------------------------------------------------------------------');
                              log(service.toString());
                              setState(() {});
                            };
                          } else {
                            service.clear();
                            setState(() {});
                          }
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
              if (service.length > 0)
                Container(
                  // Add constraints to the container
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context)
                        .size
                        .height, // Set maximum height
                  ),
                  child: ListView.builder(
                    itemCount: service.length,
                    itemBuilder: (context, index) {
                      log("message");
                      return ServiceCard(
                        provider: service[index].provider!,
                        service: service[index],
                      );
                    },
                  ),
                )
              else
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
                      if (_sliding == 0) ...{
                        Filtering(
                          hint: cat[0],
                          dropdownValue: selectedCategory,
                          icon: Icons.dashboard,
                          list: cat,
                          onChange: (p0) {
                            setState(() {
                              selectedCategory = p0;
                            });
                          },
                          question: 'ما الذي تبحث عنه؟',
                        ),
                        Filtering(
                          hint: 'جدة',
                          dropdownValue: selectedCity,
                          icon: Icons.location_on,
                          list: ['جدة', 'الرياض', 'المدينة المنورة', 'مكة'],
                          onChange: (p0) {
                            setState(() {
                              selectedCity = p0;
                            });
                          },
                          question: 'المدينة',
                        ),
                        Filtering(
                          hint: 'الكل ',
                          list: [
                            'الكل ',
                            '5 نجوم',
                            '4 نجوم',
                            '3 نجوم',
                            'نجمتين',
                            'نجمة'
                          ],
                          icon: Icons.star_rate_rounded,
                          onChange: (p0) {
                            setState(() {
                              selectedRating = p0;
                            });
                          },
                          question: 'التقييم',
                          dropdownValue: selectedRating,
                        )
                      } else
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
                              onPressed: () {
                                if (selectedCategory != null &&
                                    selectedCity != null) {
                                  log(services.length.toString());
                                  print(
                                      '===================================================');
                                  service = services
                                      .where((element) =>
                                          element.category == selectedCategory)
                                      .toList();
                                  log(service.toString());
                                  log(selectedCategory.toString() +
                                      " " +
                                      selectedCity.toString());
                                }
                                setState(() {});

//                                 List<ServiceModel> filteredServices = ServiceModel.where((service) => service.category == "Cleaning").toList();

// if (filteredServices.any((service) => service.price < 50)) {
//   print("There are services in the 'Cleaning' category with price less than 50");
// }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(181.w, 70.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                    color: Color.fromRGBO(237, 237, 237, 1),
                                  ),
                                ),
                                backgroundColor:
                                    Color.fromRGBO(19, 169, 179, 1),
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
