import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/technician_response.dart';

import 'package:profixer_admin/screens/technician/technician_controller.dart';

import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_loader.dart';

class AddTechnicianScreen extends StatelessWidget {
  @override
  final controller = Get.find<TechnicianController>();

  AddTechnicianScreen({Key? key}) : super(key: key);

  TechnicainData? technicianData = Get.arguments["data"];
  String title = Get.arguments["title"];

  @override
  Widget build(BuildContext context) {
    if (technicianData != null) {
      controller.firstNameController.text =
          technicianData!.firstName.toString();
      controller.lastNameController.text = technicianData!.lastName.toString();
      controller.mobileController.text =
          technicianData!.mobileNumber.toString();
      controller.emailController.text = technicianData!.mailID.toString();
      controller.dobController.text =
          toShowDateFormat(technicianData!.dob).toString();
      controller.userNameController.text = technicianData!.userNAme.toString();
      controller.passwordController.text = technicianData!.password.toString();
      controller.selectedServiceProvider(
          technicianData!.serviceProviderID.toString());
      controller.dojController.text =
          toShowDateFormat(technicianData!.doj).toString();
      /*controller.selectedService(
          technicianData!.serviceIDs.toString());
      controller.selectedArea(
          technicianData!.areaIDs.toString());*/
      controller.currentAddressController.text =
          technicianData!.contactAddress.toString();
      controller.permanentAddressController.text =
          technicianData!.permanentAddress.toString();
      controller.isConfirm(true);
      //controller.selectedIsActive(TechnicianData!.isActive);
    } else {
      controller.firstNameController.clear();
      controller.lastNameController.clear();
      controller.userNameController.clear();
      controller.mobileController.clear();
      controller.emailController.clear();
      controller.dobController.clear();
      controller.passwordController.clear();
      controller.permanentAddressController.clear();
      controller.currentAddressController.clear();
      controller.dojController.clear();
      controller.identityController.clear();
      controller.isConfirm(true);
    }
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: title,
          onTap: () {
            if (controller.isConfirm.value == false) {
              controller.isConfirm(!controller.isConfirm.value);
            } else {
              Get.back();
            }
          },
        ),
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
                                  hintText: "Email",
                                  controller: controller.emailController,
                                ),
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
                                  hintText: "Username",
                                  controller: controller.userNameController,
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
                                Obx(
                                  () => CustomDropDown(
                                      hintText: "Service Provider",
                                      dropDownValue:
                                          controller.selectedServiceProvider.value,
                                      items: controller.serviceProviderList,
                                      onSelected: (value) {
                                        controller.selectedServiceProvider(value);
                                        controller.getServiceProviderService();
                                        controller.getServiceProviderArea();
                                      }),
                                ),
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
                                Obx(
                                  () => CustomDropDown(
                                      hintText: "What kind of service you do?",
                                      dropDownValue:
                                          controller.selectedService.value,
                                      items: controller.servicesList,
                                      onSelected: (value) {
                                        controller.selectedService(value);
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(
                                  () => CustomDropDown(
                                      hintText: "Which area do you prefer? ",
                                      dropDownValue: controller.selectedArea.value,
                                      items: controller.areaList,
                                      onSelected: (value) {
                                        controller.selectedArea(value);
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "National ID",
                                  controller: controller.identityController,
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
                                    var params = {
                                      "TechnicianID":
                                          technicianData?.technicianID ?? 0,
                                      "UserID":
                                          controller.box.read(Session.userId),
                                      "ServiceProviderID":
                                          technicianData?.serviceProviderID ?? 0,
                                      "FirstName":
                                          controller.firstNameController.text,
                                      "LastName":
                                          controller.lastNameController.text,
                                      "MobileNumber":
                                          controller.mobileController.text,
                                      "MailID": controller.emailController.text,
                                      "ContactAddress":
                                          controller.currentAddressController.text,
                                      "PermanentAddress": controller
                                          .permanentAddressController.text,
                                      "DOB": toSendDateFormat(controller.dobController.text),
                                      "DOJ": toSendDateFormat(controller.dojController.text),
                                      "ServiceIDs": technicianData?.serviceIDs ?? "0",
                                      "AreaIDs": technicianData?.areaIDs ?? "0",
                                      "Username":
                                          controller.userNameController.text,
                                      "Password":
                                          controller.passwordController.text,
                                      "IsActive": controller.selectedIsActive.value,
                                      "CUID": controller.box.read(Session.userId),
                                    };
                                    controller.insertUpdateTechnician(
                                        controller.selectedIsActive.value, params);
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
