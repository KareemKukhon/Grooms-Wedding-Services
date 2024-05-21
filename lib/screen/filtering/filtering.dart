import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Filtering extends StatefulWidget {
  String question;
  List<String> list = [];
  String hint;
  IconData icon;
  String? dropdownValue;
  void Function(String?)? onChange;
  Filtering({
    Key? key,
    required this.question,
    required this.list,
    required this.hint,
    required this.icon,
    required this.dropdownValue,
    required this.onChange,
  }) : super(key: key);

  @override
  State<Filtering> createState() => _FilteringState();
}

class _FilteringState extends State<Filtering> {


  @override
  void initState() {
    super.initState();;
  }

  bool _hasPopulatedCategories = false;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.question,
                  style: TextStyle(
                      fontFamily: "Portada ARA",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(43, 47, 78, 1)),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Icon(Icons.keyboard_arrow_down_outlined),
                    Expanded(
                      child: DropdownButton<String>(
                        value: widget.dropdownValue,
                        elevation: 16,
                        alignment: Alignment.centerRight,
                        hint: Text(widget.hint),
                        // isExpanded: true,
                        style: const TextStyle(
                          color: Colors.black45,
                        ),
                        isExpanded: true,
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        // isExpanded: true,
                        iconSize: 1,

                        // padding: EdgeInsets.only(
                        //     left: screenWidth - 120),
                        iconDisabledColor: Colors.transparent,
                        iconEnabledColor: Colors.transparent,
                        onChanged: widget.onChange,
                        items: widget.list
                            .map(
                              (item) => DropdownMenuItem(
                                alignment: Alignment.centerRight,
                                value: item,
                                child: Text(item,
                                    style: const TextStyle(fontSize: 14)),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(widget.icon, size: 28.r, color: Color.fromRGBO(19, 169, 179, 1)),
        ],
      ),
    );
  }
}
