import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/map/splashScreen.dart';
import 'package:Rafeed/models/favorateModel.dart';
import 'package:Rafeed/models/serviceModel.dart';
import 'package:Rafeed/var/var.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key});

  @override
  Widget build(BuildContext context) {
    List<FavoriteModel> favorites =
        Provider.of<LoginSignup>(context).user!.favorites ?? [];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  ),
                  Text(
                    "المفضلة",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontFamily: 'Portada ARA',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(
                favorites.length,
                (index) => GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: Color.fromARGB(255, 248, 245, 245),
                    margin: EdgeInsets.all(10.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Image.network(
                            server + "/" + favorites[index].service!.logo ?? "",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 120.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Color.fromRGBO(
                                                  255, 187, 13, 1),
                                            ),
                                            Text(
                                              calculateServiceAverage(
                                                      favorites[index].service!)
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Portada ARA',
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromRGBO(
                                                    176, 176, 176, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          favorites[index].service!.title,
                                          style: TextStyle(
                                            fontFamily: 'Portada ARA',
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Color.fromRGBO(43, 47, 78, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      favorites[index].service!.description,
                                      style: TextStyle(
                                        fontFamily: 'Portada ARA',
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(176, 176, 176, 1),
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  SplashScreen(),
                                            ));
                                          },
                                          child: Text(
                                            '29 شارع الشنانة,أمام مطعم روعة المشاوي العراقية,السيح',
                                            style: TextStyle(
                                              fontFamily: 'Portada ARA',
                                              fontSize: 8.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  19, 169, 179, 1),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.location_on_outlined,
                                          color:
                                              Color.fromRGBO(19, 169, 179, 1),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.h)
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w),
                              CircleAvatar(
                                radius: 24.r,
                                backgroundColor:
                                    Color.fromRGBO(12, 135, 132, 1),
                                child: Icon(
                                  Icons.person_2_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateServiceAverage(ServiceModel service) {
    if (service.ratings!.isEmpty) return 0.0;

    double sum = 0.0;
    int count = 0;

    for (var rating in service.ratings!) {
      sum += rating.value!;
      count++;
    }

    return count > 0 ? sum / count : 0.0;
  }
}
