import 'package:flutter/material.dart';

class ImageSliderWidget extends StatefulWidget {
  final List<String> imageList;

  const ImageSliderWidget({required this.imageList});

  @override
  _ImageSliderWidgetState createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height /
          2.5), // Set exact half-page height
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.imageList.length,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.imageList[index],
                        ))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, right: 15),
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Set your desired border radius here
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color?>(
                                Colors.white)),
                        icon: Icon(
                          Icons.arrow_forward_outlined,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.imageList.asMap().entries.map((entry) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == entry.key
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                              width: _currentPage == entry.key ? 8.0 : 6.0,
                              height: _currentPage == entry.key ? 8.0 : 6.0,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
