import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';

import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/admin_response.dart';

import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';
import 'package:profixer_admin/widgets/custom_loader.dart';


import '../service_provider_admin_controller.dart';

class AddAdminServiceProvider extends StatelessWidget {
  final controller = Get.find<ServiceProviderAdminController>();

  AddAdminServiceProvider({Key? key}) : super(key: key);

  AdminData? adminData = Get.arguments["service"];
  String title = Get.arguments["title"];

  @override
  Widget build(BuildContext context) {
    if (adminData != null) {
      controller.adminFirstNameController.text =
          adminData!.firstName.toString();
      controller.adminLastNameController.text = adminData!.lastName.toString();
      controller.adminUserNameController.text = adminData!.userNAme.toString();
      controller.adminMobNoController.text = adminData!.mobileNumber.toString();
      controller.adminPasswordController.text = adminData!.password.toString();
      controller.adminEmailController.text = adminData!.mailID.toString();
      controller.adminCurrentAddressController.text =
          adminData!.contactAddress.toString();
      controller.adminPermenantAddressController.text =
          adminData!.permanentAddress.toString();
      controller.adminDobController.text =
          toShowDateFormat(adminData!.dob).toString();
      controller.adminDojController.text =
          toShowDateFormat(adminData!.doj).toString();
      controller.selectedIsActive(adminData!.isActive);
      controller.isConfirm(true);
    } else {
      controller.adminFirstNameController.clear();
      controller.adminLastNameController.clear();
      controller.adminUserNameController.clear();
      controller.adminPasswordController.clear();
      controller.adminMobNoController.clear();
      controller.adminEmailController.clear();
      controller.adminCurrentAddressController.clear();
      controller.adminPermenantAddressController.clear();
      controller.adminDobController.clear();
      controller.adminDojController.clear();
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
                child: controller.isConfirm.value
                    ? Column(
                        children: [
                          CustomEditText(
                              hintText: "First Name",
                              controller: controller.adminFirstNameController),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                              hintText: "Last Name",
                              controller: controller.adminLastNameController),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                              hintText: "User Name",
                              controller: controller.adminUserNameController),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            hintText: "Mobile Number",
                            controller: controller.adminMobNoController,
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
                                    controller
                                        .mobileNoDropDownValue(val.toString());
                                  }),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                              hintText: "Create Password",
                              controller: controller.adminPasswordController),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            hintText: "Email",
                            controller: controller.adminEmailController,
                          ),
                          const Spacer(),
                          CustomButton(
                            text: "Next",
                            btnColor: primaryColor,
                            onTap: () {
                              controller.isConfirm(!controller.isConfirm.value);
                            },
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            hintText: "Current Address",
                            controller: controller.adminCurrentAddressController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            hintText: "Permanent Address",
                            controller: controller.adminPermenantAddressController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            hintText: "Date of Birth",
                            showCursor: false,
                            isDense: true,
                            keyboardType: TextInputType.none,
                            controller: controller.adminDobController,
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
                                  lastDate:
                                      DateTime(DateTime.now().year + 1, 12, 31));
                              if (date != null) {
                                debugPrint(date.toString());
                                controller.adminDobController.text =
                                    DateFormat(controller.dateFormat).format(date);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            hintText: "Date of Joining",
                            showCursor: false,
                            isDense: true,
                            keyboardType: TextInputType.none,
                            controller: controller.adminDojController,
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
                                  lastDate:
                                      DateTime(DateTime.now().year + 1, 12, 31));
                              if (date != null) {
                                controller.adminDojController.text =
                                    DateFormat(controller.dateFormat).format(date);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.done_rounded,
                                          size: 16,
                                          color: controller.selectedIsActive.value
                                              ? Colors.green
                                              : Colors.black54,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Active',
                                          style: TextStyle(
                                            color: controller.selectedIsActive.value
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
                                    if (controller.selectedIsActive.value == true) {
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.close,
                                          size: 16,
                                          color: !controller.selectedIsActive.value
                                              ? Colors.red
                                              : Colors.black54,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Inactive',
                                          style: TextStyle(
                                            color:
                                                !controller.selectedIsActive.value
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
                                var data = {
                                  "ServiceProviderUserID":  adminData?.serviceProviderUserID ?? 0,
                                  "UserID": controller.box.read(Session.userId),
                                  "ServiceProviderID": controller.serviceProviderId,
                                  "FirstName":
                                      controller.adminFirstNameController.text,
                                  "LastName":
                                      controller.adminLastNameController.text,
                                  "MobileNumber":
                                      controller.adminMobNoController.text,
                                  "MailID": controller.adminEmailController.text,
                                  "ContactAddress":
                                      controller.adminCurrentAddressController.text,
                                  "PermanentAddress": controller
                                      .adminPermenantAddressController.text,
                                  "DOB": controller.adminDobController.text,
                                  "DOJ": controller.adminDojController.text,
                                  "Username":
                                      controller.adminUserNameController.text,
                                  "Password":
                                      controller.adminPasswordController.text,
                                  "IsActive": controller.selectedIsActive.value,
                                  "CUID": controller.box.read(Session.userId),
                                };
                                controller.insertUpdateServiceProviderAdmin(controller.selectedIsActive.value,data);
                              }),
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
