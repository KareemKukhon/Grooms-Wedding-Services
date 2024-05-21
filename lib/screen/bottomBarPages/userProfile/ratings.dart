import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/models/providerModel.dart';
import 'package:Rafeed/models/ratingModel.dart';
import 'package:Rafeed/models/serviceModel.dart';
import 'package:Rafeed/models/userModel.dart';
import 'package:Rafeed/var/var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Ratings extends StatelessWidget {
  double rating = 3;
  Ratings({super.key});

  List<RatingModel> extractRatings(ServiceModel service) {
    List<RatingModel> allRatings = [];

    if (service.ratings != null) {
      for (RatingModel rate in service.ratings ?? [])
        if (rate.user!.id == currentUser!.id) allRatings.add(rate);
    }

    return allRatings;
  }

  List<ProviderModel>? provideres;
  UserModel? currentUser;
  List<RatingModel> ratings = [];
  List<ServiceModel> services = [];

  @override
  Widget build(BuildContext context) {
    currentUser = Provider.of<LoginSignup>(context).user!;
    provideres = Provider.of<LoginSignup>(context).providerList!;
    for (ProviderModel provider in provideres ?? [])
      services.addAll(provider.services ?? []);
    List<ServiceModel> filteredServices = services
        .where((service) =>
            service.ratings?.isNotEmpty ==
                    true && // Ensure ratings list exists and is not empty
                service.ratings!.any((rating) =>
                    rating.user?.username == currentUser!.username) ??
            false)
        .toList();

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text('التقييمات',
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
                                    color:
                                        Color.fromARGB(255, 225, 225, 225))))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_forward))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            for (ServiceModel service in filteredServices)
              for (RatingModel rate in service.ratings ?? [])
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(12.dg),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 224, 224, 224)),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'الخدمة',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF086C6A),
                          fontSize: 10.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 233.0.w, // Adjust width as needed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min, // Allow shrinking
                              children: [
                                Wrap(
                                    alignment: WrapAlignment.end,
                                    // flex: 1,
                                    // fit: FlexFit.loose,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.right,
                                        service.title,
                                        style: TextStyle(
                                            fontFamily: 'Portada ARA',
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w800,
                                            color:
                                                Color.fromRGBO(43, 47, 78, 1)),
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ]),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${service.price} ريال",
                                  style: TextStyle(
                                      fontFamily: 'Portada ARA',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(19, 169, 179, 1)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 95.w,
                            height: 95.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        server + "/" + service.logo),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(15)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'التقييم',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF086C6A),
                          fontSize: 10.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        rate.review ?? "",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF7A7A7A),
                          fontSize: 12.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          for (int i = 0; i < 5; i++)
                            if (i < rate.value!.toInt())
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              )
                            else
                              Icon(
                                Icons.star_border,
                                color: const Color.fromARGB(255, 211, 211, 211),
                              )
                        ],
                      )
                    ],
                  ),
                )
          ],
        ),
      ),
    );
  }
}
