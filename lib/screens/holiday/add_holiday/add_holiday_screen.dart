import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';
import 'package:profixer_admin/widgets/custom_loader.dart';

import '../../../helpers/utils.dart';
import '../../../widgets/custom_dropdown.dart';
import '../holiday_controller.dart';

class AddHolidayScreen extends StatelessWidget {
  final controller = Get.find<HolidayController>();

  AddHolidayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int holidayId = 0;

    if (Get.arguments['holiday'] != null) {
      holidayId = Get.arguments['holiday']['ServiceID'];

      controller.reasonController.text = Get.arguments['holiday']['Reason'];
      controller.remarkController.text = Get.arguments['holiday']['Remarks'];
      controller.dateController.text = toShowDateFormat(Get.arguments['holiday']['HolidayDate']);
      controller.isFullDay(Get.arguments['holiday']['IsFullDay']);
    } else {
      controller.reasonController.clear();
      controller.remarkController.clear();
      controller.dateController.clear();
      controller.isFullDay(true);
    }

    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(title: Get.arguments['title']),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  CustomEditText(
                      hintText: "Reason",
                      controller: controller.reasonController),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomEditText(
                    hintText: "Date",
                    showCursor: false,
                    keyboardType: TextInputType.none,
                    controller: controller.dateController,
                    suffixIcon: const Icon(
                      Icons.calendar_month_rounded,
                      color: blackColor,
                      size: 22,
                    ),
                    onTab: () async {
                      controller.dateController.text = await getDate();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Row(
                      children: [
                        const Expanded(child: Text('Full day?')),
                        InkWell(
                          onTap: () {
                            if (controller.isFullDay.value == false) {
                              controller.isFullDay(!controller.isFullDay.value);
                            }
                          },
                          child: AnimatedContainer(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: controller.isFullDay.value
                                  ? greenColor
                                  : Colors.grey.shade100,
                            ),
                            duration: Duration(milliseconds: 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.done_rounded,
                                  size: 16,
                                  color: controller.isFullDay.value
                                      ? Colors.green
                                      : Colors.black54,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: controller.isFullDay.value
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
                            if (controller.isFullDay.value == true) {
                              controller.isFullDay(!controller.isFullDay.value);
                            }
                          },
                          child: AnimatedContainer(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: !controller.isFullDay.value
                                  ? Colors.red.shade100
                                  : Colors.grey.shade100,
                            ),
                            duration: Duration(milliseconds: 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.close,
                                  size: 16,
                                  color: !controller.isFullDay.value
                                      ? Colors.red
                                      : Colors.black54,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'No',
                                  style: TextStyle(
                                    color: !controller.isFullDay.value
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
                  const SizedBox(
                    height: 10,
                  ),

                  Obx(
                        () => controller.isFullDay.value ? const SizedBox.shrink() : CustomDropDown(
                      hintText: "Time Slot",
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
                  // CustomEditText(
                  //   hintText: "Time From",
                  //   controller: controller.fromTimeController,
                  //   showCursor: false,
                  //   keyboardType: TextInputType.none,
                  //   suffixIcon: const Icon(
                  //     Icons.access_time_outlined,
                  //     color: blackColor,
                  //     size: 22,
                  //   ),
                  //   onTab: () async {
                  //     controller.fromTimeController.text = await getTime();
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // CustomEditText(
                  //   hintText: "Time To",
                  //   controller: controller.toTimeController,
                  //   showCursor: false,
                  //   keyboardType: TextInputType.none,
                  //   suffixIcon: const Icon(
                  //     Icons.access_time_outlined,
                  //     color: blackColor,
                  //     size: 22,
                  //   ),
                  //   onTab: () async {
                  //     controller.toTimeController.text = await getTime();
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  CustomEditText(
                      hintText: "Remarks",
                      maxLines: 4,
                      controller: controller.remarkController),
                  const SizedBox(
                    height: 10,
                  ),
                  const Spacer(),
                  CustomButton(
                      text: Get.arguments['buttonTitle'],
                      onTap: () {
                        var data = {
                          "HolidayID": holidayId,
                          "HolidayDate": toSendDateFormat(controller.dateController.text),
                          "Reason": controller.reasonController.text,
                          "IsFullDay": controller.isFullDay.value,
                          "TimeFrom": controller.isFullDay.value ? "" : "",
                          "TimeTo":controller.isFullDay.value ? "" : "",
                          "Remarks": controller.remarkController.text,
                          "CUID": controller.box.read(Session.userId)
                        };

                        controller.createHoliday(
                            data, Get.arguments['holiday'] != null);
                      }),
                ],
              ),
            ),
          ),
          Obx(() => controller.isLoading.value
              ? CustomLoader()
              : const SizedBox.shrink())
        ],
      ),
    );
  }
}
