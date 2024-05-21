import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/providerService.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customDropdown.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customTextField.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/map/splashScreen.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/phoneModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

import '../../../component/customRadio.dart';

class EditProviderProfile extends StatefulWidget {
  const EditProviderProfile({super.key});

  @override
  State<EditProviderProfile> createState() => _EditProviderProfileState();
}

class _EditProviderProfileState extends State<EditProviderProfile> {
  List<String> Gender = ['رجل', 'امراه'];
  int _value = 0;
  List<String> cities = <String>['جدة', 'الرياض', 'المدينة المنورة', 'مكة'];
  List<String> services = <String>[
    'بدلات زفاف',
    'تصوير',
    'سيارات زفاف',
    'قاعات أفراح'
  ];

  String? selectedValue;
  String countryCode = '+970';
  File? _selectedBackgroundImage;
  File? _selectedProfileImage;
  final TextEditingController textEditingController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String? _citySelectedValue;
  double? lat;
  double? lang;
  String? _fieldSelectedValue;
  TextEditingController _descriptionController = TextEditingController();
  ProviderModel? user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<LoginSignup>(context).user;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(right: 10, top: 30),
                    color: Color(0xFF13A9B3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        Color(0xFF0B8683).withOpacity(0.5))),
                            onPressed: _pickImageFromGallery,
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 95.h, right: 20, left: 20),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _uploadImageSpace(),
                              SizedBox(
                                width: 20.w,
                              ),
                              _uploadImageSpace(),
                              SizedBox(
                                width: 20.w,
                              ),
                              _uploadImageSpace()
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'تعديل بيانات الحساب',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF043E3D),
                              fontSize: 24.sp,
                              fontFamily: 'Portada ARA',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomTextField(
                            text: "اسم مقدم الخدمة",
                            controller: _nameController,
                            onChange: (p0) {
                              user!.username = _nameController.text;
                            },
                          ),
                          // TextFormField(
                          //   keyboardType: TextInputType.emailAddress,
                          //   textInputAction: TextInputAction.next,
                          //   // cursorColor: kPrimaryColor,
                          //   textDirection: TextDirection.rtl,
                          //   textAlign: TextAlign.right,
                          //   onSaved: (email) {},
                          //   decoration: InputDecoration(
                          //     contentPadding:
                          //         EdgeInsets.symmetric(vertical: 15),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(15),
                          //       borderSide: BorderSide(
                          //           color: Color.fromARGB(255, 179, 179, 179)),
                          //     ),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(15),
                          //       borderSide: BorderSide(
                          //           color: Color.fromRGBO(250, 250, 250, 0)),
                          //     ),
                          //     hintText: "اسم مقدم الخدمة",
                          //     suffixIcon: Icon(Icons.account_circle_outlined),
                          //   ),
                          //   // onChanged: (text) {
                          //   //   if (mounted)
                          //   //     setState(() {
                          //   //       email = text;
                          //   //     });
                          //   // },
                          // ),
                          SizedBox(
                            height: 15.h,
                          ),
                          IntlPhoneField(
                            disableLengthCheck: true,
                            controller: _phoneController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15),
                              labelText: 'Phone Number',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 179, 179, 179)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            languageCode: 'ar',
                            initialCountryCode: '+966',
                            onChanged: (phone) {
                              print(phone.completeNumber);
                              countryCode = phone.countryCode;
                              user!.phone = Phone(
                                  country: countryCode,
                                  number: _phoneController.text);
                            },
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomRadio(
                                filledColor: true,
                                textValue: 'رجل',
                                value: 2,
                                groupValue: _value,
                                onChange: (int? p0) {
                                  setState(() {
                                    _value = p0!;
                                  });
                                },
                              ),
                              SizedBox(
                                  width: 20.0), // Add spacing between elements
                              CustomRadio(
                                filledColor: true,
                                textValue: 'امرأه',
                                value: 1,
                                groupValue: _value,
                                onChange: (int? p0) {
                                  setState(() {
                                    _value = p0!;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomDropdown(
                            hint: 'اختيار المنطقة',
                            items: cities,
                            icon: Icons.location_on_outlined,
                            onChanged: (p0) {
                              setState(() {
                                _citySelectedValue = p0;
                                user!.city = _citySelectedValue.toString();
                              });
                            },
                            selectedValue: _citySelectedValue,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SplashScreen(),
                              ));
                            },
                            child: Container(
                              height: 55.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF13A9B3)),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'حدد موقع المحل على الخريطة',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF13A9B3),
                                      fontSize: 14.sp,
                                      fontFamily: 'Portada ARA',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7.w,
                                  ),
                                  Icon(
                                    Icons.location_searching_rounded,
                                    color: Color(0xFF13A9B3),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomDropdown(
                            hint: 'اختيار التخصص',
                            items: services,
                            icon: Icons.favorite_border_rounded,
                            onChanged: (p0) {
                              setState(() {
                                _fieldSelectedValue = p0;
                                user!.field = _fieldSelectedValue.toString();
                              });
                            },
                            selectedValue: _fieldSelectedValue,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            height: 140.h,
                            padding: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 179, 179, 179)),
                                borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                controller: _descriptionController,
                                // cursorColor: kPrimaryColor,
                                textDirection: TextDirection.rtl,
                                maxLines: null,
                                textAlign: TextAlign.right,
                                onSaved: (text) {},
                                decoration: InputDecoration(
                                    hintText: "ضيف وصف بسيط للخدمة",
                                    border: InputBorder.none)),
                          ),
                          _buttons()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 170.h,
              // left: 22.w,
              right: 20.w,
              child: Container(
                height: 145,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundColor: Color(0xFFD0D0D0),
                      child: Icon(
                        Icons.person,
                        size: 75,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFF13A9B3),
                          child: IconButton(
                              onPressed: () async {
                                final returnedImage = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                setState(() {
                                  _selectedProfileImage = returnedImage != null
                                      ? File(returnedImage.path)
                                      : null;
                                });
                              },
                              icon:
                                  Icon(Icons.camera_alt, color: Colors.white)),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedBackgroundImage =
          returnedImage != null ? File(returnedImage.path) : null;
    });
  }

  Widget _buttons() {
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: 30.h,
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                        EdgeInsets.symmetric(vertical: 15.h)),
                    backgroundColor:
                        MaterialStateProperty.all<Color?>(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(
                                color: Color.fromRGBO(176, 176, 176, 1)))),
                  ),
                  onPressed: () {},
                  child: Text(
                    'الغاء',
                    style: TextStyle(
                        fontFamily: 'Portada ARA',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(176, 176, 176, 1)),
                  )),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                        EdgeInsets.symmetric(vertical: 15)),
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        Color.fromRGBO(19, 169, 179, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(
                                color: Color.fromRGBO(19, 169, 179, 1)))),
                  ),
                  onPressed: () {
                    user!.gender = _value == 1 ? 'امراه' : 'رجل';
                    user!.latitude = latitude;
                    user!.longitude = longitude;
                    log(user.toString());

                    Provider.of<ProviderService>(context, listen: false)
                        .updateProvider(
                            providerModel: user!,
                            logoFile: _selectedBackgroundImage);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'حفظ',
                    style: TextStyle(
                        fontFamily: 'Portada ARA',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(252, 252, 252, 1)),
                  )),
            )
          ],
        ));
  }

  Widget _uploadImageSpace() {
    return Expanded(
      child: Container(
        height: 90.h,
        // width: 115.w,
        decoration: BoxDecoration(
            color: Color(0xFF0B8683).withOpacity(0.05),
            borderRadius: BorderRadius.circular(10)),
        child: DottedBorder(
          // borderType: BorderType.Oval,
          radius: Radius.circular(10),
          borderType: BorderType.RRect,
          dashPattern: [10, 6],
          strokeWidth: 1,
          color: Color(0xFF0B8683),
          child: Align(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_rounded,
                  color: Color(0xFF0B8683),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCityDropdown(String hint, List<String> items, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Color.fromARGB(255, 179, 179, 179)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          iconStyleData: IconStyleData(icon: Icon(icon)),
          alignment: Alignment.centerRight,
          isExpanded: true,
          hint: Text(
            hint,
            style: TextStyle(fontSize: 14, color: Theme.of(context).hintColor),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem(
                  alignment: Alignment.centerRight,
                  value: item,
                  child: Text(item, style: const TextStyle(fontSize: 14)),
                ),
              )
              .toList(),
          value: selectedValue,
          onChanged: _onCityDropdownChanged,
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
          ),
          dropdownStyleData: const DropdownStyleData(
            direction: DropdownDirection.right,
            maxHeight: 200,
          ),
          menuItemStyleData: const MenuItemStyleData(height: 40),
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: _buildSearchTextField(),
            searchMatchFn: _searchMatchFunction,
          ),
          onMenuStateChange: _onMenuStateChange,
        ),
      ),
    );
  }

  void _onCityDropdownChanged(String? value) {
    setState(() {
      selectedValue = value;
    });
  }

  Widget _buildSearchTextField() {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
      child: TextFormField(
        expands: true,
        maxLines: null,
        controller: textEditingController,
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          hintText: 'ابحث هنا',
          hintStyle: const TextStyle(fontSize: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  bool _searchMatchFunction(dynamic item, String searchValue) {
    return item.value.toString().contains(searchValue);
  }

  void _onMenuStateChange(bool isOpen) {
    if (!isOpen) {
      textEditingController.clear();
    }
  }
}
