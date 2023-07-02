import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
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
      controller.identityController.clear();
      controller.isConfirm(true);
    }
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: controller.isConfirm.value
                    ? CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            fillOverscroll: true,
                            child: Column(
                              children: [
                                CustomEditText(
                                    hintText: "First Name",
                                    controller:
                                        controller.adminFirstNameController),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                    hintText: "Last Name",
                                    controller:
                                        controller.adminLastNameController),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "Mobile Number",
                                  controller: controller.adminMobNoController,
                                  maxLength: 10,
                                  keyboardType: TextInputType.phone,
                                  prefixIcon: Obx(
                                    () => DropdownButton(
                                        value: controller
                                            .mobileNoDropDownValue.value,
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
                                  controller: controller.adminEmailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                    hintText: "User Name",
                                    controller:
                                        controller.adminUserNameController),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                    hintText: "Create a new password",
                                    controller:
                                        controller.adminPasswordController),
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
                                const Spacer(),
                                CustomButton(
                                  text: "Next",
                                  btnColor: primaryColor,
                                  onTap: () {
                                    if (controller.adminFirstNameController.text
                                        .isEmpty) {
                                      toast("Please Enter Your First Name ");
                                    } else if (controller
                                        .adminLastNameController.text.isEmpty) {
                                      toast("Please Enter Last Name");
                                    } else if (controller
                                        .adminMobNoController.text.isEmpty) {
                                      toast("Please Enter Your Mobile Number");
                                    } else if (controller
                                        .adminEmailController.text.isEmpty) {
                                      toast("Please Enter Email ID");
                                    } else if (controller
                                        .adminUserNameController.text.isEmpty) {
                                      toast("Please Enter User Name");
                                    } else if (controller
                                        .adminPasswordController.text.isEmpty) {
                                      toast("Please Enter Your Password");
                                    } else if (controller
                                        .identityController.text.isEmpty) {
                                      toast("Please Enter Your National ID");
                                    } else {
                                      controller.isConfirm(
                                          !controller.isConfirm.value);
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    : CustomScrollView(
                  physics:const  NeverScrollableScrollPhysics(),
                                    slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            hintText: "Current Address",
                            controller:
                            controller.adminCurrentAddressController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            hintText: "Permanent Address",
                            controller:
                            controller.adminPermenantAddressController,
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
                              controller.adminDobController.text =
                              await getDate(
                                  initialDate: DateTime(
                                      DateTime.now().year - 18,
                                      DateTime.now().month,
                                      DateTime.now().day),
                                  firstDate: DateTime(
                                      DateTime.now().year - 80, 12, 31),
                                  lastDate: DateTime(
                                      DateTime.now().year - 18, 12, 31));
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
                              controller.adminDojController.text =
                              await getDate(
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      DateTime.now().year - 80, 12, 31),
                                  lastDate:
                                  DateTime(DateTime.now().year + 1));
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
                          const Spacer(

                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: CustomButton(
                                      text: 'Back',
                                      onTap: () => controller.isConfirm(
                                          !controller.isConfirm.value))),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: CustomButton(
                                    text: adminData == null ? "Add" : "Update",
                                    btnColor: primaryColor,
                                    onTap: () {
                                      if (controller
                                          .adminCurrentAddressController
                                          .text
                                          .isEmpty) {
                                        toast("Please Enter Current Address ");
                                      } else if (controller
                                          .adminPermenantAddressController
                                          .text
                                          .isEmpty) {
                                        toast(
                                            "Please Enter Permanent Address ");
                                      } else if (controller
                                          .adminDobController.text.isEmpty) {
                                        toast("Please Select Date of Birth");
                                      } else if (controller
                                          .adminDojController.text.isEmpty) {
                                        toast("Please Select Date of Joining");
                                      } else {
                                        var data = {
                                          "ServiceProviderUserID": adminData
                                              ?.serviceProviderUserID ??
                                              0,
                                          "UserID": adminData?.userID ?? 0,
                                          "ServiceProviderID":
                                          controller.serviceProviderId,
                                          "FirstName": controller
                                              .adminFirstNameController.text
                                              .trim(),
                                          "LastName": controller
                                              .adminLastNameController.text
                                              .trim(),
                                          "MobileNumber": controller
                                              .adminMobNoController.text
                                              .trim(),
                                          "MailID": controller
                                              .adminEmailController.text
                                              .trim(),
                                          "ContactAddress": controller
                                              .adminCurrentAddressController
                                              .text
                                              .trim(),
                                          "PermanentAddress": controller
                                              .adminPermenantAddressController
                                              .text
                                              .trim(),
                                          "DOB": toSendDateFormat(controller
                                              .adminDobController.text),
                                          "DOJ": toSendDateFormat(controller
                                              .adminDojController.text),
                                          "Username": controller
                                              .adminUserNameController.text
                                              .trim(),
                                          "Password": controller
                                              .adminPasswordController.text
                                              .trim(),
                                          "IsActive":
                                          controller.selectedIsActive.value,
                                          "CUID": controller.box
                                              .read(Session.userId),
                                        };
                                        controller
                                            .insertUpdateServiceProviderAdmin(
                                            controller
                                                .selectedIsActive.value,
                                            data);
                                      }
                                    }),

                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
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
