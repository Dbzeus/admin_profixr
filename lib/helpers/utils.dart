import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/image_viewer.dart';

class Session{
  static const isLogin = "isLogin";
  static const userData = "userData";
  static const menuData = "menuData";

  static const userId = "userId";

  static String userMobileNo="userMobileNo";

}

const String dmy="dd-MM-yyyy";
const String ymd="yyyy-MM-dd";
const String mdy="MM-dd-yyyy";

toSendDateFormat(String date,{
  String fromFormat=dmy,
  String toFormat=mdy
}){
  return DateFormat(toFormat).format(DateFormat(fromFormat).parse(date));
}

toShowDateFormat(String date,{
  String fromFormat=ymd,
  String toFormat=dmy
}){
  return toSendDateFormat(date,fromFormat: fromFormat,toFormat: toFormat);
}

dateTimeToString({
  DateTime? dateTime
}){
  return DateFormat("dd-MM-yyyy").format(dateTime ?? DateTime.now());
}

String getLastSegment(String paths){
  return paths.split("/").last;
}

void open(BuildContext context, final int index, var images) {
  Get.to(
    GalleryPhotoView(
      galleryItems: images,
      backgroundDecoration: const BoxDecoration(
        color: Colors.black,
      ),
      initialIndex: index.obs,
    ),
  );
}