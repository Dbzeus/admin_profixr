import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/auth/verification/verification_controller.dart';
import 'package:profixer_admin/widgets/custom_button.dart';

import '../../../helpers/custom_colors.dart';

class VerificationScreen extends GetView<VerificationController> {
  VerificationScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
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
              SvgPicture.asset(
                'assets/icon/verification.svg',
                width: 180,
                height: 180,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Enter the Verification Code",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'OTP Code Was sent in to +966 12******257 Mobile Number',
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                text: 'VERIFY',
                onTap: () {
                  Get.toNamed(Routes.main);
                },
                btnColor: Colors.black,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
