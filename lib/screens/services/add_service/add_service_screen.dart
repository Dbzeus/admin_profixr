import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_dropdown.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import 'add_service_controller.dart';

class AddServiceScreen extends GetView<AddServiceController> {
  @override
  final controller = Get.put(AddServiceController());

  AddServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: controller.title.value,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                  hintText: "Service Name",
                  controller: controller.serviceNameController),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Service Category",
                controller: controller.serviceCategoryController,
                suffixIcon: Obx(
                  () => DropdownButton(
                      value: controller.categoryDropDownValue.value,
                      style: const TextStyle(color: blackColor, fontSize: 16),
                      underline: const SizedBox(),
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: blackColor,
                        size: 22,
                      ),
                      items: controller.categoryItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (val) {
                        controller.categoryDropDownValue(val.toString());
                      }),
                ),
              ),
              // Obx(
              //   () => CustomDropDown(
              //       hintText: "Service Amount",
              //       dropDownValue: controller.categoryDropDownValue.value,
              //       items: controller.categoryItems,
              //       onSelected: (val){
              //         controller.categoryDropDownValue(val)
              //       },
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Service Amount",
                controller: controller.serviceAmountController,
                prefixIcon: Obx(
                  () => DropdownButton(
                      value: controller.dropDownValue.value,
                      style: const TextStyle(color: primaryColor, fontSize: 16),
                      underline: const SizedBox(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: primaryColor,
                        size: 16,
                      ),
                      items: controller.items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (val) {
                        controller.dropDownValue(val.toString());
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Service Description",
                controller: controller.serviceDescriptionController,
                maxLines: 3,
                minLines: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Service Image",
                style: TextStyle(color: hintColor, fontSize: 12),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => controller.imagePath.value.isNotEmpty
                  ? Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(controller.imagePath.value)),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black12,
                            Colors.black54,
                            Colors.black87
                          ],
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                controller.imagePath("");
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              )),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.remove_red_eye_outlined,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Preview',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : const SizedBox()),
              const SizedBox(
                height: 20,
              ),
              uploadButton(() async {
                controller.imagePath(
                    await getImageFromGallery() ?? controller.imagePath.value);
              }),
              const Spacer(),
              Obx(
                () => CustomButton(
                    text: controller.buttonTitle.value, onTap: () async {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
