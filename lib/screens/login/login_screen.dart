import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/login/login_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../widgets/custom_button.dart';

class LoginScreen extends GetView<LoginController> {
  final controller = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: 80,
            left: 16,
            right: 16,
            bottom: 30
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Amet minim mollit non deserunt ullamcoei sitaliqua dolor do amet sintelit officia.",
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  color: blackColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomEditText(
                  hintText: "Username / Mobile Number",
                  controller: controller.mobNoController),
              const SizedBox(
                height: 30,
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
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(text: "LOGIN", onTap: () {
                Get.toNamed(Routes.Home);
              }),
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 30,
              ),
              const Spacer(),
              Center(
                child: const Text(
                  "Don’t have an account?",
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  btnColor: blackColor,
                  text: "Create an account",
                  onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
