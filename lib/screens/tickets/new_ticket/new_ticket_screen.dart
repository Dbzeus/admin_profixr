import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/tickets/new_ticket/new_ticket_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../helpers/utils.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_loader.dart';

class NewTicketScreen extends GetView<NewTicketController> {
  final controller = Get.put(NewTicketController());

  NewTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Step> stepList() => [
          Step(
              title: const Text('Personal'),
              content: personalForm(),
              isActive: controller.currentStep.value >= 0,
              state: controller.currentStep.value > 0
                  ? StepState.complete
                  : StepState.indexed),
          Step(
              title: const Text('Address'),
              content: addressForm(),
              isActive: controller.currentStep.value >= 1,
              state: controller.currentStep.value > 1
                  ? StepState.complete
                  : StepState.indexed),
          Step(
              title: const Text('Booking'),
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
          appBar: CustomAppBar(
            title: "New Ticket",
          ),
          body: Stack(
            children: [
              Obx(
                () => Stepper(
                  steps: stepList(),
                  currentStep: controller.currentStep.value,
                  type: StepperType.horizontal,
                  onStepTapped: (index){
                    debugPrint("$index ${controller.successCounter} ${controller.currentStep.value}");
                    if(controller.successCounter>=index){
                      controller.currentStep(index);
                    }
                  },
                  controlsBuilder: (_, __) {
                    return Obx(() => CustomButton(
                          text: controller.currentStep.value == 2
                              ? 'Book'
                              : 'Next',
                          onTap: () {
                            if (controller.currentStep.value == 0) {
                              controller.saveCustomer();
                            } else if (controller.currentStep.value == 1) {
                              controller.saveCustomerAddress();
                            } else {
                              controller.bookATicket();
                            }
                          },
                        ));
                  },
                ),
              ),
              Obx(() => controller.isLoading.value
                  ? CustomLoader()
                  : const SizedBox.shrink())
            ],
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
          maxLength: 10,
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
            controller.dobController.text = await getDate(
                initialDate: DateTime(DateTime.now().year -18, DateTime.now().month, DateTime.now().day),
                firstDate: DateTime(DateTime.now().year -80, 12, 31),
                lastDate: DateTime(DateTime.now().year -18, 12, 31)
            );
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
            hintText: "Door No / Plot No",
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
              controller.getArea();
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
            const Text(
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
        Obx(
          () => CustomDropDown(
            hintText: "Service",
            dropDownValue: controller.selectedService.value,
            items: controller.services,
            onSelected: (val) {
              controller.selectedService(val);
              controller.getComplaintNature();
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
        CustomEditText(
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
            controller.serviceDateController.text = await getDate(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1, 12, 31));
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => CustomDropDown(
            hintText: "Service Time Slot",
            dropDownValue: controller.selectedTimeSlot.value,
            items: controller.timeSlots,
            onSelected: (val) {
              controller.selectedTimeSlot(val);
            },
          ),
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
              child: Obx(
                () => InkWell(
                  onTap: (){
                    if(controller.imagePath.value.isNotEmpty){
                      open(Get.context!, 0, [controller.imagePath.value]);
                    }
                  },
                  child: DottedBorder(
                      color: controller.imagePath.value.isNotEmpty
                          ? primaryColor
                          : Colors.black26,
                      strokeWidth: 1,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
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
                            : const SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                              ),
                      )),
                ),
              ),
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
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
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
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
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
                            const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Text(
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
