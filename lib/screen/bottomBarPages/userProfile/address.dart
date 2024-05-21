import 'package:Rafeed/screen/bottomBarPages/userProfile/addAddress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class AddressData {
  String addressName;
  String address;
  AddressData({required this.addressName, required this.address});
}

class _AddressState extends State<Address> {
  List<AddressData> addresses = [
    AddressData(
        addressName: 'المنزل', address: 'الرياض, المملكة العربية السعودية'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: TextButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size?>(Size(380.w, 70.h)),
            backgroundColor:
                MaterialStateProperty.all<Color?>(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Color(0xFF13A9B3)))),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddAddress(),
            ));
          },
          child: Text(
            'اضافة عنوان جديد',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF13A9B3),
              fontSize: 14.sp,
              fontFamily: 'Portada ARA',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text('العناوين',
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
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFF13A9B3)),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.edit_road_rounded)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        addresses[0].addressName,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color.fromARGB(255, 62, 68, 112),
                          fontSize: 14.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        addresses[0].address,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF8E8E8E),
                          fontSize: 12.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
