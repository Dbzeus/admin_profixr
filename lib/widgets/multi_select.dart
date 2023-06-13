import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/custom_colors.dart';
import 'custom_button.dart';

class MultiSelectWidget extends StatefulWidget {
  MultiSelectWidget({Key? key, required this.title, required this.items, })
      : super(key: key);

  String title = "Multi Select";


  RxList<Map<String, dynamic>> items;


  @override
  State<MultiSelectWidget> createState() => _MultiSelectWidgetState();
}



class _MultiSelectWidgetState extends State<MultiSelectWidget> {
  List<Map<String, dynamic>> selectedItems = [];
  List<Map<String, dynamic>> searchItems = [];
  TextEditingController searchController  =TextEditingController();

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
  searchItems =widget.items;
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
          Container(
           width: MediaQuery.of(context).size.width,
           margin: const EdgeInsets.all(12),
           height: 50,
           decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(16),
               border: Border.all(color: Colors.grey.shade100),
               boxShadow: [
                 BoxShadow(
                     color: Colors.grey.shade100,
                     spreadRadius: 1,
                     blurRadius: 3,
                     offset: const Offset(0, 2))
               ]),
           child: TextFormField(
             controller: searchController,
             onChanged: (text){
               onSearchChanged(text);
             },
             style: const TextStyle(
               fontSize: 16,
               color: textColor,
             ),
             decoration: const InputDecoration(
               hintText: 'Search',
               border: InputBorder.none,
               prefixIcon: Icon(
                 Icons.search,
                 color: textColor,
               ),
             ),
           ),
              ),
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

  onSearchChanged(String text) {
    if (text.isEmpty) {
      debugPrint("search" + searchItems.toString());
      widget.items(searchItems);
      debugPrint("search" + widget.items.toString());
    } else {
      widget.items(searchItems
          .where((element) =>
      element["value"]
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase()))
          .toList());
    }
  }

}
