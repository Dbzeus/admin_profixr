import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import 'package:profixer_admin/helpers/custom_colors.dart';

import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/profixer_response.dart';
import 'package:profixer_admin/screens/profixer/profixer_controller.dart';



import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../widgets/custom_loader.dart';



class AddProfixerScreen extends StatelessWidget {
  @override
  final controller = Get.find<ProfixerController>();

  AddProfixerScreen({Key? key}) : super(key: key);


  ProfixerData? profixerData = Get.arguments["data"];
  RxString title = Get.arguments["title"].obs;
  @override
  Widget build(BuildContext context) {
    if (profixerData != null) {
      controller.firstNameController.text =
          profixerData!.firstName.toString();
      controller.lastNameController.text =
          profixerData!.lastName.toString();
      controller.userNameController.text =
          profixerData!.userNAme.toString();
      controller.mobileController.text =
          profixerData!.mobileNo.toString();
      controller.permanentAddressController.text =
          profixerData!.permanentAddress.toString();
      controller.passwordController.text =
          profixerData!.password.toString();
      controller.relievedReasonController.text =
          profixerData!.relivedReason.toString();
      controller.currentAddressController.text =
          profixerData!.currentAddress.toString();
      controller.relievedDateController.text =
          toShowDateFormat(profixerData!.relivedDate).toString();
      controller.dojController.text =
          toShowDateFormat(profixerData!.doj).toString();
      controller.dobController.text =
          toShowDateFormat(profixerData!.dob).toString();
      controller.selectedIsActive(profixerData!.isActive);
      controller.selectedRelieveIsActive(profixerData!.isRelived);
      controller.isConfirm(true);

    } else {
      controller.firstNameController.clear();
      controller.lastNameController.clear();
      controller.userNameController.clear();
      controller.mobileController.clear();
      controller.dobController.clear();
      controller.permanentAddressController.clear();
      controller.passwordController.clear();
      controller.dojController.clear();
      controller.currentAddressController.clear();
      controller.relievedDateController.clear();
      controller.relievedReasonController.clear();
    controller.isConfirm(true);
    }

    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: title.value),
        body: Stack(
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    controller.isConfirm.value
                        ? Expanded(
                            child: Column(
                              children: [
                                CustomEditText(
                                    hintText: "First Name",
                                    controller: controller.firstNameController),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                    hintText: "Last Name",
                                    controller: controller.lastNameController),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                    hintText: "User Name",
                                    controller: controller.userNameController),
                                const SizedBox(
                                  height: 10,
                                ),
                                /*CustomDropDown(
                                    hintText: "Designation",
                                    dropDownValue: controller
                                        .designationDropDownValue.value,
                                    items: controller.designationDropDownItems,
                                    onSelected: (value) {
                                      controller
                                          .designationDropDownValue(value);
                                    }),*/
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "Date of Birth",
                                  showCursor: false,
                                  keyboardType: TextInputType.none,
                                  controller: controller.dobController,
                                  suffixIcon: const Icon(
                                    Icons.calendar_month_rounded,
                                    color: blackColor,
                                    size: 22,
                                  ),
                                  onTab: () async {
                                    var date = await showDatePicker(
                                        context: Get.context!,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(
                                            DateTime.now().year + 1, 12, 31));
                                    if (date != null) {
                                      debugPrint(date.toString());
                                      controller.dobController.text =
                                          DateFormat(controller.dateFormat)
                                              .format(date);
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "Mobile Number",
                                  controller: controller.mobileController,
                                  prefixIcon: Obx(
                                    () => DropdownButton(
                                        value:
                                            controller.mobileNoDropDownValue.value,
                                        style: const TextStyle(
                                            color: primaryColor, fontSize: 16),
                                        underline: const SizedBox(),
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: primaryColor,
                                          size: 16,
                                        ),
                                        items: controller.mobileItems
                                            .map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          controller.mobileNoDropDownValue(
                                              val.toString());
                                        }),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "Create Password",
                                  controller: controller.passwordController,
                                ),
                                const Spacer(),
                                CustomButton(
                                  text: "Next",
                                  btnColor: primaryColor,
                                  onTap: () {
                                    controller
                                        .isConfirm(!controller.isConfirm.value);
                                  },
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "Date of Joining",
                                  showCursor: false,
                                  isDense: true,
                                  keyboardType: TextInputType.none,
                                  controller: controller.dojController,
                                  suffixIcon: const Icon(
                                    Icons.calendar_month_rounded,
                                    color: blackColor,
                                    size: 22,
                                  ),
                                  onTab: () async {
                                    var date = await showDatePicker(
                                        context: Get.context!,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(
                                            DateTime.now().year + 1, 12, 31));
                                    if (date != null) {
                                      debugPrint(date.toString());
                                      controller.dojController.text =
                                          DateFormat(controller.dateFormat)
                                              .format(date);
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "Current Address",
                                  controller: controller.currentAddressController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "Permanent Address",
                                  controller: controller.permanentAddressController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(
                                      () => Row(
                                    children: [
                                      const Expanded(child: Text('Relieve Status')),
                                      InkWell(
                                        onTap: () {
                                          if (controller.selectedRelieveIsActive.value ==
                                              false) {
                                            controller.selectedRelieveIsActive(
                                                !controller.selectedRelieveIsActive.value);
                                          }
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: controller.selectedRelieveIsActive.value
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
                                                color: controller
                                                    .selectedRelieveIsActive.value
                                                    ? Colors.green
                                                    : Colors.black54,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                'Yes',
                                                style: TextStyle(
                                                  color: controller
                                                      .selectedRelieveIsActive.value
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

                                          if (controller.selectedRelieveIsActive.value ==
                                              true) {
                                            controller.selectedRelieveIsActive(
                                                !controller.selectedRelieveIsActive.value);

                                          }
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color:
                                            !controller.selectedRelieveIsActive.value
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
                                                color: !controller
                                                    .selectedRelieveIsActive.value
                                                    ? Colors.red
                                                    : Colors.black54,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                'No',
                                                style: TextStyle(
                                                  color: !controller
                                                      .selectedRelieveIsActive.value
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
                                CustomEditText(
                                  hintText: "Relieved Date",
                                  showCursor: false,
                                  isDense: true,
                                  keyboardType: TextInputType.none,
                                  controller: controller.relievedDateController,
                                  suffixIcon: const Icon(
                                    Icons.calendar_month_rounded,
                                    color: blackColor,
                                    size: 22,
                                  ),
                                  onTab: () async {
                                    var date = await showDatePicker(
                                        context: Get.context!,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(
                                            DateTime.now().year + 1, 12, 31));
                                    if (date != null) {
                                      debugPrint(date.toString());
                                      controller.relievedDateController.text =
                                          DateFormat(controller.dateFormat)
                                              .format(date);
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                CustomEditText(
                                  hintText: "Relieved Reason",
                                  controller: controller.relievedReasonController,
                                  minLines: 2,
                                  maxLines: 2,
                                ),
                                const SizedBox(
                                  height: 16,
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
                                                color: controller
                                                        .selectedIsActive.value
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
                                            color:
                                                !controller.selectedIsActive.value
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
                                                color: !controller
                                                        .selectedIsActive.value
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
                                  text: "Add",
                                  btnColor: primaryColor,
                                  onTap: () {

                                    var params ={
                                      "UserID": controller.box.read(Session.userId),
                                      "FirstName": controller.firstNameController.text,
                                      "LastName": controller.lastNameController.text,
                                      "Desigination": controller.designationDropDownValue.value,
                                      "DOB": toSendDateFormat(controller.dobController.text),
                                      "DOJ":toSendDateFormat(controller.dojController.text),
                                      "MobileNo": controller.mobileController.text,
                                      "CurrentAddress": controller.currentAddressController.text,
                                      "PermanentAddress": controller.permanentAddressController.text,
                                      "IsRelived": controller.selectedRelieveIsActive.value,
                                      "RelivedDate":toSendDateFormat( controller.relievedDateController.text),
                                      "RelivedReason": controller.relievedReasonController.text,
                                      "UserName": controller.userNameController.text,
                                      "Password": controller.passwordController.text,
                                      "IsActive": controller.selectedIsActive.value,
                                      "CUID": controller.box.read(Session.userId),
                                    };
                                    controller.insertUpdateProfixer(controller.selectedIsActive.value ,params);
                                  },
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Obx(() => controller.isLoading.value
                ? CustomLoader()
                : const SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
