import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/technician_response.dart';
import 'package:profixer_admin/screens/technician/technician_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';
import 'package:profixer_admin/widgets/multi_select.dart';

import '../../../helpers/constant_widgets.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_loader.dart';

class AddTechnicianScreen extends StatefulWidget {
  AddTechnicianScreen({Key? key}) : super(key: key);

  @override
  State<AddTechnicianScreen> createState() => _AddTechnicianScreenState();
}

class _AddTechnicianScreenState extends State<AddTechnicianScreen> {
  final controller = Get.find<TechnicianController>();

  TechnicainData? technicianData = Get.arguments["data"];

  @override
  void initState() {
    super.initState();
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
      controller.selectedService = technicianData!.serviceIDs.toString();
      controller.selectedServiceName(technicianData!.serviceName);
      controller.selectedArea = technicianData!.areaIDs.toString();
      controller.selectedAreaNames(technicianData!.areaName.toString());
      controller.currentAddressController.text =
          technicianData!.contactAddress.toString();
      controller.permanentAddressController.text =
          technicianData!.permanentAddress.toString();
      controller.selectedIsActive(technicianData!.isActive);

      controller.getServiceProviders(isAssigned: false, selectedId:technicianData!.serviceProviderID.toString() );
      controller.getServiceProviderService(canClear: false);
      controller.getServiceProviderArea(canClear: false);
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
      controller.selectedServiceName("");
      controller.selectedAreaNames("");
      controller.selectedArea = "";
      controller.selectedService = "";
      controller.getServiceProviders();
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
          title: Get.arguments["title"],
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
                                        firstDate: DateTime(DateTime.now().year -80, 12, 31),
                                        lastDate: DateTime(DateTime.now().year -18, 12, 31)
                                    );
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
                                    if (controller.firstNameController.text.isEmpty) {
                                      toast("Please Enter First Name");
                                    } else if (controller.lastNameController.text.isEmpty) {
                                      toast("Please Enter Last Name");
                                    } else if (controller.mobileController.text.isEmpty) {
                                      toast("Please Enter Mobile Number");
                                    }else if (controller.emailController.text.isEmpty) {
                                      toast("Please Enter Email ID");
                                    }  else if (controller.dobController.text.isEmpty) {
                                      toast("Please Enter Your Date of Birth Address");
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(
                                  () => CustomDropDown(
                                      hintText: "Service Provider",
                                      dropDownValue: controller
                                          .selectedServiceProvider.value,
                                      items: controller.serviceProviderList,
                                      onSelected: (value) {
                                        if(value!=controller.selectedServiceProvider.value) {
                                          controller
                                              .selectedServiceProvider(value);
                                          controller
                                              .getServiceProviderService();
                                          controller.getServiceProviderArea();
                                        }
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
                                                          .getSelectedServiceItems()));
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
                                  hintText: "National ID",
                                  controller: controller.identityController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomEditText(
                                  hintText: "Current Address",
                                  controller:
                                      controller.currentAddressController,
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
                                        text: technicianData == null ? "Add" : "Update",
                                        btnColor: primaryColor,
                                        onTap: () {
                                          if (controller.serviceProviderList.isEmpty) {
                                            toast("Please Select service Provider");
                                          } else if (controller.dojController.text.isEmpty) {
                                            toast("Please Enter Your Date of Joining ");
                                          }else if (controller.selectedServiceName.isEmpty) {
                                            toast("Please Enter Select services ");
                                          }else if (controller.selectedAreaNames.isEmpty) {
                                            toast("Please Select your prefered Area");
                                          }
                                          else if (controller.identityController.text.isEmpty) {
                                            toast("Please Enter National ID");
                                          } else if (controller.currentAddressController.text.isEmpty) {
                                            toast("Please Enter Current Address Number");
                                          }else if (controller.permanentAddressController.text.isEmpty) {
                                            toast("Please Enter Permanent Address");
                                          }  else{
                                            var params = {
                                              "TechnicianID":
                                              technicianData?.technicianID ??
                                                  0,
                                              "UserID":
                                              technicianData?.userID ?? 0,
                                              "ServiceProviderID": controller
                                                  .selectedServiceProvider.value,
                                              "FirstName": controller
                                                  .firstNameController.text
                                                  .trim(),
                                              "LastName": controller
                                                  .lastNameController.text
                                                  .trim(),
                                              "MobileNumber": controller
                                                  .mobileController.text,
                                              "MailID": controller
                                                  .emailController.text
                                                  .trim(),
                                              "ContactAddress": controller
                                                  .currentAddressController.text
                                                  .trim(),
                                              "PermanentAddress": controller
                                                  .permanentAddressController.text
                                                  .trim(),
                                              "DOB": toSendDateFormat(
                                                  controller.dobController.text),
                                              "DOJ": toSendDateFormat(
                                                  controller.dojController.text),
                                              "ServiceIDs":
                                              controller.selectedService,
                                              "AreaIDs": controller.selectedArea,
                                              "Username": controller
                                                  .userNameController.text
                                                  .trim(),
                                              "Password": controller
                                                  .passwordController.text
                                                  .trim(),
                                              "IsActive": controller
                                                  .selectedIsActive.value,
                                              "CUID": controller.box
                                                  .read(Session.userId),
                                            };
                                            controller.insertUpdateTechnician(
                                                controller.selectedIsActive.value,
                                                params,
                                                technicianData != null);
                                          }


                                        },
                                      ),
                                    ),
                                  ],
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
