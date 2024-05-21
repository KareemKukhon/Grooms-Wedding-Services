import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Rafeed/apiServices/servicesService.dart';
import 'package:Rafeed/models/categoryModel.dart';
import 'package:Rafeed/models/providerModel.dart';
import 'package:Rafeed/models/ratingModel.dart';
import 'package:Rafeed/models/serviceModel.dart';
import 'package:Rafeed/screen/serviceProvider/viewService.dart';
import 'package:Rafeed/var/var.dart';
import 'package:provider/provider.dart';

class ProviderServicesCard extends StatelessWidget {
  List<ServiceModel> services;
  ProviderModel provider;
  ProviderServicesCard({
    Key? key,
    required this.services,
    required this.provider,
  }) : super(key: key);

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    isClicked = Provider.of<LoginSignup>(context).isClicked;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 17.h),
      child: Column(
        children: [
          ...List.generate(
            services!.length,
            (index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ViewService(
                      serviceModel: services![index],
                      provider: provider,
                    ),
                  ),
                );
              },
              child: _buildServiceCard(services![index], context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(ServiceModel service, BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildServiceImage(service, context),
          SizedBox(height: 10.h),
          _buildServiceDetails(service),
        ],
      ),
    );
  }

  Widget _buildServiceImage(ServiceModel service, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
      child: Container(
        alignment: Alignment.topLeft,
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(server + '/' + service.logo),
            fit: BoxFit.cover,
          ),
        ),
        child: _buildFavoriteButton(service, context),
      ),
    );
  }

  Widget _buildFavoriteButton(ServiceModel service, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h, left: 15.w),
      child: CircleAvatar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.43),
        child: InkWell(
          onTap: () {
            Provider.of<LoginSignup>(context, listen: false)
                .addFavorite(service.id ?? "", service);
          },
          child: !isClicked
              ? Icon(
                  Icons.favorite_border,
                  color: Color.fromRGBO(96, 125, 138, 1),
                )
              : Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
        ),
      ),
    );
  }

  Widget _buildServiceDetails(ServiceModel service) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildServiceTitleAndPrice(service),
          SizedBox(height: 10.h),
          _buildServiceDescription(service),
          SizedBox(height: 10.h),
          _buildRatingAndButton(service),
        ],
      ),
    );
  }

  Widget _buildServiceTitleAndPrice(ServiceModel service) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${service.price} ريال',
          style: TextStyle(
            color: Color(0xFF13A9B3),
            fontSize: 18.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          service.title,
          style: TextStyle(
            color: Color(0xFF2B2F4E),
            fontSize: 20.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceDescription(ServiceModel service) {
    return Text(
      service.description,
      style: TextStyle(
        color: Color(0xFF5C5C5C),
        fontSize: 10.sp,
        fontFamily: 'Portada ARA',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildRatingAndButton(ServiceModel service) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.star,
              color: Color.fromRGBO(255, 187, 13, 1),
            ),
            Text(
              calculateAverage(service.ratings ?? []).toString(),
              style: TextStyle(
                fontFamily: 'Portada ARA',
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(176, 176, 176, 1),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'عرض الخدمة',
            style: TextStyle(
              color: Color(0xFFB0B0B0),
              fontSize: 14.sp,
              fontFamily: 'Portada ARA',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  double calculateAverage(List<RatingModel> ratings) {
    if (ratings.isEmpty) return 0.0;

    double sum = 0.0;
    int count = 0;

    for (var rating in ratings) {
      if (rating.value != null) {
        sum += rating.value!;
        count++;
      }
    }

    if (count == 0) return 0.0;

    return sum / count;
  }
}
