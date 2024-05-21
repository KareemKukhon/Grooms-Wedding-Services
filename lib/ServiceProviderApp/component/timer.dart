import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeed_provider/ServiceProviderApp/var/var.dart';

class TimerDisplay extends StatefulWidget {
  final int initialTime; // Initial time in minutes

  const TimerDisplay({Key? key, required this.initialTime}) : super(key: key);

  @override
  _TimerDisplayState createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  int _remainingTime = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.initialTime;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
          if (_remainingTime <= 1) {
            flag = true;
          } else {
            flag = false;
          }
        });
      } else {
        _timer?.cancel(); // Stop timer when time runs out
      }
    });
  }

  String _formatTime(int remainingTime) {
    final minutes = (remainingTime / 60).floor();
    final seconds = remainingTime % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(_remainingTime),
      style: TextStyle(
          fontSize: 16.0.sp,
          fontFamily: 'Portada ARA',
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(247, 85, 85, 1)),
    );
  }
}
