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

class AddHolidayScreen extends StatefulWidget {

  AddHolidayScreen({Key? key}) : super(key: key);

  @override
  State<AddHolidayScreen> createState() => _AddHolidayScreenState();
}

class _AddHolidayScreenState extends State<AddHolidayScreen> {
  final controller = Get.find<HolidayController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.arguments['holiday'] != null) {
      controller.holidayId = Get.arguments['holiday']['HolidayID'];
      controller.reasonController.text = Get.arguments['holiday']['Reason'];
      controller.remarkController.text = Get.arguments['holiday']['Remarks'];
      controller.dateController.text = toShowDateFormat(Get.arguments['holiday']['HolidayDate']);
      controller.isFullDay(Get.arguments['holiday']['TimeSlot'].toString().toLowerCase().contains("full day"));
      controller.getTimeSlots(Get.arguments['holiday']['TimeSlotID']);
    } else {
      controller.reasonController.clear();
      controller.remarkController.clear();
      controller.dateController.clear();
      controller.isFullDay(true);
      controller.getTimeSlots(null);
    }
  }

  @override
  Widget build(BuildContext context) {

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
                        () =>CustomDropDown(
                      hintText: "Time Slot",
                      dropDownValue: controller.selectedTimeSlot.value,
                      items: controller.timeSlots,
                      onSelected: (val) {
                        controller.selectedTimeSlot(val);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
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
                      text: Get.arguments['holiday'] == null ? "Add" : "Update",
                      onTap: () {
                        controller.vaildation(Get.arguments['holiday'] != null);
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
