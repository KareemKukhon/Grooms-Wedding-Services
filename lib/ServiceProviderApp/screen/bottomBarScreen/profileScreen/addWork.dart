import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/providerService.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customDropdown.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customTextField.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';

class AddWork extends StatefulWidget {
  const AddWork({super.key});

  @override
  State<AddWork> createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  List<String> cities = <String>['جدة', 'الرياض', 'المدينة المنورة', 'مكة'];
  List<String> services = <String>[
    'بدلات زفاف',
    'تصوير',
    'سيارات زفاف',
    'قاعات أفراح'
  ];

  String? selectedValue;
  File? _selectedImage;
  final TextEditingController textEditingController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  String? _fieldSelectedValue;
  bool _isTextFieldFull = false;
  Map<int, Widget> containers = {};
  @override
  Widget build(BuildContext context) {
    ProviderModel providerModel = Provider.of<LoginSignup>(context).user!;
    return Consumer<LoginSignup>(builder: (context, provider, x) {
      return Scaffold(
        bottomNavigationBar: Container(
            margin: EdgeInsets.only(bottom: 30.h, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                            EdgeInsets.symmetric(vertical: 15.h)),
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            Colors.transparent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(
                                        color:
                                            Color.fromRGBO(176, 176, 176, 1)))),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(
                                        color:
                                            Color.fromRGBO(19, 169, 179, 1)))),
                      ),
                      onPressed: () async {
                        Map<String, dynamic> map = {
                          'provider_id': providerModel.id,
                          'url': _urlController.text,
                          'location': _addressController.text,
                          'category': _fieldSelectedValue,
                          'createdAt': DateTime.now().toString()
                        };
                        log(map.toString());
                        final res = await Provider.of<ProviderService>(context,
                                listen: false)
                            .addWork(_selectedImage, map);
                        if (res != null) {
                          if (res.statusCode == 200) {
                            Provider.of<LoginSignup>(context, listen: false)
                                .addToUser(jsonDecode(res.body));
                            Navigator.of(context).pop();
                          }
                        }
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
            )),
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(
                height: 20.h,
              ),
              _buildHeader(),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      width: 72.w,
                      height: 72.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Color(0xFFE8E8E8))),
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Color.fromARGB(173, 175, 175, 175),
                        child: Icon(
                          Icons.camera_alt,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              _uploadImageSpace(),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                text: 'العنوان',
                controller: _addressController,
                type: TextInputType.text,
              ),
              CustomTextField(
                text: 'رابط فيديو يوتيوب',
                controller: _urlController,
                type: TextInputType.text,
              ),
              SizedBox(
                height: 10,
              ),
              CustomDropdown(
                hint: 'اختيار التخصص',
                items: provider.onCategories.map((cat) => cat.name).toList(),
                icon: Icons.favorite_border_rounded,
                onChanged: (p0) {
                  setState(() {
                    _fieldSelectedValue = p0;
                  });
                },
                selectedValue: _fieldSelectedValue,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 140.h,
                padding: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFEAEAEA)),
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
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Text(
          "أضف اعمالك السابقة",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF053F3E),
            fontSize: 18.sp,
            fontFamily: 'Portada ARA',
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }

  Widget _uploadImageSpace() {
    return GestureDetector(
      onTap: () => _pickImageFromGallery(),
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
            image: _selectedImage != null
                ? DecorationImage(
                    image: FileImage(_selectedImage!), fit: BoxFit.cover)
                : null,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xFF13A9B3))),
        child: _selectedImage != null
            ? Container()
            : DottedBorder(
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
                      Text(
                        'اضافة الصوره الاساسية ( الواجهة )',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF0B8683),
                          fontSize: 18.sp,
                          fontFamily: 'Portada ARA',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = returnedImage != null ? File(returnedImage.path) : null;
    });
  }
}
