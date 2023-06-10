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
import '../../../widgets/custom_loader.dart';
import 'existing_ticket_controller.dart';

class ExistingTicketScreen extends GetView<ExistingTicketController> {
  @override
  final controller = Get.put(ExistingTicketController());

  ExistingTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () {
          Get.focusScope!.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: "New Ticket",
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      children: [
                        CustomEditText(
                            hintText: "Customer Name",
                            readOnly: true,
                            controller: controller.customerNameController),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomEditText(
                          hintText: "Customer Mobile Number",
                          controller: controller.customerMobileNoController,
                          maxLength: 10,
                          readOnly: true,
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
                        Obx(
                              () => CustomDropDown(
                            hintText: "Customer Address",
                            dropDownValue: controller.selectedAddress.value,
                            items: controller.addresses,
                            onSelected: (val) {
                              controller.selectedAddress(val);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        bookingForm(),
                        const SizedBox(height: 64,),
                        CustomButton(text: 'Book', onTap: ()=> controller.bookATicket()),
                        const SizedBox(
                          height: 64,
                        ),
                      ],
                    ),
                ),
              ),
              Obx(() => controller.isLoading.value
                  ? CustomLoader()
                  : const SizedBox.shrink()),
            ],
          ),
        ));
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
            },
          ),
        ),
        const SizedBox(
          height: 12,
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
          height: 12,
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
          height: 12,
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
                lastDate: DateTime(DateTime.now().year + 1, 12, 31)
            );
          },
        ),
        const SizedBox(
          height: 12,
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
          height: 12,
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
          height: 12,
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
                            : const SizedBox.shrink()),
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
                    : const SizedBox.shrink()),
              ],
            )
          ],
        ),
      ],
    );
  }
}
