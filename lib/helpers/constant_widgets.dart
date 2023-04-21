import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_colors.dart';

uploadButton() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 43,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: uploadButtonColor,
      ),
      child: const Center(
        child: Text.rich(TextSpan(
          text: "+",
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
          children: [
            TextSpan(
              text: "  Upload",
              style: TextStyle(
                fontSize: 14,
                //fontWeight: FontWeight.w600,
                color: uploadTextColor,
              ),
            )
          ],
        )),
      ),
    ),
  );
}


