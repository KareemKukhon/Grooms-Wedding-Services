import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/loginSignup.dart';
import 'package:rafeed_provider/ServiceProviderApp/backendServices/servicesService.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customDropdown.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/customTextField.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/providerModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/models/userModel.dart';
import 'package:rafeed_provider/ServiceProviderApp/screen/bottomBarScreen/servicesScreen/myService.dart';

import '../../../component/bottomSheetCard.dart';
import '../bottomBar.dart';

class AddService extends StatefulWidget {
  bool isAgree = false;
  AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  List<String> cities = <String>['جدة', 'الرياض', 'المدينة المنورة', 'مكة'];
  List<String> services = <String>[
    'بدلات زفاف',
    'تصوير',
    'سيارات زفاف',
    'قاعات أفراح'
  ];
  List<String> properties = [];

  final TextEditingController textEditingController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _discrptionController = TextEditingController();
  TextEditingController _propertyController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  String? _selectedArea;

  String? _selectedField;
  File? _pickedImage;
  List<XFile> _pickedImages = [];
  bool _isTextFieldFull = false;
  Map<int, Widget> containers = {};

  Future<void> _pickListImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImages.add(pickedImage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ProviderModel? spUser = Provider.of<LoginSignup>(context).user;
    return Consumer<LoginSignup>(builder: (context, provider, x) {
      return Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              _buildHeader(),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < 4; i++)
                    GestureDetector(
                      onTap: _pickListImage,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        width: 72.w,
                        height: 72.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Color(0xFFE8E8E8)),
                        ),
                        child: _pickedImages.length > i
                            ? Image.file(
                                File(_pickedImages[i].path),
                                fit: BoxFit.cover,
                              )
                            : CircleAvatar(
                                radius: 15.r,
                                backgroundColor:
                                    Color.fromARGB(173, 175, 175, 175),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              _uploadImageSpace(),
              SizedBox(
                height: 15.h,
              ),
              CustomTextField(
                text: 'عنوان الخدمة',
                controller: _addressController,
                type: TextInputType.text,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                text: 'سعر الخدمة',
                controller: _priceController,
                type: TextInputType.number,
              ),
              CustomTextField(
                text: 'رابط يوتيوب (اختياري)',
                controller: urlController,
                type: TextInputType.url,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 140.h,
                padding: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFEAEAEA)),
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _discrptionController,
                    textInputAction: TextInputAction.next,
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
                height: 10.h,
              ),
              CustomDropdown(
                hint: 'اختيار المنطقة',
                items: cities,
                icon: Icons.location_on_outlined,
                selectedValue: _selectedArea,
                onChanged: (p0) {
                  setState(() {
                    _selectedArea = p0;
                  });
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomDropdown(
                hint: 'اختيار التخصص',
                items: provider.onCategories.map((cat) => cat.name).toList(),
                icon: Icons.favorite_border_rounded,
                selectedValue: _selectedField,
                onChanged: (p0) {
                  setState(() {
                    _selectedField = p0;
                  });
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "موافقة الية",
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14.sp,
                        fontFamily: "Portada ARA",
                        fontWeight: FontWeight.w700),
                  ),
                  _buildAgreeCheckbox(),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              _properties(),
              Container(
                margin: EdgeInsets.only(top: 15.h),
                width: double.infinity,
                child: ElevatedButton(
                  /// Expected Map : {
                  ///   "title":"service",
                  ///   "price":123.2,
                  ///   "description":"description",
                  ///   "category":"FILMING",
                  ///   "objectives":["CHEAP","CAMERA"]
                  ///   "cities":["City","City"],
                  /// }
                  onPressed: () async {
                    log(_selectedArea ?? 'emptyArea');
                    log(_selectedField ?? 'emptyField');

                    Map<String, dynamic> map = {
                      "title": _addressController.text,
                      "price": _priceController.text,
                      "description": _discrptionController.text,
                      "category": _selectedField,
                      "objectives": properties,
                      "autoAccept": widget.isAgree,
                      "cities": [_selectedArea]
                    };
                    if (urlController.text.isNotEmpty) {
                      map.addAll({"link": urlController.text});
                    }
                    final res = await Provider.of<ServicesService>(context,
                            listen: false)
                        .createService(map, _pickedImage!, spUser!.id!);
                    if (res.statusCode == 200) {
                      provider.addService(
                          jsonDecode(await res.stream.bytesToString()));
                    }
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => BottomSheetCard(
                        onClicked: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProviderBottomBar(),
                          ));
                        },
                        title: 'تم اضافة الخدمة بنجاح',
                        subTitle:
                            'شكرا لاستخدامكم تطبيق رفيد نتمني لك تجربة ممتعة ️',
                        image: 'images/approve.png',
                        btn1: 'الرئيسية',
                        btn2: '',
                        btn1Color: Color(0xFF13A9B3),
                        isBtn2: false,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'نشر',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: "Portada ARA",
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(19, 169, 179, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        // side: BorderSide(color: Colors.red)
                      ))),
                ),
              ),
              SizedBox(
                height: 40.h,
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _buildAgreeCheckbox() {
    return Checkbox(
      value: widget.isAgree,
      activeColor: Color(0xFF13A9B3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      side: BorderSide(color: Colors.grey[300]!, width: 3.w),
      onChanged: (value) {
        setState(() {
          widget.isAgree = !widget.isAgree;
        });
      },
    );
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

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 20.w,
        ),
        Text(
          'اضافة خدمة جديدة',
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

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _pickedImage = File(pickedImage.path);
      }
    });
  }

  Widget _uploadImageSpace() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Color(0xFF0B8683).withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DottedBorder(
          radius: Radius.circular(10),
          borderType: BorderType.RRect,
          dashPattern: [10, 6],
          strokeWidth: 1,
          color: Color(0xFF0B8683),
          child: _pickedImage != null
              ? Image.file(
                  _pickedImage!,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                )
              : Align(
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
                          fontSize: 18,
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

  Widget _properties() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFEAEAEA)),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              IconButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color?>(
                          Color(0xFF13A9B3).withOpacity(0.1))),
                  icon: Icon(
                    Icons.add,
                    color: Color(0xFF13A9B3),
                  ),
                  onPressed: () => _addProperty(_propertyController.text)),
              Expanded(
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _propertyController,
                    // cursorColor: kPrimaryColor,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    onSaved: (text) {},
                    decoration: InputDecoration(
                        hintText: "خصائص الخدمة", border: InputBorder.none)),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: containers.values.toList(),
          ),
        ),
      ],
    );
  }

  void _addProperty(String property) {
    setState(() {
      int index = containers.length;

      properties.add(property);
      containers[index] = Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFEAEAEA)),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  int propertyIndex = properties.length;
                  _propertyController.text = '';
                  log("deleted at index: $propertyIndex");
                  properties.remove(property);
                  log(properties.toString());
                  containers
                      .remove(index); // Remove the entry with the given index

                  log(containers.length.toString());
                });
              },
              icon: Icon(Icons.delete_forever_outlined, color: Colors.red),
            ),
            Row(
              children: [
                Text(
                  properties[index],
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF0B8683),
                    fontSize: 16.sp,
                    fontFamily: 'Portada ARA',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.check_circle,
                  color: Color(0xFF0B8683),
                ),
                SizedBox(
                  width: 5,
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
