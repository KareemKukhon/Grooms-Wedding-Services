import 'package:Rafeed/var/var.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceBookingInformation extends StatefulWidget {
  TextEditingController neighborhood;
  // String? dropdownValue = 'صباحا';
  // String? selectedCity;
  // DateTime dateTime;
  ServiceBookingInformation({
    Key? key,
    required this.neighborhood,
    // this.dropdownValue,
    // this.selectedCity,
    // required this.dateTime,
  }) : super(key: key);

  @override
  _ServiceBookingInformationState createState() =>
      _ServiceBookingInformationState();
}

class _ServiceBookingInformationState extends State<ServiceBookingInformation> {
  List<String> items = <String>['جدة', 'الرياض', 'المدينة المنورة', 'مكة'];

  List<DateTime?> _rangeDatePickerWithActionButtonsWithValue = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 5)),
  ];

  // String dropdownValue = 'صباحا';
  // String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildHeader(),
        SizedBox(height: 15.h),
        _buildDatePicker(),
        SizedBox(height: 12.h),
        _buildTimeDropdown(),
        SizedBox(height: 12.h),
        _buildCityDropdown(),
        SizedBox(height: 12.h),
        _buildLocationTextField(),
      ],
    );
  }

  Widget _buildHeader() {
    return Text(
      'بيانات حجز الخدمة',
      textAlign: TextAlign.right,
      style: TextStyle(
        color: Color(0xFF086C6A),
        fontSize: 20.sp,
        fontFamily: 'Portada ARA',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color.fromARGB(255, 179, 179, 179)),
      ),
      child: TextFormField(
        textAlign: TextAlign.right,
        readOnly: true,
        controller: TextEditingController(
          text: ('${dateTime!.year}-${dateTime!.month}-${dateTime!.day}'),
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          suffixIcon: IconButton(
            onPressed: _showDatePicker,
            icon: Icon(Icons.calendar_today),
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.teal,
            colorScheme: ColorScheme.light(
              primary: Colors.white, // Header background color
              onPrimary: Colors.teal, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    // Check if a date was actually selected
    if (selectedDate != null) {
      // Store the selected date in your widget's state
      setState(() {
        // Update the state with the selected date
        // You can use selectedDate directly, or format it as needed
        // For example, you can convert it to a formatted string
        // and store it in a variable
        dateTime =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        // Now you can use formattedDate or selectedDate as needed
      });
    }
  }

  Widget _buildTimeDropdown() {
    return Container(
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color.fromARGB(255, 179, 179, 179)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                isExpanded: true,
                underline: Container(height: 2, color: Colors.transparent),
                iconSize: 1,
                iconDisabledColor: Colors.transparent,
                iconEnabledColor: Colors.transparent,
                onChanged: _onDropdownChanged,
                items: ['صباحا', 'مساءا'].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      alignment: Alignment.centerRight,
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(value, textDirection: TextDirection.rtl),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            _buildTimeSuffixIcon(),
          ],
        ),
      ),
    );
  }

  void _onDropdownChanged(String? value) {
    setState(() {
      dropdownValue = value!;
    });
  }

  Widget _buildTimeSuffixIcon() {
    return dropdownValue == 'مساءا'
        ? Icon(Icons.nights_stay_outlined)
        : Icon(Icons.wb_sunny_outlined);
  }

  Widget _buildCityDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color.fromARGB(255, 179, 179, 179)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          iconStyleData: IconStyleData(icon: Icon(Icons.location_on_outlined)),
          alignment: Alignment.centerRight,
          isExpanded: true,
          hint: Text(
            'المدينة',
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
          value: selectedCity,
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
      selectedCity = value;
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
          hintText: 'Search for a city...',
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

  Widget _buildLocationTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color.fromARGB(255, 179, 179, 179)),
      ),
      child: TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        controller: widget.neighborhood,
        onSaved: _saveEmail,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          hintText: "الحي - القاعة",
          suffixIcon: Padding(
            padding: EdgeInsets.all(4),
            child: Icon(Icons.location_city_sharp),
          ),
        ),
      ),
    );
  }

  void _saveEmail(String? email) {
    // Handle saving email
  }
}
