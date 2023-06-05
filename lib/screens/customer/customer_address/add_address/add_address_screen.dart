
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_dialog.dart';
import 'package:profixer_admin/screens/customer/customer_controller.dart';
import 'package:profixer_admin/widgets/custom_dropdown.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../../helpers/custom_colors.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';

class AddAddressScreen extends StatelessWidget {
  final controller = Get.find<CustomerController>();
   AddAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(title: "Add Address"),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                  hintText: "Address title",
                  controller: controller.addressTitleController),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                  hintText: "Door No/ Plot No title",
                  controller: controller.doorNoController),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                  hintText: "Street Name",
                  controller: controller.streetNameController),
              const SizedBox(
                height: 10,
              ),
              CustomDropDown(
                  hintText: "City",
                  dropDownValue:
                  controller.cityDropDownValue.value,
                  items: controller.cityDropDownItems,
                  onSelected: (value) {
                    controller.cityDropDownValue(value);
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomDropDown(
                  hintText: "Area",
                  dropDownValue:
                  controller.areaDropDownValue.value,
                  items: controller.areaDropDownItems,
                  onSelected: (value) {
                    controller.areaDropDownValue(value);
                  }),
              const SizedBox(
                height: 10,
              ),



              CustomEditText(
                  hintText: "Landmark (optional)",
                  controller: controller.landmarkController),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Set Location",
                style: const TextStyle(color: hintColor, fontSize: 12),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                    () => Row(
                  children: [
                    const Expanded(child: Text('Status')),
                    InkWell(
                      onTap: () {
                        if (controller.selectedIsActive.value ==
                            false) {
                          controller.selectedIsActive(
                              !controller.selectedIsActive.value);
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: controller.selectedIsActive.value
                              ? greenColor
                              : Colors.grey.shade100,
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.done_rounded,
                              size: 16,
                              color:
                              controller.selectedIsActive.value
                                  ? Colors.green
                                  : Colors.black54,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Active',
                              style: TextStyle(
                                color: controller
                                    .selectedIsActive.value
                                    ? Colors.green
                                    : Colors.black54,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.selectedIsActive.value ==
                            true) {
                          controller.selectedIsActive(
                              !controller.selectedIsActive.value);
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: !controller.selectedIsActive.value
                              ? Colors.red.shade100
                              : Colors.grey.shade100,
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.close,
                              size: 16,
                              color:
                              !controller.selectedIsActive.value
                                  ? Colors.red
                                  : Colors.black54,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Inactive',
                              style: TextStyle(
                                color: !controller
                                    .selectedIsActive.value
                                    ? Colors.red
                                    : Colors.black54,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                  const Spacer(),
              CustomButton(
                  text:  "Next",//Get.arguments['buttonTitle'],
                  onTap: () {
                    /*customDialog(Get.context, "Success",
                        "Added Successfull", () {
                          //controller.isConfirm(!controller.isConfirm.value);
                        });
*/
                  }),

            ],
          ),

        ),
      ),
    );

  }
}
