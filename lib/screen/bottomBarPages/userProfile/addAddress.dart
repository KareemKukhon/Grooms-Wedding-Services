import 'package:Rafeed/component/customTextField.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

String? selectedValue;
final TextEditingController textEditingController = TextEditingController();
TextEditingController _addressController = TextEditingController();
TextEditingController _addressNameController = TextEditingController();
final List<String> items = [
  'A_Item1',
  'A_Item2',
  'A_Item3',
  'A_Item4',
  'B_Item1',
  'B_Item2',
  'B_Item3',
  'B_Item4',
];

class _AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 55),
        child: ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(181.w, 60.h)),
              backgroundColor: MaterialStateProperty.all<Color?>(
                  Color.fromRGBO(19, 169, 179, 1)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side:
                          BorderSide(color: Color.fromRGBO(19, 169, 179, 1)))),
            ),
            onPressed: () {},
            child: Text(
              'اضافة',
              style: TextStyle(
                  fontFamily: 'Portada ARA',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(252, 252, 252, 1)),
            )),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text('اضافة عنوان جديد',
                    textAlign: TextAlign.right,
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
              height: 35,
            ),
            Image(
              image: AssetImage('images/address.png'),
              width: 118.41.w,
              height: 118.41.h,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
                text: "اسم العنوان", controller: _addressNameController),
            SizedBox(
              height: 15,
            ),
            CustomTextField(text: "العنوان", controller: _addressController),
            SizedBox(height: 15),
            IntlPhoneField(
              disableLengthCheck: true,
              pickerDialogStyle: PickerDialogStyle(
                backgroundColor: Colors.white,
              ),
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintTextDirection: TextDirection.rtl,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xFFEAEAEA)),
                ),
                fillColor: Colors.amber,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xFFEAEAEA)),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              languageCode: 'ar',
              initialCountryCode: '+966',
              onChanged: (phone) {
                print(phone.completeNumber);
              },
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Color(0xFFEAEAEA)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  iconStyleData: IconStyleData(icon: Icon(Icons.location_city)),
                  alignment: Alignment.centerRight,
                  isExpanded: true,
                  hint: Text(
                    'المدينة',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: items
                      .map((item) => DropdownMenuItem(
                            alignment: Alignment.centerRight,
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                  ),
                  dropdownStyleData: const DropdownStyleData(
                    direction: DropdownDirection.right,
                    maxHeight: 200,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                  dropdownSearchData: DropdownSearchData(
                    searchController: textEditingController,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: Container(
                      height: 50,
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Search for an city...',
                          hintStyle: const TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return item.value.toString().contains(searchValue);
                    },
                  ),
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      textEditingController.clear();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
