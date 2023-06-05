import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/tickets/new_ticket/new_ticket_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../widgets/custom_dropdown.dart';

class NewTicketScreen extends GetView<NewTicketController> {
  final controller = Get.put(NewTicketController());

  NewTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Step> stepList() => [
          Step(
              title: Text('Personal'),
              content: personalForm(),
              isActive: controller.currentStep.value == 0,
              state: controller.currentStep.value > 0
                  ? StepState.complete
                  : StepState.indexed),
          Step(
              title: Text('Address'),
              content: addressForm(),
              isActive: controller.currentStep.value == 1,
              state: controller.currentStep.value > 1
                  ? StepState.complete
                  : StepState.indexed),
          Step(
              title: Text('Booking'),
              content: bookingForm(),
              isActive: controller.currentStep.value == 2,
              state: controller.currentStep.value > 2
                  ? StepState.complete
                  : StepState.indexed)
        ];
    return GestureDetector(
        onTap: () {
          Get.focusScope!.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: "New Ticket",
          ),
          body: Obx(
            () => Stepper(
              steps: stepList(),
              currentStep: controller.currentStep.value,
              type: StepperType.horizontal,
              controlsBuilder: (_, __) {
                return Obx(() => CustomButton(
                      text: controller.currentStep.value == 2 ? 'Book' : 'Next',
                      onTap: () async {
                        if (controller.currentStep.value == 0) {
                          await controller.saveCustomer();
                          controller
                              .currentStep(controller.currentStep.value + 1);
                        } else if (controller.currentStep.value == 1) {
                          await controller.saveCustomerAddress();
                          controller
                              .currentStep(controller.currentStep.value + 1);
                        } else {
                          controller.bookATicket();
                        }
                      },
                    ));
              },
            ),
          ),
        ));
  }

  personalForm() {
    return Column(
      children: [
        CustomEditText(
            hintText: "Customer Name",
            controller: controller.customerNameController),
        const SizedBox(
          height: 10,
        ),
        CustomEditText(
          hintText: "Customer Mobile Number",
          controller: controller.customerMobileNoController,
          keyboardType: TextInputType.phone,
          prefixIcon: Obx(
            () => DropdownButton(
                value: controller.mobileNoDropDownValue.value,
                style: const TextStyle(color: primaryColor, fontSize: 16),
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
                  controller.mobileNoDropDownValue(val.toString());
                }),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        CustomEditText(
            hintText: "Email", controller: controller.emailController),
        const SizedBox(
          height: 12,
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
                lastDate: DateTime(DateTime.now().year + 1, 12, 31));
            if (date != null) {
              debugPrint(date.toString());
              controller.dobController.text =
                  DateFormat(controller.dateFormat).format(date);
            }
          },
        ),
        const SizedBox(
          height: 12,
        ),
        CustomEditText(
            hintText: "Remarks", controller: controller.remarksController),
        const SizedBox(
          height: 64,
        ),
      ],
    );
  }

  addressForm() {
    return Column(
      children: [
        CustomEditText(
            hintText: "Address title",
            controller: controller.customerAddressTitleController),
        const SizedBox(
          height: 10,
        ),
        CustomEditText(
            hintText: "Door No / Plot N0",
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
              () => CustomDropDown(
            hintText: "City",
            dropDownValue: controller.selectedCity.value,
            items: controller.cities,
            onSelected: (val) {
              controller.selectedCity(val);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
              () => CustomDropDown(
            hintText: "Area",
            dropDownValue: controller.selectedArea.value,
            items: controller.areas,
            onSelected: (val) {
              controller.selectedArea(val);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomEditText(
            hintText: "Landmark (Optional)",
            controller: controller.landmarkController),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.gps_fixed,
              color: primaryColor,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              "set my location",
              style: TextStyle(
                color: primaryColor,
                fontSize: 14,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 64,
        ),
      ],
    );
  }

  bookingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              height: 10,
            ),
            Obx(
                  () => CustomDropDown(
                hintText: "Service",
                dropDownValue: controller.selectedService.value,
                items: controller.services,
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
                hintText: "Complaint Nature",
                dropDownValue: controller.selectedCNature.value,
                items: controller.cNatures,
                onSelected: (val) {
                  controller.selectedCNature(val);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
                  () => CustomDropDown(
                hintText: "Service Type",
                dropDownValue: controller.selectedType.value,
                items: controller.types,
                onSelected: (val) {
                  controller.selectedType(val);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: CustomEditText(
                hintText: "Service Date",
                showCursor: false,
                keyboardType: TextInputType.none,
                controller: controller.serviceDateController,
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
                      lastDate: DateTime(DateTime.now().year + 1, 12, 31));
                  if (date != null) {
                    debugPrint(date.toString());
                    controller.serviceDateController.text =
                        DateFormat(controller.dateFormat).format(date);
                  }
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child:
                Obx(
                      () => CustomDropDown(
                    hintText: "Service Time Slot",
                    dropDownValue: controller.selectedArea.value,
                    items: controller.areas,
                    onSelected: (val) {
                      controller.selectedArea(val);
                    },
                  ),
                ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CustomEditText(
            hintText: "Remarks",
            controller: controller.bookingRemarksController),
        const SizedBox(
          height: 24,
        ),
        const Text(
          "Service Image",
          style: TextStyle(color: hintColor, fontSize: 12),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Obx(() => DottedBorder(
                    color: controller.imagePath.value.isNotEmpty
                        ? primaryColor
                        : Colors.black26,
                    strokeWidth: 1,
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          /* border: Border.all(
                                    color: controller.imagePath.value.isNotEmpty
                                        ? primaryColor
                                        : Colors.black26,
                                  ),*/
                          image: DecorationImage(
                              image: controller.imagePath.value.isURL
                                  ? CachedNetworkImage(
                                          imageUrl: controller.imagePath.value)
                                      as ImageProvider
                                  : FileImage(File(controller.imagePath.value)),
                              fit: BoxFit.cover),
                        ),
                        child: controller.imagePath.value.isEmpty
                            ? const Center(child: Text('Upload images'))
                            : const Center(child: Text(''))),
                  )),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        controller.imagePath(await getImageFromGallery() ??
                            controller.imagePath.value);
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.image,
                          size: 15,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () async {
                        controller.imagePath(await getImageCamera() ??
                            controller.imagePath.value);
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.camera_alt,
                          size: 15,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Obx(() => controller.imagePath.isNotEmpty
                    ? InkWell(
                        onTap: () => controller.imagePath(""),
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink())
              ],
            )
          ],
        ),
        const SizedBox(
          height: 64,
        ),
      ],
    );
  }
}
