
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/custom_button.dart';
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

var connectivity = Connectivity();
isNetConnected() async {
  var result = await connectivity.checkConnectivity();
  bool res = result != ConnectivityResult.none;
  if (!res) {
    toast(
      "Check Your Internet Connection",
    );
  }
  return res;
}


toast(String? msg) {
  debugPrint(msg ?? "Something went wrong");
  Fluttertoast.showToast(
    // backgroundColor: primaryColor,
    msg: (msg?.isEmpty ?? true) ? "Something went wrong" : msg!,
    textColor: whiteColor
  );
}



customAlertDialogue({onTab}){
  Function() onTab = (){};
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

