import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/auth/login/login_controller.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';
import 'package:profixer_admin/widgets/custom_loader.dart';

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
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 52,),
                  GestureDetector(
                    onTap:  (){
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
                        splashRadius: 18,
                        onPressed: () {
                          controller.isVisible(!controller.isVisible.value);
                        },
                        icon: Icon(
                          size: 16,
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
                            controller.logIn();
                  }),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.forgetMobNoController.clear();
                      showCustomBottomSheet();

                    },
                    child: const Text.rich(TextSpan(
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
                  ),
                  /*const Spacer(),
                  CustomButton(text: "Login with mobile number",
                      btnColor: Colors.black,
                      textColor: Colors.white,
                      onTap: () {
                    Get.toNamed(Routes.mobileLogin);
                  }),*/

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

   showCustomBottomSheet() {
     return Get.bottomSheet(
         isScrollControlled: true,
         GestureDetector(
           onTap: () {

             Get.focusScope!.unfocus();
           },
           child: Container(
             height: Get.height * 0.32,
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
             margin: EdgeInsets.only(top: Get.statusBarHeight + 30),
             decoration: const BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8),
                   child: Text(
                       "Forgot Password",
                       style: const TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                       )),
                 ),
//                 const Divider(),
               const SizedBox(
                 height:12,
               ),
                 CustomEditText(
                   controller: controller.forgetMobNoController,
                    keyboardType: TextInputType.number,
                   maxLength: 10,
                   hintText: "Enter Mobile Number",
                 ),
                 const Spacer(),
                 CustomButton(text: "Submit", onTap: (){
                   controller.forgetPassword();
                 }),
                 const SizedBox(
                   height:16,
                 ),
               ],
             ),
           ),
         ));
   }
}
