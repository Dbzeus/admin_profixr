import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_button.dart';

class MultiSelectWidget extends StatefulWidget {
  MultiSelectWidget({Key? key, required this.title, required this.items})
      : super(key: key);

  String title = "Multi Select";

  RxList<Map<String, dynamic>> items;

  @override
  State<MultiSelectWidget> createState() => _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends State<MultiSelectWidget> {
  List<Map<String, dynamic>> selectedItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('widget item ${widget.items.toString()}');
    selectedItems =
        widget.items.where((p0) => p0['isSelected'] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          /*Obx(() {
            return Container(
              margin: const EdgeInsets.all(6),
              child: BoxEditText(
                placeholder: 'Search',
                controller: controller.query.value,
                onChanged: (val) {
                  if(val!=null) {
                    controller.filter(val);
                  }
                },
                fillColor: Colors.grey.withOpacity(0.2),
                textInputAction: TextInputAction.search,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: controller.searchQuery.isEmpty
                    ? const SizedBox.shrink()
                    : InkWell(
                    onTap: () {
                      Get.focusScope?.unfocus();
                      controller.query.value.clear();
                      controller.searchQuery('');
                      controller.filterList(false);
                    },
                    child: const Icon(Icons.close)),
              ),
            );
          }),*/
          Expanded(
            child: Obx(
              () => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.items.length,
                  itemBuilder: (_, index) {
                    var emp = widget.items[index];
                    return CheckboxListTile(
                        value: emp['isSelected'],
                        onChanged: (bool? value) {
                          emp['isSelected'] = value ?? false;
                          selectedItems = widget.items
                              .where((p0) => p0['isSelected'] == true)
                              .toList();
                          widget.items.refresh();
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          '${emp['value']}',
                          maxLines: 2,
                        ));
                  }),
            ),
          ),
          CustomButton(
            height: 40,
            width: 140,
            onTap: () {
              Get.back(result: selectedItems);
            },
            text: "Submit",
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
