import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../Providers/provider.dart';

class OTP_Field extends StatefulWidget {
  OTP_Field({super.key});

  @override
  State<OTP_Field> createState() => _OTP_FieldState();
}

class _OTP_FieldState extends State<OTP_Field> {
  @override
  Widget build(BuildContext context) {
    final _controller1 =
        Provider.of<WidgetProvider>(context, listen: false).controller1;
    final _controller2 =
        Provider.of<WidgetProvider>(context, listen: false).controller2;
    final _controller3 =
        Provider.of<WidgetProvider>(context, listen: false).controller3;
    final _controller4 =
        Provider.of<WidgetProvider>(context, listen: false).controller4;
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          otpField(_controller1),
          otpField(_controller2),
          otpField(_controller3),
          otpField(_controller4),
        ],
      ),
    );
  }

  Widget otpField(TextEditingController controller) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(228, 227, 227, 1)),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Color.fromRGBO(228, 227, 227, 1)),
          ),
        ),
        onChanged: (value) {
          Provider.of<WidgetProvider>(context, listen: false)
              .notifyControllers();
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty) {
            // Handle backspace when the field is empty
            FocusScope.of(context).previousFocus();
          }
        },
        style: Theme.of(context).textTheme.bodyLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
