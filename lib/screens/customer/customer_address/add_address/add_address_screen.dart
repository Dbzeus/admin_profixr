import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_dialog.dart';
import 'package:profixer_admin/model/customer_address_response.dart';
import 'package:profixer_admin/screens/customer/customer/customer_controller.dart';
import 'package:profixer_admin/screens/customer/customer_address/customer_address_controller.dart';
import 'package:profixer_admin/widgets/custom_dropdown.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../../helpers/custom_colors.dart';
import '../../../../helpers/utils.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';

class AddAddressScreen extends StatelessWidget {
  final controller = Get.find<CustomerAddressController>();

  AddAddressScreen({Key? key}) : super(key: key);

  CustomerAddress? address = Get.arguments['address'];

  @override
  Widget build(BuildContext context) {
    if (address != null) {
      controller.addressTitleController.text = address!.addressTitle;
      controller.doorNoController.text = address!.doorNo;
      controller.streetNameController.text = address!.streetName;
      controller.landmarkController.text = address!.landMark;
      controller.selectedArea(address!.areaID.toString());
      controller.selectedCity(address!.cityID.toString());
      controller.selectedIsActive(address!.isActive);
    } else {
      controller.addressTitleController.clear();
      controller.doorNoController.clear();
      controller.streetNameController.clear();
      controller.landmarkController.clear();
      controller.selectedIsActive(true);
    }

    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: Get.arguments['title']),
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
              Obx(() =>
                  CustomDropDown(
                      hintText: "City",
                      dropDownValue:
                      controller.selectedCity.value,
                      items: controller.cities,
                      onSelected: (value) {
                        controller.selectedCity(value);
                      }),),
              const SizedBox(
                height: 10,
              ),
              Obx(() =>
                  CustomDropDown(
                      hintText: "Area",
                      dropDownValue:
                      controller.selectedArea.value,
                      items: controller.areas,
                      onSelected: (value) {
                        controller.selectedArea(value);
                      }),),
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
                    () =>
                    Row(
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
                  text: Get.arguments['buttonTitle'],
                  onTap: () {
                    var data = {
                      "AddressID": address?.addressID ?? 0,
                      "CustomerID": address?.customerID ?? 0,
                      "AddressTitle": controller.addressTitleController.text
                          .trim(),
                      "DoorNo": controller.doorNoController.text.trim(),
                      "StreetName": controller.streetNameController.text.trim(),
                      "CityID": controller.selectedCity.value,
                      "AreaID": controller.selectedArea.value,
                      "LandMark": controller.landmarkController.text.trim(),
                      "Latitude": "",
                      "Longitude": "",
                      "IsActive": true,
                      "CUID": controller.box.read(Session.userId)
                    };
                    controller.insertCustomerAddress(
                        data, Get.arguments['address'] != null);
                  }),
            ],
          ),

        ),
      ),
    );
  }
}
