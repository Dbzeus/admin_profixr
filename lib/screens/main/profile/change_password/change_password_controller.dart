import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';

import '../../../../helpers/constant_widgets.dart';
import '../../../../helpers/utils.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isLoading=false.obs;
  final _box = GetStorage();

  changePassword() async {
    var oldPassword = oldPasswordController.text.trim();
    var newPassword = newPasswordController.text.trim();
    var confirmPassword = confirmPasswordController.text.trim();

    if (oldPassword.isEmpty) {
      toast('Enter Old Password');
    } else if (newPassword.isEmpty) {
      toast('Enter New Password');
    } else if (confirmPassword.isEmpty) {
      toast('Enter New Password');
    } else if (newPassword != confirmPassword) {
      toast('Password didn\'t match');
    } else {
      if (await isNetConnected()) {
        isLoading(true);
        var response = await ApiCall().resetPassword(
            _box.read(Session.userMobileNo), oldPassword, newPassword);
        if (response != null) {
          if (response['RtnStatus']) {
            oldPasswordController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
          }
          toast(response['RtnMsg']);
        }
        isLoading(false);
      }
    }
  }
}
