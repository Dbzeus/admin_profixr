import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../widgets/custom_button.dart';
import 'mobile_login_controller.dart';

class MobileLoginScreen extends GetView<MobileLoginController> {
  @override
  final controller = Get.put(MobileLoginController());

  MobileLoginScreen({Key? key}) : super(key: key);

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
              const SizedBox(
                height: 52,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset('assets/icon/back.svg')),
              const SizedBox(
                height: 32,
              ),
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
                "Fill the Details to Login a Account",
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
                  hintText: "Mobile Number",
                  controller: controller.mobNoController),

              const Spacer(),

              CustomButton(
                  text: "Get OTP",
                  btnColor: Colors.black,
                  textColor: Colors.white,
                  onTap: () {
                    Get.toNamed(Routes.verification);
                  }),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
