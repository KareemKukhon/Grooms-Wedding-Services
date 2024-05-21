import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';

import 'package:rafeed_provider/ServiceProviderApp/backendServices/servicesService.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/serviceModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/bottomBarScreen/servicesScreen/editService.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/bottomBarScreen/servicesScreen/viewService.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

import 'bottomSheetCard.dart';

class ServiceCard extends StatelessWidget {
  ProviderModel providerModel;
  ServiceCard({
    Key? key,
    required this.providerModel,
  }) : super(key: key);
  double calculateServiceAverage(Service service) {
    if (service.ratings!.isEmpty) return 0.0;

    double sum = 0.0;
    int count = 0;

    for (var rating in service.ratings!) {
      sum += rating.value!;
      count++;
    }

    return count > 0 ? sum / count : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginSignup>(
      builder: (context,provider,x) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 17.h),
          child: Column(
            children: List.generate(
              provider.filteredServices.length,
              (index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ViewService(
                        service: provider.filteredServices[index],
                        providerModel: providerModel,
                      ),
                    ),
                  );
                },
                child: _buildServiceCard(context, provider.filteredServices[index]),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _buildServiceCard(BuildContext context, Service service) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildServiceImage(context, service),
          SizedBox(height: 10.h),
          _buildServiceDetails(service),
        ],
      ),
    );
  }

  Widget _buildServiceImage(BuildContext context, Service service) {
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
            image: NetworkImage(server + service.logo),
            fit: BoxFit.cover,
          ),
        ),
        child: _buildFavoriteButton(context, service),
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context, Service service) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 15.h, right: 15.w),
      child: CircleAvatar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.43),
        child: PopupMenuButton<String>(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          itemBuilder: (BuildContext context) => [
            'تعديل الخدمة',
            'ايقاف الخدمة مؤقتا',
            'حذف الخدمة',
          ].map((String choice) {
            Icon iconData;
            Text text;
            switch (choice) {
              case 'تعديل الخدمة':
                text = Text(
                  'تعديل الخدمة',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 16,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                  ),
                );
                iconData = Icon(
                  Icons.edit,
                  color: Color(0xFF7A7A7A),
                );
                break;
              case 'ايقاف الخدمة مؤقتا':
                text = Text(
                  service.status == 'ACTIVE'
                      ? 'ايقاف الخدمة مؤقتا'
                      : 'تفعيل الخدمة',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: service.status == 'ACTIVE'
                        ? Color(0xFFFF981F)
                        : Color(0xFF246BFD),
                    fontSize: 16,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                  ),
                );
                iconData = Icon(
                  Icons.stop_circle_outlined,
                  color: service.status == 'ACTIVE'
                      ? Color(0xFFFF981F)
                      : Color(0xFF246BFD),
                );
                break;
              case 'حذف الخدمة':
                text = Text(
                  'حذف الخدمة',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFFF75555),
                    fontSize: 16,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                  ),
                );
                iconData = Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFF75555),
                );
                break;
              default:
                text = Text('');
                iconData = Icon(Icons.more_horiz_outlined);
                break;
            }
            return PopupMenuItem<String>(
              value: choice,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Adjust spacing between icon and text
                  text,
                  SizedBox(width: 8.w),
                  iconData,
                ],
              ),
            );
          }).toList(),
          onSelected: (String choice) {
            // Perform action based on choice
            switch (choice) {
              case 'تعديل الخدمة':
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditService(service: service),
                ));
                break;
              case 'ايقاف الخدمة مؤقتا':
                service.status == 'ACTIVE'
                    ? Provider.of<ServicesService>(context, listen: false)
                        .deactivateService(service.id)
                    : Provider.of<ServicesService>(context, listen: false)
                        .activateService(service.id);
                break;
              case 'حذف الخدمة':
                Provider.of<ServicesService>(context, listen: false)
                    .deleteService(service.id);
                showModalBottomSheet(
                  context: context,
                  builder: (context) => BottomSheetCard(
                    onClicked: () {},
                    image: 'images/redWarning.png',
                    title: 'متأكد من حذف خدمتك',
                    subTitle:
                        'يتم الحذف بشكل نهائي ولا يمكن استرجاعها ولكن يمكنك الاضافة ',
                    btn1: 'حذف الخدمة',
                    btn2: 'البقاء',
                    btn1Color: Color(0xFFF75555),
                  ),
                );
                break;
              default:
                break;
            }
          },
          child: Icon(
            Icons.more_horiz_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget popupmenu(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => [
        'Edit Service',
        'Stop Service',
        'Delete Service',
      ].map((String choice) {
        return PopupMenuItem<String>(
          value: choice,
          child: Text(choice),
        );
      }).toList(),
      onSelected: (String choice) {
        // Perform action based on choice
        switch (choice) {
          case 'Edit Service':
            // Add your edit service action here
            break;
          case 'Stop Service':
            // Add your stop service action here
            break;
          case 'Delete Service':
            // Add your delete service action here
            break;
          default:
            break;
        }
      },
      child: Icon(
        Icons.more_horiz_outlined,
        color: Colors.white,
      ),
    );
  }

  Widget _buildServiceDetails(Service service) {
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

  Widget _buildServiceTitleAndPrice(Service service) {
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

  Widget _buildServiceDescription(Service service) {
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

  Widget _buildRatingAndButton(Service service) {
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
              calculateServiceAverage(service).toString(),
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
}
