import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';
import 'package:profixer_admin/widgets/custom_loader.dart';

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
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 52,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset('assets/icon/back.svg')),
                  ),
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
                      keyboardType: TextInputType.number,
                      prefixIcon: Obx(
                        () => DropdownButton(
                            value: controller.dropDownValue.value,
                            style: const TextStyle(
                                color: primaryColor, fontSize: 16),
                            underline: const SizedBox(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: primaryColor,
                              size: 16,
                            ),
                            items: controller.items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (val) {
                              controller.dropDownValue(val.toString());
                            }),
                      ),
                      controller: controller.mobNoController),
                  const Spacer(),
                  CustomButton(
                      text: "Get OTP",
                      btnColor: Colors.black,
                      textColor: Colors.white,
                      onTap: () {
                        controller.sendOTP();
                      }),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.isLoading.value
                  ? CustomLoader()
                  : const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
