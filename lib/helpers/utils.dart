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
      initialIndex: index.obs
    ),
  );
}



/*class CustomClipperImage extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height); // for bottom bar left side height

    path.lineTo(size.width, size.height); // for bottom bar right side height
    path.lineTo(size.width,0.0); // for right side clip bottombar clip
    //path.lineTo(2*size.width/3, 0.0);
    path.lineTo(1.2* size.width/3, 0.0);
    var firstEnd = Offset(size.width / 2, size.height/2);
    path.arcToPoint(Offset(size.width/3, 0),radius:Radius.circular(8));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}*/
