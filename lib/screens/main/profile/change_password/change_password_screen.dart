
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/main/profile/change_password/change_password_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
   @override
  final controller = Get.put(ChangePasswordController());

   ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Get.focusScope!.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
              title: "Change Password"
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomEditText(
                    hintText: "Old Password",
                    controller: controller.oldPasswordController),
                const SizedBox(
                  height: 10,
                ),
                CustomEditText(
                    hintText: "New Password",
                    controller: controller.newPasswordController),
                const SizedBox(
                  height: 10,
                ),
                CustomEditText(
                    hintText: "Confirm New Password",
                    controller: controller.confirmNewPasswordController,
                  obscureText: true,
                ),
                const Spacer(),
                CustomButton(
                  text: "Save",
                  btnColor: primaryColor,
                  onTap: (){

                  },
                ),
              ],
            ),
          ),
        ));
  }
}
