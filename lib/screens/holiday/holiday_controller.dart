import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../apis/api_call.dart';
import '../../helpers/constant_widgets.dart';
import '../../helpers/custom_dialog.dart';
import '../../helpers/utils.dart';

class HolidayController extends GetxController {
  RxList holidays = RxList();
  RxList searchList = RxList();
  RxBool isLoading = false.obs;

  int holidayId = 0;

  TextEditingController searchController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  RxList<Map<String, String>> timeSlots = RxList();
  RxString selectedTimeSlot = "".obs;

  RxBool isFullDay = true.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getHoliday();
  }

  getHoliday() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getHoliday();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          holidays(response['RtnData']);
          searchList(response['RtnData']);
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getTimeSlots(int? timeSlotId) async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getTimeSlot();
      isLoading(false);
      if (response != null) {
        timeSlots.clear();
        if (response['RtnStatus']) {
          for (var e in response['RtnData']) {
            timeSlots
                .add({"id": '${e["TimeSlotID"]}', "value": "${e['TimeSlot']}"});
          }
          if (timeSlots.isNotEmpty) {
            if(timeSlotId!=null){
              selectedTimeSlot('$timeSlotId');
            }else {
              selectedTimeSlot('${timeSlots.first['id']}');
            }
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  vaildation(bool isUpdated) {

    if (reasonController.text.isEmpty) {
      toast("Please Enter Reason");
    } else if (dateController.text.isEmpty) {
      toast("Please Enter Date");
    } else if (selectedTimeSlot.isEmpty) {
      toast("Please Enter TimeSlot");
    } else if (remarkController.text.isEmpty) {
      toast("Please Enter Remarks");
    } else {
      var data = {
        "HolidayID": holidayId,
        "HolidayDate": toSendDateFormat(dateController.text),
        "Reason": reasonController.text,
        "TimeSlotID": selectedTimeSlot.value,
        "Remarks": remarkController.text,
        "CUID": box.read(Session.userId)
      };

      createHoliday(data, isUpdated);
    }
  }

  createHoliday(data, bool isUpdated) async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().insertHoliday(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          customDialog(
              Get.context,
              isUpdated ? "Updated Successful!" : "Added Successful!",
              "${response['RtnMsg']}", () {
            Get.back();
            getHoliday();
          }, isDismissable: false);
        } else {
          toast('${response['RtnMsg']}');
        }
      }
    }
  }

  deleteHoliday(data) async {
    if (await isNetConnected()) {
      customDialog(Get.context, "Delete?", "Are you sure to delete holiday",
          () async {
        isLoading(true);

        var response = await ApiCall().deleteHoliday(data['HolidayID']);
        isLoading(false);
        if (response != null) {
          if (response['RtnStatus']) {
            holidays.remove(data);
            holidays.refresh();
          }
          toast(response['RtnMsg']);
        }
      }, btnText: "Yes");
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      holidays(searchList);
    } else {
      holidays(searchList
          .where((element) =>
              element["Reason"]
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element["Remarks"]
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element["HolidayDate"]
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()))
          .toList());
    }
  }
}
