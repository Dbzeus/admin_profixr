import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../apis/api_call.dart';
import '../../helpers/constant_widgets.dart';
import '../../helpers/custom_dialog.dart';

class HolidayController extends GetxController{
  RxList holidays = RxList();
  RxBool isLoading = false.obs;

  TextEditingController searchController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();

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
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  createHoliday(data,bool isUpdated) async {
    if (await isNetConnected()) {
      isLoading(true);

      debugPrint(data.toString());
      var response = await ApiCall().insertHoliday(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          customDialog(
              Get.context, isUpdated ? "Updated Successful!": "Added Successful!", "${response['RtnMsg']}", () {
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
      customDialog(
          Get.context, "Delete?", "Are you sure to delete holiday", () async{
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

}