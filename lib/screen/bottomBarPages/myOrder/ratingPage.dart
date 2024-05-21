import 'dart:developer';

import 'package:Rafeed/component/loadingScreen.dart';
import 'package:Rafeed/models/orderModel.dart';
import 'package:Rafeed/screen/bottomBarPages/bottomBar.dart';
import 'package:Rafeed/var/var.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/apiServices/servicesService.dart';
import 'package:Rafeed/component/map/splashScreen.dart';
import 'package:Rafeed/models/userModel.dart';

class RatingPage extends StatelessWidget {
  Order order;
  RatingPage({
    Key? key,
    required this.order,
  }) : super(key: key);

  double? rating;
  TextEditingController _feedbackController = TextEditingController();
  // UserModel? user;

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<LoginSignup>(context).user;
    rating = Provider.of<ServicesService>(context).rating;
    // return
    // FutureBuilder<List<Placemark>>(
    //   future:
    //       _fetchPlacemarks(), // Call a method to fetch placemarks asynchronously
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       // Return a loading indicator or placeholder widget while waiting for data
    //       return LoadingScreen();
    //     } else if (snapshot.hasError) {
    //       // Return an error widget if an error occurs during data fetching
    //       return Text('Error: ${snapshot.error}');
    //     } else {
    // Data has been successfully fetched, build the UI using the placemarks
    // List<Placemark>? placemarks = snapshot.data;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildHeader(context),
            SizedBox(height: 35.h),
            // _buildServiceProviderInfo(placemarks, context),
            SizedBox(height: 25.h),
            _buildServiceDetails(),
            SizedBox(height: 15.h),
            _buildRatingBar(context),
            SizedBox(height: 15.h),
            _buildFeedbackTextField(),
            SizedBox(height: 10.h),
            _buildActionButtons(user!, context),
          ],
        ),
      ),
    );
    //     }
    //   },
    // );
  }

  Future<List<Placemark>> _fetchPlacemarks() async {
    List<Placemark> placemarks = [];
    try {
      final List<Placemark> fetchedPlacemarks = await placemarkFromCoordinates(
        order.service.provider!.latitude ?? 0,
        order.service.provider!.longitude ?? 0,
      );
      placemarks = fetchedPlacemarks;
    } catch (e) {
      // Handle error if placemark fetching fails
      print('Error fetching placemarks: $e');
    }
    return placemarks;
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
        ),
        Text(
          'أضف تقييمك على الخدمة',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF053F3E),
            fontSize: 18.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceProviderInfo(
      List<Placemark>? placemarks, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              order.service.provider!.username,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF181818),
                fontSize: 10.sp,
                fontFamily: 'Portada ARA',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SplashScreen(),
                ));
              },
              child: Text(
                placemarks!.length > 0
                    ? '${placemarks![0].country!}, ${placemarks![0].locality!}, ${placemarks![0].name!}, ${placemarks![0].postalCode!}'
                    : "لا يوجد عنوان محدد",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF13A9B3),
                  fontSize: 8.sp,
                  fontFamily: 'Portada ARA',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 7.w),
        CircleAvatar(
          backgroundImage: AssetImage('images/user.png'),
        ),
      ],
    );
  }

  Widget _buildServiceDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 233.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                order.service.description,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Portada ARA',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(43, 47, 78, 1),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                order.service.price.toString() + ' ريال',
                style: TextStyle(
                  fontFamily: 'Portada ARA',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(19, 169, 179, 1),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          width: 95.w,
          height: 95.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(server + '/' + order.service.logo),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(BuildContext context) {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemSize: 40.w,
      unratedColor: Colors.grey.shade300,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
      itemBuilder: (context, _) {
        // log(message)
        return Icon(
          color: Colors.amber,
          rating! >= _ + 1 ? Icons.star : Icons.star_border_outlined,
        );
      },
      onRatingUpdate: (newRating) {
        Provider.of<ServicesService>(context, listen: false)
            .addRating(newRating);

        print(rating);
      },
    );
  }

  Widget _buildFeedbackTextField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFE4E4E4),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        maxLines: null,
        controller: _feedbackController,
        decoration: InputDecoration(
          hintText: 'Enter text here',
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 143, 144, 153),
            fontSize: 12.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(UserModel user, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextButton(
            style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(Size(double.infinity, 55.h)),
              backgroundColor:
                  MaterialStateProperty.all<Color?>(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Color.fromRGBO(176, 176, 176, 1)),
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'الغاء',
              style: TextStyle(
                fontFamily: 'Portada ARA',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(176, 176, 176, 1),
              ),
            ),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all(Size(double.infinity, 55.h)),
              backgroundColor: MaterialStateProperty.all<Color?>(
                  Color.fromRGBO(19, 169, 179, 1)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Color.fromRGBO(19, 169, 179, 1)),
                ),
              ),
            ),
            onPressed: () {
              Map<String, dynamic> map = {
                'customer_id': user!.id,
                'service_id': order.service.id,
                'review': _feedbackController.text,
                'value': rating
              };
              Provider.of<ServicesService>(context, listen: false)
                  .feedBackService(map, order.id!);
              _feedbackController.clear();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BottomBar(),
              ));
            },
            child: Text(
              'اضافة',
              style: TextStyle(
                fontFamily: 'Portada ARA',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(252, 252, 252, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
