import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/tickets/new_ticket/new_ticket_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';


import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../helpers/custom_dialog.dart';

class NewTicketScreen extends GetView<NewTicketController> {
  final controller = Get.put(NewTicketController());

  NewTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: "New Ticket",
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 16, left: 16, right: 16, bottom: 16),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                        hintText: "Customer Name",
                        controller: controller.customerNameController),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                      hintText: "Customer Address",
                      controller: controller.customerAddressController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                      hintText: "Customer Mobile Number",
                      controller: controller.customerMobileNoController,
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
                              controller.mobileNoDropDownValue(val.toString());
                            }),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                      hintText: "Service Category",
                      controller: controller.serviceCategoryController,
                      suffixIcon: Obx(
                        () => DropdownButton(
                            value: controller.categoryDropDownValue.value,
                            style:
                                const TextStyle(color: blackColor, fontSize: 16),
                            underline: const SizedBox(),
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: blackColor,
                              size: 22,
                            ),
                            items: controller.categoryItems.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (val) {
                              controller.categoryDropDownValue(val.toString());
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                      hintText: "Service Name",
                      controller: controller.serviceNameController,
                      suffixIcon: Obx(
                        () => DropdownButton(
                            value: controller.serviceNameDropDownValue.value,
                            style:
                                const TextStyle(color: blackColor, fontSize: 16),
                            underline: const SizedBox(),
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: blackColor,
                              size: 22,
                            ),
                            items:
                                controller.serviceNameItems.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (val) {
                              controller.serviceNameDropDownValue(val.toString());
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                      hintText: "Service Amount",
                      controller: controller.serviceAmountController,
                      prefixIcon: Obx(
                        () => DropdownButton(
                            value: controller.amountDropDownValue.value,
                            style: const TextStyle(
                                color: primaryColor, fontSize: 16),
                            underline: const SizedBox(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: primaryColor,
                              size: 16,
                            ),
                            items: controller.amountItems.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (val) {
                              controller.amountDropDownValue(val.toString());
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                      hintText: "Service Type",
                      controller: controller.serviceTypeController,
                      suffixIcon: Obx(
                        () => DropdownButton(
                            value: controller.serviceTypeDropDownValue.value,
                            style:
                                const TextStyle(color: blackColor, fontSize: 16),
                            underline: const SizedBox(),
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: blackColor,
                              size: 22,
                            ),
                            items:
                                controller.serviceTypeItems.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (val) {
                              controller.serviceTypeDropDownValue(val.toString());
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                  Row(
                    children: [
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
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime(DateTime.now().year + 1, 12, 31));
                            if (date != null) {
                              debugPrint(date.toString());
                              controller.serviceDateController.text =
                                  DateFormat(controller.dateFormat)
                                      .format(date);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomEditText(
                          hintText: "Service Time Slot",
                          controller: controller.serviceTimeController,
                          showCursor: false,
                          keyboardType: TextInputType.none,
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: blackColor,
                            size: 22,
                          ),
                          onTab: () async {
                            var time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (time != null) {
                              debugPrint(time.toString());
                              controller.serviceTimeController.text =
                                  DateFormat(controller.timeFormat).format(
                                      DateTime(
                                          0, 1, 1, time.hour, time.minute));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Upload Images",
                    style: TextStyle(color: hintColor, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => controller.imagePath.value.isNotEmpty
                      ? Container(
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: FileImage(File(controller.imagePath.value)),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black12,
                                Colors.black54,
                                Colors.black87
                              ],
                            ),
                          ),
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              controller.imagePath("");
                            },
                            child: Icon(Icons.close,color: Colors.white,)),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.remove_red_eye_outlined,size: 14,color: Colors.white,),
                            const SizedBox(width: 4,),
                            Text('Preview',style: TextStyle(color: Colors.white,fontSize: 12),)
                          ],
                        )
                      ],
                    ),
                        )
                      : const SizedBox()),
                  const SizedBox(
                    height: 20,
                  ),
                  uploadButton(() async {
                    controller.imagePath(await getImageFromGallery() ?? controller.imagePath.value);
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  //const Spacer(),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade100,
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: const Offset(0, 2))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          color: blackColor,
                        ),
                        children: [
                      TextSpan(
                        text: "250",
                        style: TextStyle(
                            fontSize: 30,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: " SAR"),
                    ])),
                GestureDetector(
                  onTap: () => customDialog(Get.context, () {
                    Get.back();
                  }),
                  child: Container(
                    height: 55,
                    width: 155,
                    decoration: BoxDecoration(
                      color: blackColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "BOOK",
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_rounded,
                            size: 50,
                            color: whiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
