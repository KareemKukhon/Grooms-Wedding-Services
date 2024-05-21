import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _mapController;
  List<Placemark>? placemarks;
  List<Marker> _markers = []; // Define a list to hold markers

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.947351, 35.227163),
    zoom: 2,
  );

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _addMarker(LatLng position) async {
    latitude = position.latitude;
    longitude = position.longitude;
    placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    log(placemarks![0].country!);
    setState(() {
      if (_markers.isNotEmpty) {
        _markers.removeAt(0);
        _markers.add(
          Marker(
            markerId: MarkerId(position.toString()),
            position: position,
            infoWindow: InfoWindow(
              title: 'New Marker',
              snippet: 'This is a new marker',
            ),
          ),
        );
      } else {
        _markers.add(
          Marker(
            markerId: MarkerId(position.toString()),
            position: position,
            infoWindow: InfoWindow(
              title: 'New Marker',
              snippet: 'This is a new marker',
            ),
          ),
        );
      }
    });
  }

  double longitude = 0;
  double latitude = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  suffixText: 'بحث',
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(202, 202, 202, 1),
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 235, 235, 235), width: 0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
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
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 830.h,
                width: screenWidth,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(31.947351, 35.227163), // Default position
                    zoom: 10,
                  ),
                  onTap: _addMarker, // Add onTap callback
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: Set<Marker>.of(_markers), // Set markers
                ),
              ),
              placemarks != null
                  ? Positioned(
                      bottom: 40,
                      right: 5,
                      left: 5,
                      child: Column(
                        children: [
                          LocationDetails(
                            title: 'تفاصيل الموقع',
                            longTitle:
                                '${placemarks![0].country!}, ${placemarks![0].locality!}, ${placemarks![0].name!}, ${placemarks![0].postalCode!}',
                            onShareLocation: () {},
                          ),
                          Container(
                            width: screenWidth - 30,
                            child: ElevatedButton(
                              onPressed: () {
                                String message =
                                    'Check out this location:\nhttps://maps.google.com/?q=$latitude,$longitude';

                                // Share the location using the share plugin
                                Share.share(message);
                              },
                              child: Text(
                                'مشاركة موقعي الحالي',
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                fixedSize: Size(double.infinity, 55.0),
                                backgroundColor:
                                    Color.fromRGBO(19, 169, 179, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}

class LocationDetails extends StatelessWidget {
  final String title;
  final String longTitle;
  final VoidCallback onShareLocation;

  const LocationDetails({
    required this.title,
    required this.longTitle,
    required this.onShareLocation,
  });

  static TextStyle titleStyle = TextStyle(
    color: Color(0xFF242B5C),
    fontSize: 18.sp,
    fontFamily: 'Portada ARA',
    fontWeight: FontWeight.w600,
  );

  static TextStyle longTitleStyle = TextStyle(
    color: Color(0xFF53577A),
    fontSize: 12.sp,
    fontFamily: 'Portada ARA',
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth - 10,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(title, style: titleStyle),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    longTitle,
                    style: longTitleStyle,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(width: 10.0),
                CircleAvatar(
                  backgroundColor: Color(0x1913A9B3),
                  child: Icon(Icons.location_on_outlined,
                      color: Color.fromRGBO(19, 169, 179, 1)),
                ),
              ],
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}
