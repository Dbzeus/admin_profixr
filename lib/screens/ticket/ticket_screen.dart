import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/screens/ticket/ticket_controller.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';
import 'package:intl/intl.dart';

import '../../helpers/custom_colors.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';

class TicketScreen extends GetView<TicketController> {
  final controller = Get.put(TicketController());

  TicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        widget: const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              "New Ticket",
              style: TextStyle(
                  color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding:
        const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
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
                    () =>
                    DropdownButton(
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
                    () =>
                    DropdownButton(
                        value: controller.categoryDropDownValue.value,
                        style: const TextStyle(color: blackColor, fontSize: 16),
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
                    () =>
                    DropdownButton(
                        value: controller.serviceNameDropDownValue.value,
                        style: const TextStyle(color: blackColor, fontSize: 16),
                        underline: const SizedBox(),
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: blackColor,
                          size: 22,
                        ),
                        items: controller.serviceNameItems.map((String items) {
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
                    () =>
                    DropdownButton(
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
                    () =>
                    DropdownButton(
                        value: controller.serviceTypeDropDownValue.value,
                        style: const TextStyle(color: blackColor, fontSize: 16),
                        underline: const SizedBox(),
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: blackColor,
                          size: 22,
                        ),
                        items: controller.serviceTypeItems.map((String items) {
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
            CustomEditText(
              hintText: "Service Date",
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
                    lastDate: DateTime(DateTime
                        .now()
                        .year + 1, 12, 31));
                if (date != null) {
                  debugPrint(date.toString());
                   controller.serviceDateController.text =

            DateFormat(controller.dateFormat)
                .format(date);
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomEditText(
              hintText: "Service Time Slot",
              controller: controller.serviceTimeController,
              keyboardType: TextInputType.none,
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: blackColor,
                size: 22,
              ),
              onTab: () async {
                var time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now());
                if (time != null) {
                  debugPrint(time.toString());
                   controller.serviceTimeController.text =

                      DateFormat(controller.timeFormat).format(
                      DateTime(
                          0, 1, 1, time.hour, time.minute));
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),

            //const Spacer(),
            CustomButton(
                text: "Create",
                onTap: () {
                  //Get.toNamed(Routes.addCategory);
                })
          ],
        ),
      ),
    );
  }
}
