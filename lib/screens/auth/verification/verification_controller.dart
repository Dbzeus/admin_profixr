import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/userResponse.dart';
import 'package:profixer_admin/routes/app_routes.dart';

class VerificationController extends GetxController {
  TextEditingController fieldOne = TextEditingController();
  TextEditingController fieldTwo = TextEditingController();
  TextEditingController fieldThree = TextEditingController();
  TextEditingController fieldFour = TextEditingController();

  RxString mobileNo = "".obs;
  String otp = "";

  int enteredOtp = 0;

  RxBool isLoading = false.obs;

  final _box= GetStorage();

  @override
  void onInit() {
    mobileNo ( Get.arguments["mobileNo"]);
    otp = Get.arguments["otp"];
    super.onInit();
  }

  verifyOTP() async {
    enteredOtp = int.parse(
        fieldOne.text + fieldTwo.text + fieldThree.text + fieldFour.text);

    debugPrint(enteredOtp.toString());

    if (otp.length < 4) {
      toast("Enter OTP");
    } else {
      Get.focusScope?.unfocus();
      if (enteredOtp.isEqual(int.parse(otp))) {
        if (await isNetConnected()) {
          isLoading(true);
          UserDataResponse? loginResponse =
          await ApiCall().loginDetailsByMobile(mobileNo.value, "", "");
          if (loginResponse != null) {
            if (loginResponse.rtnStatus) {
              toast(loginResponse.rtnMsg);
              storeSessions(loginResponse.rtnData!);
              Get.offAllNamed(Routes.main);
            } else {
              toast(loginResponse.rtnMsg);
            }
          }
          isLoading(false);
        }
      } else {
        toast("Please Enter correct OTP");
      }
    }
  }

  storeSessions(UserData data){
    _box.write(Session.isLogin, true);
    _box.write(Session.userId, data.userID);
    _box.write(Session.userMobileNo, data.mobileNo);
    _box.write(Session.userData, data.toJson());
  }

}

