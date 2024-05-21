import 'package:Rafeed/component/providerCard.dart';
import 'package:Rafeed/models/serviceModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/serviceCard.dart';
import 'package:Rafeed/models/providerModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:Rafeed/screen/filtering/searchPage.dart';

import '../../../models/categoryModel.dart';

class ServiceScreen extends StatelessWidget {
  Category category;
  ServiceScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<LoginSignup>(context).user!;
    List<ProviderModel> provideres =
        Provider.of<LoginSignup>(context).providerList ?? [];
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        category.name ?? "",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      // Text(
                      //   '40 مقدم خدمة',
                      //   textAlign: TextAlign.right,
                      //   style: TextStyle(
                      //     color: Color(0xFFA8A8A8),
                      //     fontSize: 10.sp,
                      //     fontFamily: 'Portada ARA',
                      //     fontWeight: FontWeight.w400,
                      //     height: 1,
                      //   ),
                      // ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_forward),
                  )
                ],
              ),
              SizedBox(height: 15.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                    color: Color.fromRGBO(229, 231, 235, 1),
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.tune,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchPage(),
                          ));
                        },
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            suffixText: 'بحث',
                            suffixIcon: Icon(
                              Icons.search,
                              color: Color.fromRGBO(202, 202, 202, 1),
                            ),
                            // hintText: 'بحث',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              // for (ProviderModel provider in provideres ?? [])
              ProviderCard(
                // services:
                //     getServicesByCategory(provider, category.name ?? ""),
                provider:
                    getServicesByCategory(provideres, category.name ?? ""),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ProviderModel> getServicesByCategory(
      List<ProviderModel> providers, String categoryName) {
    List<ProviderModel> filteredProvider = [];
    if (providers.isNotEmpty) {
      filteredProvider.addAll(providers.where((provider) {
        return provider.services!
            .any((service) => service.category == categoryName);
      }));
    }
    return filteredProvider;
  }
}
