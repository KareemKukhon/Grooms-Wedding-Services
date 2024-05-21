import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadio extends StatefulWidget {
  int value;
  String textValue;
  int groupValue;
  Color? color;
  Color? selectedColor;
  bool filledColor;
  bool checkButton;
  void Function(int?) onChange;
  CustomRadio({
    Key? key,
    required this.value,
    required this.textValue,
    required this.groupValue,
    this.color = Colors.white,
    this.selectedColor = const Color.fromRGBO(19, 169, 179, 1),
    required this.filledColor,
    this.checkButton = true,
    required this.onChange,
  }) : super(key: key);

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool selected = widget.value != widget.groupValue;
        if (selected) {
          widget.onChange(widget.value);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: widget.filledColor ? 40.w : 0,
            vertical: widget.filledColor ? 20.h : 15.h),
        decoration: widget.filledColor
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: widget.value == widget.groupValue
                        ? Color.fromRGBO(19, 169, 179, 1)
                        : Color.fromARGB(255, 179, 179, 179)),
                color: widget.value == widget.groupValue
                    ? Color.fromRGBO(19, 179, 175, 0.1)
                    : Colors.white)
            : BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.textValue,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: widget.value == widget.groupValue
                      ? Color.fromRGBO(19, 169, 179, 1)
                      : Color.fromRGBO(141, 140, 140, 1),
                  fontFamily: 'Portada ARA',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 10,
            ),
            (widget.checkButton ||
                    (!widget.checkButton && widget.value == widget.groupValue))
                ? Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                        color: widget.value == widget.groupValue
                            ? widget.selectedColor
                            : widget.color,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: widget.value != widget.groupValue
                                ? Color.fromARGB(255, 150, 150, 150)
                                : Colors.transparent)),
                    child: Center(
                        child: widget.value == widget.groupValue
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              )
                            : Container()),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
