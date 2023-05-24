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

  logIn() async {
    if (mobNoController.text.isEmpty) {
      toast("Enter Username or Mobile Number");
    } else if (passwordController.text.isEmpty) {
      toast("Enter your Password");
    } else {
      isLoading(true);
      Get.focusScope?.unfocus();
      if (await isNetConnected()) {
        UserDataResponse? loginResponse = await ApiCall().checkLogin(
            mobNoController.text, passwordController.text, " ", " ");
        isLoading(false);
        if (loginResponse != null) {
          if (loginResponse.rtnStatus) {
            toast(loginResponse.rtnMsg);
            _box.write(Session.isLogin, true);
            _box.write(Session.userData, loginResponse.rtnData.toJson());
            Get.offAllNamed(Routes.main,);
          } else {
            toast(loginResponse.rtnMsg);
          }
        }
      }
    }
  }

  forgetPassword() async {
    if (forgetMobNoController.text.isEmpty) {
      toast("Please Enter Mobile Number");
    } else {
      Get.back();
      isLoading(true);
      Get.focusScope?.unfocus();
      if (await isNetConnected()) {
        var forgetPasswordResponse = await ApiCall().forgetPassword(forgetMobNoController.text);
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
