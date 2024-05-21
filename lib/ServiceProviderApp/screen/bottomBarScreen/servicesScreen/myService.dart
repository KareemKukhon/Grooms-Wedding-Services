import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

import '../../../component/serviceCard.dart';
import 'addService.dart';

class MyService extends StatefulWidget {
  const MyService({super.key});

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  Widget _buildSearchField(Function  onChanged) {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15),
      child: TextField(
        onChanged: (text){
          onChanged(text);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          suffixText: 'بحث',
          suffixIcon: Icon(Icons.search),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
            borderRadius: BorderRadius.circular(20.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(204, 204, 204, 1)),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProviderModel? provider = Provider.of<LoginSignup>(context).user!;
    log(provider.services!.length.toString());
    return Consumer<LoginSignup>(
      builder: (context,providerr,x) {
        return RefreshIndicator(
          
          onRefresh: () async {
            provider.password = secretPassword;
            await Provider.of<LoginSignup>(context, listen: false)
                .signIn(provider.toMap());
            await Future.delayed(Duration(seconds: 1));
          },
          child: Container(
            margin: EdgeInsets.only(top: 20, right: 15, left: 15),
            child: ListView(
              children: [
                _buildSearchField(providerr.searchServices),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                      EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color?>(Color(0xFF13A9B3)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(color: Color(0xFF13A9B3)),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddService(),
                    ));
                  },
                  child: Text(
                    'اضافة خدمة جديدة',
                    style: TextStyle(
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                ServiceCard(
                  providerModel: provider,
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
