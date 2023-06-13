import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:profixer_admin/helpers/custom_dialog.dart';

import 'custom_colors.dart';

getDate(
    {DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String dateFormat = "dd-MM-yyyy"}) async {
  var date = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 1));
  return date == null ? "" : DateFormat(dateFormat).format(date);
}

getTime({TimeOfDay? initialTime, String timeFormat = "HH:mm"}) async {
  var time = await showTimePicker(
      context: Get.context!, initialTime: initialTime ?? TimeOfDay.now());
  return time == null
      ? ""
      : DateFormat(timeFormat)
          .format(DateTime(0, 1, 1, time.hour, time.minute));
}

/*
uploadButton(Function onTab) {
  return GestureDetector(
    onTap: () => onTab(),
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
          Icon(
            Icons.add,
            color: textColor,
            size: 16,
          ),
          Text(
            'Upload',
            style: TextStyle(
              fontSize: 14,
              color: textColor,
            ),
          )
        ],
      ),
    ),
  );
}
*/

getImageCamera() async {
  var res = await ImagePicker()
      .pickImage(source: ImageSource.camera, imageQuality: 50);
  if (res != null) {
    return res.path;
  } else {
    return null;
  }
}

getImageFromGallery() async {
  var res = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 50);
  if (res != null) {
    return res.path;
  } else {
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
      textColor: whiteColor);
}

notificationPermission() async {
  var status = await Permission.notification.request();
  if (status == PermissionStatus.granted) {
    // Permission granted
  } else if (status == PermissionStatus.denied ||
      status == PermissionStatus.restricted) {
    // Permission denied or restricted, show an explanation
    customDialog(Get!.context, 'Notification Permission',
        'Please enable notification access in app settings.', () {},
        btnText: "OK");
    /* showCustomAlertDialog(title: 'Notification Permission',
      content: 'Please enable notification access in app settings.',
      confirm: "OK",
      onTabConfirm: ()=> Get.back(),
    );*/
  } else if (status == PermissionStatus.permanentlyDenied) {
    // Permission permanently denied, open app settings

    customDialog(
      Get!.context,
      'Notification Permission',
      'Please enable notification access in app settings.',
      () {
        openAppSettings();
      },
      btnText: "Settings",
    );
    /* showCustomAlertDialog(
        title: 'Notification Permission',
        content: 'Please enable notification access in app settings.',
        confirm: "Settings",
        onTabConfirm: () => openAppSettings(),
        isDismissable: false);*/
  }
}
