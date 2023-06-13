import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_choices/search_choices.dart';

import '../helpers/custom_colors.dart';

class Spinner extends StatelessWidget {
  // final dynamic value;
  final String value;
  final List<Map<String, String>> items;
  final Function(String?)? onChanged;
  String hint;
  double? width;
  double? fontsize;
  Color? bgColor;
  Color textColor;
  Color? iconColor;
  bool isSearch;

  Spinner({
    required this.value,
    required this.items,
    this.onChanged,
    required this.hint,
    this.width,
    this.fontsize,
    this.bgColor,
    this.textColor = Colors.black,
    this.iconColor,
    this.isSearch=true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope?.unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hint,
            style: const TextStyle(color: hintColor, fontSize: 12),
          ),
          Container(
            width: width ?? Get.width,
            height: 48,
            padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: items.isEmpty
                    ? 0
                    : value.isEmpty
                        ? 12
                        : 0),
            child: SearchChoices.single(
              items: buildDropdownItem(items),
              value: value.isEmpty ? null : value,
              hint: hint,
              searchHint: hint,
              onChanged: onChanged,
              isExpanded: true,
              dialogBox: true,
              displayClearIcon: false,
              searchFn: (String keyword, it) {
                List<int> ret = [];
                if (it != null && it.isNotEmpty && keyword.isNotEmpty) {
                  keyword.split(" ").forEach((k) {
                    int i = 0;
                    it.forEach((item) {
                      if (k.isNotEmpty &&
                          (item.child.data
                              .toString()
                              .toLowerCase()
                              .contains(k.toLowerCase()))) {
                        ret.add(i);
                      }
                      i++;
                    });
                  });
                }
                if (keyword.isEmpty && items.isNotEmpty) {
                  ret = Iterable<int>.generate(items.length).toList();
                }
                return (ret);
              },
              underline: const SizedBox(height: 0, width: 0),
              padding: 0,
              style: TextStyle(color: textColor),
              iconEnabledColor: iconColor,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: blackColor,
                size: 22,
              ),
            ),
          ),
          Divider(color: textColor,),
        ],
      ),
    );
  }

  List<DropdownMenuItem> buildDropdownItem(
    List items, {
    double? fontSize,
  }) {
    List<DropdownMenuItem> list = [];
    for (dynamic v in items) {
      list.add(DropdownMenuItem(
        value: '${v['id']}',
        child: Text(
          '${v['value']}',
          style: TextStyle(
            fontSize: fontsize ?? 15,
          ),
        ),
      ));
    }
    return list;
  }
}
