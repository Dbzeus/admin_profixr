import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/userResponse.dart';
import 'package:profixer_admin/routes/app_routes.dart';

import '../../../helpers/constant_widgets.dart';

class LoginController extends GetxController {
  TextEditingController mobNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgetMobNoController = TextEditingController();

  RxBool isVisible = true.obs;

  RxBool isLoading = false.obs;

  final _box = GetStorage();
  // String token="";

  // @override
  // void onInit() async {
  //   super.onInit();
  //   token = await FirebaseMessaging.instance.getToken() ?? '';
  //   debugPrint("token $token");
  // }

  logIn() async {
    if (mobNoController.text.isEmpty) {
      toast("Enter Username or Mobile Number");
    } else if (passwordController.text.isEmpty) {
      toast("Enter your Password");
    } else {
      Get.focusScope?.unfocus();
      if (await isNetConnected()) {
        await notificationPermission();
        isLoading(true);
        UserDataResponse? loginResponse = await ApiCall().checkLogin(
            mobNoController.text, passwordController.text, await FirebaseMessaging.instance.getToken() ?? "", "");
        isLoading(false);
        debugPrint("1");
        if (loginResponse != null) {
          debugPrint("2");
          if (loginResponse.rtnStatus) {
            debugPrint("3");
            toast(loginResponse.rtnMsg);
            storeSessions(loginResponse.rtnData!);
            Get.offAllNamed(
              Routes.main,
            );
          } else {

            toast(loginResponse.rtnMsg);
          }
        }else{
          debugPrint("5");
        }
        debugPrint("6");
      }
    }
  }

  storeSessions(UserData data) {
    _box.write(Session.isLogin, true);
    _box.write(Session.userId, data.userID);
    _box.write(Session.userMobileNo, data.mobileNo);
    _box.write(Session.userData, data.toJson());
  }

  forgetPassword() async {
    if (forgetMobNoController.text.isEmpty) {
      toast("Please Enter Mobile Number");
    } else {
      Get.back();
      isLoading(true);
      Get.focusScope?.unfocus();
      if (await isNetConnected()) {
        var forgetPasswordResponse =
            await ApiCall().forgetPassword(forgetMobNoController.text);
        isLoading(false);
        if (forgetPasswordResponse != null) {
          if (forgetPasswordResponse["RtnStatus"]) {
            toast(forgetPasswordResponse["RtnMsg"]);
          } else {
            toast(forgetPasswordResponse["RtnMsg"]);
          }
        }
      }
    }
  }
}



