import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';

import 'package:profixer_admin/helpers/utils.dart';

import 'package:profixer_admin/screens/service_provider/service_provider/service_provider_controller.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../../model/serviceprovider_response.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_dropdown.dart';
import '../../../../widgets/custom_loader.dart';
import '../../service_provider_admin/service_provider_admin_list/service_provider_admin_list.dart';

class AddServiceProviderScreen extends StatelessWidget {
  final controller = Get.find<ServiceProviderController>();

  AddServiceProviderScreen({Key? key}) : super(key: key);

  ServiceProviderData? serviceProviderData = Get.arguments["service"];

  @override
  Widget build(BuildContext context) {
    if (serviceProviderData != null) {
      controller.servicerProviderNameController.text =
          serviceProviderData!.serviceProviderName.toString();
      controller.contactNameController.text =
          serviceProviderData!.contactPerson.toString();
      controller.userNameController.text =
          serviceProviderData!.contactPerson.toString();
      controller.mobileController.text =
          serviceProviderData!.contactNumber.toString();
      controller.emailController.text =
          serviceProviderData!.contactMailID.toString();
      controller.permanentAddressController.text =
          serviceProviderData!.contactAddress.toString();
      controller.taxDetailsController.text =
          serviceProviderData!.taxDetails.toString();
      controller.bankDetailsController.text =
          serviceProviderData!.bankDetails.toString();
      controller.contractStartController.text =
          toShowDateFormat(serviceProviderData!.contractStartDate).toString();
      controller.contractEndController.text =
          toShowDateFormat(serviceProviderData!.contractEndDate).toString();
      controller.selectedIsActive(serviceProviderData!.isActive);
    } else {
      controller.servicerProviderNameController.clear();
      controller.contactNameController.clear();
      controller.userNameController.clear();
      controller.mobileController.clear();
      controller.emailController.clear();
      controller.permanentAddressController.clear();
      controller.taxDetailsController.clear();
      controller.bankDetailsController.clear();
      controller.contractStartController.clear();
      controller.contractEndController.clear();

    }
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: Get.arguments["title"].toString(),
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
                    Get.arguments["slider"] ?? true
                        ? Obx(
                            () => Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              child: CupertinoSlidingSegmentedControl(
                                thumbColor: primaryColor,
                                backgroundColor: cardBgColor,
                                groupValue: controller.selectedTag.value,
                                padding: const EdgeInsets.all(6),
                                onValueChanged: (value) {
                                  controller.selectedTag(value);
                                },
                                children: {
                                  0: Text(
                                    "Service Provider",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: controller.selectedTag.value == 0
                                            ? whiteColor
                                            : primaryColor),
                                  ),
                                  1: Text(
                                    "Admin",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: controller.selectedTag.value == 1
                                            ? whiteColor
                                            : primaryColor),
                                  ),
                                },
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    controller.selectedTag.value == 0
                        ? controller.isConfirm.value
                            ? Expanded(
                                child: Column(
                                  children: [
                                    CustomEditText(
                                        hintText: "Service Provider Name",
                                        controller: controller
                                            .servicerProviderNameController),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomEditText(
                                        hintText: "Contact Person Name",
                                        controller:
                                            controller.contactNameController),
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
                                      hintText: "Mobile Number",
                                      controller: controller.mobileController,
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
                                      controller: controller.emailController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomEditText(
                                      hintText: "Permanent Address",
                                      controller:
                                          controller.permanentAddressController,
                                    ),
                                    const SizedBox(
                                      height: 20,
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
                                        hintText: "Tax Details ",
                                        maxLines: 2,
                                        controller:
                                            controller.taxDetailsController),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomEditText(
                                        hintText: "Bank Details ",
                                        maxLines: 2,
                                        controller:
                                            controller.bankDetailsController),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Obx(
                                          () => CustomDropDown(
                                        hintText: "What kind of service you Provide?",
                                        dropDownValue: controller.selectedService.value,
                                        items: controller.serviceList,
                                        onSelected: (val) {
                                          controller.selectedService(val);
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Obx(
                                          () => CustomDropDown(
                                          hintText: "Which area do you prefer? ",
                                          dropDownValue: controller
                                              .selectedArea.value,
                                          items:
                                          controller.areaList,
                                          onSelected: (value) {
                                            controller
                                                .selectedArea(value);
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomEditText(
                                      hintText: "Contract Start Date",
                                      showCursor: false,
                                      isDense: true,
                                      keyboardType: TextInputType.none,
                                      controller:
                                          controller.contractStartController,
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
                                          controller.contractStartController.text =
                                              DateFormat(controller.dateFormat)
                                                  .format(date);
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomEditText(
                                      hintText: "Contract End Date",
                                      showCursor: false,
                                      isDense: true,
                                      keyboardType: TextInputType.none,
                                      controller: controller.contractEndController,
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
                                          controller.contractEndController.text =
                                              DateFormat(controller.dateFormat)
                                                  .format(date);
                                        }
                                      },
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
                                    CustomButton(
                                      text: "Add",
                                      btnColor: primaryColor,
                                      onTap: () {
                                        var params = {
                                          "ServiceProviderID":serviceProviderData?.serviceProviderID
                                                  ??
                                              0,
                                          "ServiceProviderName": controller
                                              .servicerProviderNameController.text,
                                          "ContactPerson":
                                              controller.contactNameController.text,
                                          "ContactNumber":
                                              controller.mobileController.text,
                                          "ContactMailID":
                                              controller.emailController.text,
                                          "ContactAddress": controller
                                              .permanentAddressController.text,
                                          "TaxDetails":
                                              controller.taxDetailsController.text,
                                          "BankDetails":
                                              controller.bankDetailsController.text,
                                          "ServiceIDs":
                                              serviceProviderData?.serviceIDs ?? "0",
                                          "AreaIDs":
                                              serviceProviderData?.areaIDs ?? "0",
                                          "ContractStartDate": controller
                                              .contractStartController.text,
                                          "ContractEndDate":
                                              controller.contractEndController.text,
                                          "IsActive": controller.selectedIsActive.value,
                                          "CUID":
                                              controller.box.read(Session.userId),
                                        };
                                        controller
                                            .insertUpdateServiceProvider(controller.selectedIsActive.value,params);

                                      },
                                    ),
                                  ],
                                ),
                              )
                        : ServiceProviderAdminList()
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
