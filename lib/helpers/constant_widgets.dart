

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'custom_colors.dart';

uploadButton() {
  return GestureDetector(
    onTap: () async {
     /* var res = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (res != null) {
        File imageFile = File(res.path); //convert Path to File
        String imagePath = base64Encode(
            imageFile.readAsBytesSync()); //convert bytes to base64 string
        debugPrint(imagePath.toString());
      }*/
    },
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


