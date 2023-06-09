import 'package:flutter/material.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';

class CustomDropDown extends StatelessWidget {
  String hintText;
  String dropDownValue;
  List<Map<String, String>> items;
  Function(String?) onSelected;
  Color textColor;

  CustomDropDown(
      {required this.hintText,
      required this.dropDownValue,
      required this.items,
      required this.onSelected,
      this.textColor = blackColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: const TextStyle(color: hintColor, fontSize: 12),
        ),

        DropdownButtonFormField(
            value: dropDownValue,
            style: TextStyle(color: textColor, fontSize: 16),
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: blackColor,
              size: 22,
            ),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            items: items.map((items) {
              return DropdownMenuItem(
                value: items["id"],
                child: Text('${items['value']}'),
              );
            }).toList(),
            onChanged: onSelected),
      ],
    );
  }
}
