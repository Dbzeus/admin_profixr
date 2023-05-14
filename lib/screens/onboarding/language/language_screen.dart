import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';

import '../../../routes/app_routes.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              'Choose Your',
              style: TextStyle(
                  color: blackColor, fontWeight: FontWeight.w800, fontSize: 20),
            ),
            const Text(
              'Language',
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'By Selecting this, all the menu’s, Text will be Changed in your preferred language',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 64,
            ),
            _buildLanguageButton('English',"assets/icon/language/english.svg",),
            const SizedBox(
              height: 16,
            ),
            _buildLanguageButton('Arabic',"assets/icon/language/arabic.svg",),
          ],
        ),
      ),
    );
  }

  _buildLanguageButton(String title, String icon) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.loginSelection);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2))
            ]),
        child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icon,
                width: 13,
                  height: 13,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
          title,
          style: const TextStyle(color: primaryColor, fontSize: 15,),
        ),
              ],
            )),
      ),
    );
  }
}
