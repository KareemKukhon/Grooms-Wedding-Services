import 'package:flutter/material.dart';

class CheckboxGroup extends StatefulWidget {
  @override
  _CheckboxGroupState createState() => _CheckboxGroupState();
}

class _CheckboxGroupState extends State<CheckboxGroup> {
  // List of items for the checkboxes
  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  // Track the selected item
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox Group'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return CheckboxItem(
            title: item,
            isSelected: selectedItem == item,
            onChanged: (bool? newValue) {
              setState(() {
                if (newValue != null && newValue) {
                  selectedItem = item;
                } else {
                  selectedItem = null;
                }
              });
            },
          );
        },
      ),
    );
  }
}

class CheckboxItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;

  const CheckboxItem({
    Key? key,
    required this.title,
    required this.isSelected,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      value: isSelected,
      onChanged: onChanged,
    );
  }
}
