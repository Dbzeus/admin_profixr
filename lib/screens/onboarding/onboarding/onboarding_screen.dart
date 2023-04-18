
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/onboarding/onboarding/onboarding_controller.dart';
import 'package:profixer_admin/widgets/custom_button.dart';

import '../../../routes/app_routes.dart';

class OnboardingScreen extends GetView<OnboardingController> {

  final controller = Get.put(OnboardingController());
   OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Text.rich(
              TextSpan(
              text: "Welcome to",
              style:  TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: blackColor,
              ),
      children: [
      TextSpan(
        text: "\nProFixer App",
        style:  TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
          color: primaryColor,
      ),)
    ],
              )),
          Column(
            children: [
              CustomButton(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16
                  ),
                  text:  "Login", onTap: (){
                    Get.toNamed(Routes.Login);
              }),
              const SizedBox(
                height: 10,
              ),
              // const Divider(
              //   indent: 25,
              //   endIndent: 25,
              //   thickness: 1,
              //             ),
              const SizedBox(
                height: 10,
              ),
              Text.rich(TextSpan(
                text: "Don’t have an",
                style:  TextStyle(
                  fontSize: 12,

                  color: blackColor,
                ),
                children: [
                  TextSpan(
                    text: " account?",
                    style:  TextStyle(
                      fontSize: 12,

                      color: primaryColor,
                    ),)
                ],
              )),
            ],
          ),

        ],
      ),
    );
  }
}
