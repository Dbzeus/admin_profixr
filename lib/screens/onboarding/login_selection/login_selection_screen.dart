import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/widgets/custom_button.dart';

class LoginSelectionScreen extends StatelessWidget {
  const LoginSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/animation.gif",
            fit: BoxFit.cover
            ),
            const SizedBox(
              height: 20,
            ),

            const Text(
                "Welcome to",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            const SizedBox(
              height: 4,
            ),
            const Text(
                "ProFixer",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600, color: primaryColor)),

            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness:1,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                text: "LOGIN",
                onTap: () {
                  Get.toNamed(Routes.login);
                }),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                text: "Login with mobile number",

                onTap: () {
                  Get.toNamed(Routes.mobileLogin);
                }),
          ],
        ),
      ),
    );
  }
}
