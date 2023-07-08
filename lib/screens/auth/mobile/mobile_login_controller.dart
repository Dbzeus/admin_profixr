import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/routes/app_routes.dart';

import '../../../helpers/constant_widgets.dart';

class MobileLoginController extends GetxController {
  TextEditingController mobNoController = TextEditingController();

  RxBool isVisible = true.obs;
  RxBool isLoading = false.obs;
  RxString dropDownValue ="".obs;
  var items = [
    '+968',
  ];

  @override
  void onInit(){
    super.onInit();
    dropDownValue(items.first);
  }

  sendOTP() async {

    if (mobNoController.text.isEmpty) {
      toast("Enter Your Mobile Number");
    } else {
      isLoading(true);
      Get.focusScope?.unfocus();
      if (await isNetConnected()) {
        var otpResponse = await ApiCall().sendOTP(mobNoController.text, " ", 0);
        isLoading(false);
        if (otpResponse != null) {
          if (otpResponse["RtnStatus"]) {
            toast(otpResponse["RtnMsg"]);
            Get.toNamed(Routes.verification,arguments: {
              "mobileNo" : mobNoController.text,
              "otp" : otpResponse["OtherMsg"],
            });
          }
        }
      }
    }
  }
}
