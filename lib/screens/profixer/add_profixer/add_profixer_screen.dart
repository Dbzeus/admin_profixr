import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/profixer_response.dart';
import 'package:profixer_admin/screens/profixer/profixer_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../helpers/constant_widgets.dart';
import '../../../widgets/custom_loader.dart';

class AddProfixerScreen extends StatefulWidget {
  AddProfixerScreen({Key? key}) : super(key: key);

  @override
  State<AddProfixerScreen> createState() => _AddProfixerScreenState();
}

class _AddProfixerScreenState extends State<AddProfixerScreen> {
  final controller = Get.find<ProfixerController>();
  ProfixerData? profixerData = Get.arguments["data"];

  @override
  void initState() {
    super.initState();

    if (profixerData != null) {
      controller.firstNameController.text = profixerData!.firstName.toString();
      controller.lastNameController.text = profixerData!.lastName.toString();
      controller.userNameController.text = profixerData!.userNAme.toString();
      controller.mobileController.text = profixerData!.mobileNo.toString();
      controller.permanentAddressController.text =
          profixerData!.permanentAddress.toString();
      controller.passwordController.text = profixerData!.password.toString();
      controller.relievedReasonController.text =
          profixerData!.relivedReason.toString();
      controller.currentAddressController.text =
          profixerData!.currentAddress.toString();
      controller.relievedDateController.text = profixerData!.relivedDate.isEmpty
          ? ""
          : toShowDateFormat(profixerData!.relivedDate).toString();
      controller.dojController.text =
          toShowDateFormat(profixerData!.doj).toString();
      controller.dobController.text =
          toShowDateFormat(profixerData!.dob).toString();
      controller.selectedIsActive(profixerData!.isActive);
      controller.selectedRelieveIsActive(profixerData!.isRelived);
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
      controller.identityController.clear();
      controller.relievedReasonController.clear();
    }
    controller.isConfirm(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: Get.arguments["title"].toString(),
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
                                    hintText: "Designation",
                                    controller:
                                        controller.designationController),
                                const SizedBox(
                                  height: 10,
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
                                    controller.dobController.text =
                                        await getDate(
                                            initialDate: DateTime(DateTime.now().year -18, DateTime.now().month, DateTime.now().day),
                                            firstDate: DateTime(
                                              DateTime.now().year - 80,
                                            ),
                                            lastDate: DateTime(
                                                DateTime.now().year - 18,
                                                12,
                                                31));
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "Mobile Number",
                                  controller: controller.mobileController,
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
                                    hintText: "User Name",
                                    controller: controller.userNameController),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "Create a new password",
                                  controller: controller.passwordController,
                                ),
                                const Spacer(),
                                CustomButton(
                                  text: "Next",
                                  btnColor: primaryColor,
                                  onTap: () {
                                    if (controller.firstNameController.text.isEmpty) {
                                      toast("Please Enter First Name");
                                    } else if (controller.lastNameController.text.isEmpty) {
                                      toast("Please Enter Last Name");
                                    } else if (controller.designationController.text.isEmpty) {
                                      toast("Please Enter Designation");
                                    } else if (controller.dobController.text.isEmpty) {
                                      toast("Please Enter Your Date of Birth Address");
                                    } else if (controller.mobileController.text.isEmpty) {
                                      toast("Please Enter Mobile Number");
                                    } else if (controller.userNameController.text.isEmpty) {
                                      toast("Please Enter UserName");
                                    }else if (controller.passwordController.text.isEmpty) {
                                      toast("Please Enter Password");
                                    }else{
                                      controller
                                          .isConfirm(!controller.isConfirm.value);
                                    }

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
                                    controller.dojController.text =
                                        await getDate(
                                        initialDate: DateTime.now(),
                                    firstDate: DateTime(DateTime.now().year -80, 12, 31),
                                    lastDate: DateTime(DateTime.now().year + 1));
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "Current Address",
                                  controller:
                                      controller.currentAddressController,
                                  maxLines: 2,
                                  minLines: 2,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "Permanent Address",
                                  controller:
                                      controller.permanentAddressController,
                                  maxLines: 2,
                                  minLines: 2,
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
                                Obx(
                                  () => Row(
                                    children: [
                                      const Expanded(
                                          child: Text('Relieve Status')),
                                      InkWell(
                                        onTap: () {
                                          if (controller.selectedRelieveIsActive
                                                  .value ==
                                              false) {
                                            controller.selectedRelieveIsActive(
                                                !controller
                                                    .selectedRelieveIsActive
                                                    .value);
                                          }
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: controller
                                                    .selectedRelieveIsActive
                                                    .value
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
                                                        .selectedRelieveIsActive
                                                        .value
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
                                                          .selectedRelieveIsActive
                                                          .value
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
                                          if (controller.selectedRelieveIsActive
                                                  .value ==
                                              true) {
                                            controller.selectedRelieveIsActive(
                                                !controller
                                                    .selectedRelieveIsActive
                                                    .value);
                                          }
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: !controller
                                                    .selectedRelieveIsActive
                                                    .value
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
                                                        .selectedRelieveIsActive
                                                        .value
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
                                                          .selectedRelieveIsActive
                                                          .value
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
                                controller.selectedRelieveIsActive.value
                                    ? Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CustomEditText(
                                            hintText: "Relieved Date",
                                            showCursor: false,
                                            isDense: true,
                                            keyboardType: TextInputType.none,
                                            controller: controller
                                                .relievedDateController,
                                            suffixIcon: const Icon(
                                              Icons.calendar_month_rounded,
                                              color: blackColor,
                                              size: 22,
                                            ),
                                            onTab: () async {
                                              controller
                                                      .relievedDateController.text =
                                                  await getDate(
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(
                                                        DateTime.now().year -
                                                            18,
                                                      ),
                                                      lastDate: DateTime.now());
                                            },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CustomEditText(
                                            hintText: "Relieved Reason",
                                            controller: controller
                                                .relievedReasonController,
                                            minLines: 2,
                                            maxLines: 2,
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  height: 16,
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      const Expanded(child: Text('Status')),
                                      InkWell(
                                        onTap: () {
                                          if (controller
                                                  .selectedIsActive.value ==
                                              false) {
                                            controller.selectedIsActive(
                                                !controller
                                                    .selectedIsActive.value);
                                          }
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: controller
                                                    .selectedIsActive.value
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
                                                          .selectedIsActive
                                                          .value
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
                                          if (controller
                                                  .selectedIsActive.value ==
                                              true) {
                                            controller.selectedIsActive(
                                                !controller
                                                    .selectedIsActive.value);
                                          }
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: !controller
                                                    .selectedIsActive.value
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
                                                          .selectedIsActive
                                                          .value
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
                                        text: profixerData == null
                                            ? "Add"
                                            : "Update",
                                        btnColor: primaryColor,
                                        onTap: () {
                                          if (controller.dojController.text.isEmpty) {
                                            toast("Please Enter Date of joining");
                                          } else if (controller.currentAddressController.text.isEmpty) {
                                            toast("Please Enter Current address");
                                          } else if (controller.permanentAddressController.text.isEmpty) {
                                            toast("Please Enter Permanent Address");
                                          }else if (controller.identityController.text.isEmpty) {
                                            toast("Please Enter National ID");
                                          }else{
                                            var params = {
                                              "UserID": profixerData?.userID ?? 0,
                                              "FirstName": controller
                                                  .firstNameController.text,
                                              "LastName": controller
                                                  .lastNameController.text,
                                              "Desigination": controller
                                                  .designationController.text
                                                  .trim(),
                                              "DOB": toSendDateFormat(
                                                  controller.dobController.text),
                                              "DOJ": toSendDateFormat(
                                                  controller.dojController.text),
                                              "MobileNo": controller
                                                  .mobileController.text,
                                              "CurrentAddress": controller
                                                  .currentAddressController.text,
                                              "PermanentAddress": controller
                                                  .permanentAddressController
                                                  .text,
                                              "IsRelived": controller
                                                  .selectedRelieveIsActive.value,
                                              "RelivedDate": controller.selectedRelieveIsActive.value ? controller
                                                  .relievedDateController
                                                  .text
                                                  .isEmpty
                                                  ? ""
                                                  : toSendDateFormat(controller
                                                  .relievedDateController
                                                  .text) : "01-01-1900",
                                              "RelivedReason": controller
                                                  .relievedReasonController.text,
                                              "UserName": controller
                                                  .userNameController.text,
                                              "Password": controller
                                                  .passwordController.text,
                                              "IsActive": controller
                                                  .selectedIsActive.value,
                                              "CUID": controller.box
                                                  .read(Session.userId),
                                            };
                                            controller.insertUpdateProfixer(
                                                controller.selectedIsActive.value,
                                                params,
                                                profixerData != null);
                                          }

                                        },
                                      ),
                                    ),
                                  ],
                                )
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
