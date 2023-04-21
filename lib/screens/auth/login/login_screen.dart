import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/auth/login/login_controller.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../widgets/custom_button.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  final controller = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 64,),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Amet minim mollit non deserunt ullamcoei sitaliqua dolor do amet sintelit officia.",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  color: blackColor,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              CustomEditText(
                  hintText: "Username / Mobile Number",
                  controller: controller.mobNoController),
              const SizedBox(
                height: 32,
              ),
              Obx(
                () => CustomEditText(
                  hintText: "Password",
                  controller: controller.passwordController,
                  obscureText: controller.isVisible.value,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      controller.isVisible(!controller.isVisible.value);
                    },
                    icon: Icon(
                      size: 22,
                      controller.isVisible.value
                          ? Icons.remove_red_eye_rounded
                          : Icons.remove_red_eye_outlined,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 56,
              ),
              CustomButton(text: "LOGIN", onTap: () {
                Get.toNamed(Routes.main);
              }),
              const SizedBox(
                height: 24,
              ),
              Text.rich(TextSpan(
                text: "Forgot password?",
                style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                ),
                children: [
                  TextSpan(
                    text: "  Reset here",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  )
                ],
              )),
              const Spacer(),
              CustomButton(text: "Login with mobile number",
                  btnColor: Colors.black,
                  textColor: Colors.white,
                  onTap: () {
                Get.toNamed(Routes.mobileLogin);
              }),

            ],
          ),
        ),
      ),
    );
  }
}
