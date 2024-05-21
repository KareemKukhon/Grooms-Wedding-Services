import 'dart:developer';

import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/component/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MarriageCost extends StatefulWidget {
  const MarriageCost({super.key});

  @override
  State<MarriageCost> createState() => _MarriageCostState();
}

class _MarriageCostState extends State<MarriageCost> {
  Map<int, Widget> rowsMap = {};
  Map<String, int> costs = {};
  List<TextEditingController> costController = [];
  List<TextEditingController> titleController = [];
  int total = 0;
  int _id = 0; // ID for tracking widgets

  @override
  void initState() {
    super.initState();
    // Initially add one row
    _addRow();
  }

  void _addRow() {
    final int id = _id++;
    TextEditingController firstController = TextEditingController();
    TextEditingController secondController = TextEditingController();
    costController.add(firstController);
    titleController.add(secondController);
    rowsMap[id] = _buildRow(id, firstController, secondController);
    setState(() {});
  }

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
            onPressed: () async {
              log(costController.map((e) => e.text).toString());
              setState(() {
                total = 0;
                for (int i = 0; i < costController.length; i++) {
                  total += int.parse(costController[i].text);
                  costs[titleController[i].text] =
                      int.parse(costController[i].text);
                }
              });
              log(costs.toString());
              await Provider.of<LoginSignup>(context, listen: false)
                  .marriageCostCalc(map: costs);
            },
            child: Text(
              'احسب',
              style: TextStyle(
                  fontFamily: 'Portada ARA',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(252, 252, 252, 1)),
            )),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 35, right: 20, left: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text('حاسبة تكلفة الزواج',
                      textAlign: TextAlign.center,
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
                                      color: Color.fromARGB(
                                          255, 225, 225, 225))))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_forward))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(children: rowsMap.values.toList()),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: Color(0xFF13A9B3),
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 22, 201, 213)
                              .withOpacity(0.5),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _addRow();
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Divider(
                          color: Color(0xFF13A9B3),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'المجموع: $total',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Portada ARA',
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(int id, TextEditingController firstController,
      TextEditingController secondController) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              _deleteRow(id, firstController);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          Expanded(
            child: CustomTextField(
              text: "المبلغ",
              controller: firstController,
              type: TextInputType.number,
              onSaved: (p0) {
                _updateMap(firstController.text, secondController.text);
              },
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: CustomTextField(
              text: "قاعة افراح",
              controller: secondController,
              onSaved: (p0) {
                _updateMap(firstController.text, secondController.text);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateMap(String price, String title) {
    setState(() {
      costs[title] = int.tryParse(price) ?? 0;
    });
    log(costs.toString());
  }

  void _deleteRow(int id, TextEditingController controller) {
    setState(() {
      rowsMap.remove(id);
      costController.remove(controller);
    });
  }
}
