import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatefulWidget {
  String hint;
  List<String> items;
  IconData icon;
  String? selectedValue;
  void Function(String?)? onChanged;
  CustomDropdown({
    Key? key,
    required this.hint,
    required this.items,
    required this.icon,
    this.selectedValue,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFFEAEAEA)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          iconStyleData: IconStyleData(icon: Icon(widget.icon)),
          alignment: Alignment.centerRight,
          isExpanded: true,
          hint: Text(
            widget.hint,
            style: TextStyle(fontSize: 14, color: Theme.of(context).hintColor),
          ),
          items: widget.items
              .map(
                (item) => DropdownMenuItem(
                  alignment: Alignment.centerRight,
                  value: item,
                  child: Text(item, style: const TextStyle(fontSize: 14)),
                ),
              )
              .toList(),
          value: widget.selectedValue,
          onChanged: widget.onChanged,
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
  bool _searchMatchFunction(dynamic item, String searchValue) {
    return item.value.toString().contains(searchValue);
  }

  void _onMenuStateChange(bool isOpen) {
    if (!isOpen) {
      textEditingController.clear();
    }
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

}
