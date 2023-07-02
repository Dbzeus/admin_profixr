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
import '../../../../widgets/custom_loader.dart';
import '../../../../widgets/spinner.dart';

class AddAddressScreen extends StatefulWidget {

  AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final controller = Get.find<CustomerAddressController>();

  CustomerAddress? address = Get.arguments['address'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getCity();
  }

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
      controller.selectedCity("");
      controller.selectedArea("");
      controller.selectedIsActive(true);
    }

    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(title: Get.arguments['title']),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 16.0,
                  right: 16.0,
                  left: 16.0
              ),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
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
                            hintText: "Door No/ Plot Nos",
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
                        Obx(
                              () => Spinner(
                            value: controller.selectedCity.value,
                            items: controller.cities,
                            onChanged: (val) {
                              if (val == null && val==controller.selectedCity.value) return;
                              controller.selectedCity(val);
                              controller.getArea();
                            },
                            hint: 'City',
                          ),
                        ),
                        /*Obx(() =>
                        CustomDropDown(
                            hintText: "City",
                            dropDownValue:
                            controller.selectedCity.value,
                            items: controller.cities,
                            onSelected: (value) {
                              controller.selectedCity(value);
                              controller.getArea();
                            }),),*/
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                              () => Spinner(
                            value: controller.selectedArea.value,
                            items: controller.areas,
                            onChanged: (val) {
                              if (val == null && val==controller.selectedArea.value) return;
                              controller.selectedArea(val);
                            },
                            hint: 'Area',
                          ),
                        ),
                        /*Obx(() =>
                        CustomDropDown(
                            hintText: "Area",
                            dropDownValue:
                            controller.selectedArea.value,
                            items: controller.areas,
                            onSelected: (value) {
                              controller.selectedArea(value);
                            }),),*/
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
                        const SizedBox(
                          height: 10,
                        ),
                        const Spacer(),
                        CustomButton(
                            text: Get.arguments['buttonTitle'],
                            onTap: () {
                              controller.validation(Get.arguments['address'] != null,address);
                            }),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  )
                ],

              ),
            ),
            Obx(()=> controller.isLoading.value ? CustomLoader() : const SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
