import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Rafeed/Providers/provider.dart';

class LeanPageIndicator extends StatefulWidget {
  final int pageCount;
  final int currentPage;
  final Color indicatorColor;
  final Color notLoadedColor;
  final double indicatorSize;
  final double spacing;
  final Duration animationDuration;
  bool stepper;

  LeanPageIndicator({
    Key? key,
    required this.pageCount,
    required this.currentPage,
    this.indicatorColor = Colors.blue,
    this.notLoadedColor = const Color.fromRGBO(217, 217, 217, 1),
    this.indicatorSize = 1.5,
    this.spacing = 8.0,
    this.animationDuration = const Duration(milliseconds: 300),
    required this.stepper,
  }) : super(key: key);

  @override
  _LeanPageIndicatorState createState() => _LeanPageIndicatorState();
}

class _LeanPageIndicatorState extends State<LeanPageIndicator> {
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    // _currentPage = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    _currentPage = Provider.of<WidgetProvider>(context).currentPage;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ...widget.stepper
            ? _buildIndicators(screenWidth)
            : _buildIndicators1(screenWidth),
      ],
    );
  }

  List<Widget> _buildIndicators(double screenWidth) {
    List<Widget> indicators = [];
    for (int i = widget.pageCount - 1; i >= 0; i--) {
      indicators.add(
        AnimatedContainer(
          duration: widget.animationDuration,
          width: (screenWidth / widget.pageCount) - 5,
          height: widget.indicatorSize,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: i == _currentPage
                ? BorderRadius.circular(10)
                : BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
            color: i == _currentPage
                ? widget.indicatorColor
                : widget.notLoadedColor,
          ),
        ),
      );
    }
    return indicators;
  }

  List<Widget> _buildIndicators1(double screenWidth) {
    List<Widget> indicators = [];

    if (_currentPage == 0) {
      indicators.add(
        AnimatedContainer(
          duration: widget.animationDuration,
          width: (screenWidth / widget.pageCount) - 20,
          height: widget.indicatorSize,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
              color: widget.notLoadedColor),
        ),
      );
      indicators.add(
        AnimatedContainer(
          duration: widget.animationDuration,
          width: (screenWidth / widget.pageCount) - 20,
          height: widget.indicatorSize,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
              color: widget.indicatorColor),
        ),
      );
    } else {
      for (int i = 0; i < widget.pageCount; i++) {
        indicators.add(
          AnimatedContainer(
            duration: widget.animationDuration,
            width: (screenWidth / widget.pageCount) - 20,
            height: widget.indicatorSize,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: i == 0
                    ? BorderRadius.horizontal(left: Radius.circular(10))
                    : BorderRadius.horizontal(right: Radius.circular(10)),
                color: widget.indicatorColor),
          ),
        );
      }
    }
    // for (int i = _currentPage; i >= 0; i--) {
    //   indicators.add(
    //     AnimatedContainer(
    //       duration: widget.animationDuration,
    //       width: (screenWidth / widget.pageCount) - 20,
    //       height: widget.indicatorSize,
    //       decoration: BoxDecoration(
    //           shape: BoxShape.rectangle,
    //           borderRadius: BorderRadius.circular(10),
    //           color: widget.notLoadedColor),
    //     ),
    //   );
    // }
    return indicators;
  }
}
