import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';

import 'package:profixer_admin/helpers/utils.dart';

import 'package:profixer_admin/screens/service_provider/service_provider/service_provider_controller.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../../helpers/constant_widgets.dart';
import '../../../../model/serviceprovider_response.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_loader.dart';
import '../../../../widgets/multi_select.dart';
import '../../service_provider_admin/service_provider_admin_list/service_provider_admin_list.dart';

class AddServiceProviderScreen extends StatefulWidget {

  AddServiceProviderScreen({Key? key}) : super(key: key);

  @override
  State<AddServiceProviderScreen> createState() => _AddServiceProviderScreenState();
}

class _AddServiceProviderScreenState extends State<AddServiceProviderScreen> {
  final controller = Get.find<ServiceProviderController>();

  ServiceProviderData? serviceProviderData = Get.arguments["service"];

  @override
  void initState() {
    super.initState();
    controller.isConfirm(true);
    if (serviceProviderData != null) {
      controller.serviceProviderId=serviceProviderData!.serviceProviderID;
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

      controller.getServiceProviderArea(canClear: false);
      controller.getServiceProviderService(canClear: false);
      controller.selectedService = serviceProviderData!.serviceIDs.toString();
      controller.selectedServiceName(serviceProviderData!.serviceName);
      controller.selectedArea = serviceProviderData!.areaIDs.toString();
      controller.selectedAreaNames(serviceProviderData!.areaName.toString());

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
      controller.selectedService="";
      controller.selectedServiceName("");
      controller.selectedArea="";
      controller.selectedAreaNames("");
      controller.identityController.clear();
      controller.getServiceProviderArea();
      controller.getServiceProviderService();
    }
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
                                      controller: controller.emailController,
                                      keyboardType: TextInputType.emailAddress,
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
                                      height: 10,
                                    ),
                                    CustomEditText(
                                      hintText: "National ID",
                                      controller: controller.identityController,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Spacer(),
                                    CustomButton(
                                      text: "Next",
                                      btnColor: primaryColor,
                                      onTap: () {
                                        if (controller.servicerProviderNameController.text.isEmpty) {
                                          toast("Please Enter Service Provider Name");
                                        } else if (controller.contactNameController.text.isEmpty) {
                                          toast("Please Enter Contact Person Name");
                                        } else if (controller.userNameController.text.isEmpty) {
                                          toast("Please Enter User Name");
                                        } else if (controller.mobileController.text.isEmpty) {
                                          toast("Please Enter Your Mobile Number");
                                        } else if (controller.emailController.text.isEmpty) {
                                          toast("Please Enter Email ID");
                                        } else if (controller.permanentAddressController.text.isEmpty) {
                                          toast("Please Enter Permanent Address");
                                        }else if (controller.identityController.text.isEmpty) {
                                          toast("Please Enter National Id");
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Text('What kind of service you do?',style: TextStyle(
                                        fontSize: 12
                                    ),),
                                    Obx(()=>Wrap(
                                      direction: Axis.horizontal,
                                      spacing: 8,
                                      alignment: WrapAlignment.end,
                                      children: List.generate(
                                        controller.selectedServiceName.value.isEmpty ? 1 :controller.selectedServiceName
                                            .split(',')
                                            .length +
                                            1,
                                            (index) => index == (controller.selectedServiceName.value.isEmpty ? 0 :
                                        controller.selectedServiceName
                                            .split(',')
                                            .length)
                                            ? GestureDetector(
                                          onTap: () async {
                                            List<Map<String, dynamic>>?
                                            result =
                                            await Get.to(()=>MultiSelectWidget(
                                                title: 'Select Services',
                                                items: controller
                                                    .getSelectedServiceItems()),

                                            );
                                            if (result != null) {
                                              controller.selectedServiceName(
                                                  result
                                                      .map((e) => e['value']
                                                      .toString())
                                                      .toList()
                                                      .join(","));
                                              controller.selectedService =
                                                  result
                                                      .map((e) =>
                                                      e['id'].toString())
                                                      .toList()
                                                      .join(",");
                                            }
                                          },
                                          child: Chip(
                                            backgroundColor: Colors.grey,
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            label: Text(
                                              'Add +',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        )
                                            : Chip(
                                          backgroundColor: cardStackColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          onDeleted: () {
                                            var name = controller
                                                .selectedServiceName
                                                .split(",")[index];
                                            var arr=controller.selectedServiceName.value.split(",");
                                            arr.remove(name);
                                            controller.selectedServiceName(arr.join(","));

                                            var id = controller.servicesList
                                                .firstWhereOrNull((element) =>
                                            element['value'] == name);
                                            if (id != null) {
                                              arr=controller.selectedService.split(",");
                                              arr.remove(id['id']);
                                              controller.selectedService =arr.join(",");
                                            }
                                          },
                                          label: Text(
                                            controller.selectedServiceName
                                                .split(",")[index],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('Which area do you prefer?',style: TextStyle(
                                        fontSize: 12
                                    ),),
                                    Obx(()=>Wrap(
                                      direction: Axis.horizontal,
                                      spacing: 8,
                                      alignment: WrapAlignment.end,
                                      children: List.generate(
                                        controller.selectedAreaNames.value.isEmpty ? 1 :controller.selectedAreaNames
                                            .split(',')
                                            .length +
                                            1,
                                            (index) => index == (controller.selectedAreaNames.value.isEmpty ? 0 :
                                        controller.selectedAreaNames
                                            .split(',')
                                            .length)
                                            ? GestureDetector(
                                          onTap: () async {
                                            List<Map<String, dynamic>>?
                                            result =
                                            await Get.to(MultiSelectWidget(
                                                title: 'Select Areas',
                                                items: controller
                                                    .getSelectedAreaItems()));
                                            if (result != null) {
                                              controller.selectedAreaNames(
                                                  result
                                                      .map((e) => e['value']
                                                      .toString())
                                                      .toList()
                                                      .join(","));
                                              controller.selectedArea = result
                                                  .map((e) =>
                                                  e['id'].toString())
                                                  .toList()
                                                  .join(",");
                                            }
                                          },
                                          child: Chip(
                                            backgroundColor: Colors.grey,
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            label: Text(
                                              'Add +',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        )
                                            : controller.selectedAreaNames
                                            .split(',')
                                            .length>2 ? const SizedBox.shrink() :Chip(
                                          backgroundColor: cardStackColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          onDeleted: () {
                                            var name = controller
                                                .selectedAreaNames
                                                .split(",")[index];

                                            var arr=controller.selectedAreaNames.value.split(",");
                                            arr.remove(name);
                                            controller.selectedAreaNames(arr.join(","));

                                            var id = controller.areaList
                                                .firstWhereOrNull((element) =>
                                            element['value'] == name);
                                            if (id != null) {
                                              arr=controller.selectedArea.split(",");
                                              arr.remove(id['id']);
                                              controller.selectedArea =arr.join(",");
                                            }
                                          },
                                          label: Text(
                                            controller.selectedAreaNames
                                                .split(",")[index],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),),

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
                                            text: serviceProviderData==null ? "Add" : "Update",
                                            btnColor: primaryColor,
                                            onTap: () {
                                              if (controller.taxDetailsController.text.isEmpty) {
                                                toast("Please Enter Tax Details ");
                                              } else if (controller.bankDetailsController.text.isEmpty) {
                                                toast("Please Enter Bank Details");
                                              } else if (controller.selectedServiceName.isEmpty) {
                                                toast("Please Select Services");
                                              } else if (controller.selectedAreaNames.isEmpty) {
                                                toast("Please Select Areas");
                                              } else if (controller.contractStartController.text.isEmpty) {
                                                toast("Please Enter Contract Start Date");
                                              } else if (controller.contractEndController.text.isEmpty) {
                                                toast("Please Enter contract End Date");
                                              }
                                              else{
                                                var params = {
                                                  "ServiceProviderID":serviceProviderData?.serviceProviderID
                                                      ??
                                                      0,
                                                  "ServiceProviderName": controller
                                                      .servicerProviderNameController.text.trim(),
                                                  "ContactPerson":
                                                  controller.contactNameController.text.trim(),
                                                  "ContactNumber":
                                                  controller.mobileController.text.trim(),
                                                  "ContactMailID":
                                                  controller.emailController.text.trim(),
                                                  "ContactAddress": controller
                                                      .permanentAddressController.text.trim(),
                                                  "TaxDetails":
                                                  controller.taxDetailsController.text.trim(),
                                                  "BankDetails":
                                                  controller.bankDetailsController.text.trim(),
                                                  "ServiceIDs":
                                                  controller.selectedService,
                                                  "AreaIDs":
                                                  controller.selectedArea,
                                                  "ContractStartDate": toSendDateFormat(controller
                                                      .contractStartController.text),
                                                  "ContractEndDate":
                                                  toSendDateFormat(controller.contractEndController.text),
                                                  "IsActive": controller.selectedIsActive.value,
                                                  "CUID":
                                                  controller.box.read(Session.userId),
                                                };
                                                controller
                                                    .insertUpdateServiceProvider(controller.selectedIsActive.value,params);
                                              }


                                            },
                                          ),
                                        ),
                                      ],
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
