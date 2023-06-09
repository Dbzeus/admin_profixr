import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/auth/verification/verification_controller.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';
import 'package:profixer_admin/widgets/custom_loader.dart';

import '../../../helpers/custom_colors.dart';

class VerificationScreen extends GetView<VerificationController> {
  VerificationScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 52,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset('assets/icon/back.svg')),
                  ),
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
                  Obx(()=>
                      /*RichText(

                        text: TextSpan(

                            style: TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.bold

                            ),
                            children: [
                              TextSpan(
                                text: 'OTP Code Was sent in to +91 ',

                              ),
                              TextSpan(
                                  text: controller.mobileNo.value,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              TextSpan(
                                text: '  Mobile Number',
                              ),

                            ]
                        ),

                      )*/
                     Text(
                      'OTP Code Was sent in to +91 ${controller.mobileNo.value}  Mobile Number',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      _customOTPField(
                          first: true,
                          last: false,
                          controller: controller.fieldOne),
                      const SizedBox(
                        width: 45,
                      ),
                      _customOTPField(
                          first: false,
                          last: false,
                          controller: controller.fieldTwo),
                      const SizedBox(
                        width: 45,
                      ),
                      _customOTPField(
                          first: false,
                          last: false,
                          controller: controller.fieldThree),
                      const SizedBox(
                        width: 45,
                      ),
                      _customOTPField(
                          first: false,
                          last: false,
                          controller: controller.fieldFour),
                      const SizedBox(
                        width: 40,
                      ),

                    ],
                  ),
                  const Spacer(),
                  CustomButton(
                    text: 'VERIFY',
                    onTap: () {
                     controller.verifyOTP();
                    },
                    btnColor: Colors.black,
                    textColor: Colors.white,
                  )
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
  _customOTPField({bool? first, last, TextEditingController? controller}) {
    return Expanded(
      child: CustomEditText(
        controller: controller,
        hintText: '',
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        showCursor: false,
        /*style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),*/
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            Get.focusScope?.nextFocus();
          }
          if (value.isEmpty && first == false) {
            Get.focusScope?.previousFocus();
          }
        },
      ),
    );
  }
}
