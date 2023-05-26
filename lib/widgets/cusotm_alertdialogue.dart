import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_button.dart';

class CustomAlertDialogue extends StatelessWidget {
  CustomAlertDialogue({required this.onTab, Key? key}) : super(key: key);
  Function() onTab;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          Text(
            "Added Succesfull!",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          Text(
            "Work with profixer and earn more",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: textColor),
          ),
          CustomButton(text: "OK", onTap: onTab)
        ],
      ),
    );
  }
}
