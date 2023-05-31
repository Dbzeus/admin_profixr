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

import 'package:profixer_admin/widgets/custom_edittext.dart';

class NewTicketScreen extends GetView<NewTicketController> {
  final controller = Get.put(NewTicketController());

  NewTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Step> stepList() => [
          Step(
            title: Text('Personal'),
            content: personalForm(),
          ),
          Step(title: Text('Address'), content: addressForm()),
          Step(
              title: Text('Booking'),
              content: bookingForm())
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
          body: Obx(()=>
             Stepper(
               onStepContinue: (){

               },
               onStepCancel: (){},
              steps: stepList(),
              currentStep: controller.currentStep.value,
              type: StepperType.horizontal,
              onStepTapped: (step){
                controller.currentStep(step);
              },

              /*child: Column(
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
                      onTap: () =>Get.back(),
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
      ),*/
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
          height: 10,
        ),
        CustomEditText(
            hintText: "Email", controller: controller.emailController),
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
          height: 10,
        ),
        CustomEditText(
            hintText: "Remarks", controller: controller.remarksController),
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
        CustomEditText(
          hintText: "City",
          controller: controller.cityNameController,
          suffixIcon: Obx(
            () => DropdownButton(
                value: controller.cityDropDownValue.value,
                style: const TextStyle(color: blackColor, fontSize: 16),
                underline: const SizedBox(),
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: blackColor,
                  size: 22,
                ),
                items: controller.cityDropDownItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (val) {
                  controller.cityDropDownValue(val.toString());
                }),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomEditText(
            hintText: "Landmark (Optional)",
            controller: controller.remarksController),
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
              "set My Location",
              style: TextStyle(
                color: primaryColor,
                fontSize: 14,
              ),
            )
          ],
        )
      ],
    );
  }

  bookingForm(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      context: Get.context!,
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
                      context: Get.context!, initialTime: TimeOfDay.now());
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
        CustomEditText(
            hintText: "Remarks", controller: controller.bookingRemarksController),

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
                              imageUrl: controller.imagePath
                                  .value) as ImageProvider
                              : FileImage(
                              File(controller.imagePath.value)),
                          fit: BoxFit.cover),
                    ),
                    child: controller.imagePath.value.isEmpty
                        ? const Center(child: Text('Upload images'))
                        :const Center(child: Text(''))
                ),
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
                        controller.imagePath(
                            await getImageFromGallery() ??
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
                const SizedBox(
                    height: 6
                ),
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
      ],
    );

  }
}
