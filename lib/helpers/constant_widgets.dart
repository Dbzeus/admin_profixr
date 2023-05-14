

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'custom_colors.dart';

uploadButton(Function onTab) {
  return GestureDetector(
    onTap: ()=>onTab(),
    child: Container(
      height: 43,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: uploadButtonColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.add,color: textColor,size: 16,),
          Text('Upload',style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),)
        ],
      ),

    ),
  );
}

getImageFromGallery() async{
  var res = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 50);
  if (res != null) {
    return res.path;
  }else{
    return null;
  }

}




