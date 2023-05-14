

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/main/profile/change_details/change_details_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

class ChangeDetailsScreen extends GetView<ChangeDetailsController> {
  @override
  final controller = Get.put(ChangeDetailsController());
   ChangeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Get.focusScope!.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
              title: "Change Details"
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomEditText(
                    hintText: "Name",
                    controller: controller.nameController),
                const SizedBox(
                  height: 10,
                ),
                CustomEditText(
                  hintText: "Mobile Number",
                  controller: controller.mobileController,
                  prefixIcon: Obx(
                        () => DropdownButton(
                        value: controller.mobileNoDropDownValue.value,
                        style: const TextStyle(
                            color: primaryColor, fontSize: 16),
                        underline: const SizedBox(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: primaryColor,
                          size: 16,
                        ),
                        items: controller.mobileItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (val) {
                          controller.mobileNoDropDownValue(val.toString());
                        }),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomEditText(
                  hintText: "Designation",
                  controller: controller.designationController,
                  suffixIcon: Obx(
                        () => DropdownButton(
                        value: controller.designationDropDownValue.value,
                        style:
                        const TextStyle(color: blackColor, fontSize: 16),
                        underline: const SizedBox(),
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: blackColor,
                          size: 22,
                        ),
                        items: controller.designationItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (val) {
                          controller.designationDropDownValue(val.toString());
                        }),
                  ),
                ),
                const Spacer(),
                CustomButton(
                  text: "Save",
                  btnColor: primaryColor,
                  onTap: (){

                  },
                ),
              ],
            ),
          ),
        ));
  }
}
