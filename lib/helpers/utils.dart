import 'package:intl/intl.dart';

class Session{
  static const isLogin = "isLogin";
  static const userData = "userData";
  static const menuData = "menuData";

  static const userId = "userId";

  static String userMobileNo="userMobileNo";

}

toSendDateFormat(String date){
  return DateFormat("MM-dd-yyyy").format(DateFormat("dd-MM-yyyy").parse(date));
}

toShowDateFormat(String date){
  return DateFormat("dd-MM-yyyy").format(DateFormat("yyyy-MM-dd").parse(date));
}

dateTimeToString({
  DateTime? dateTime
}){
  return DateFormat("dd-MM-yyyy").format(dateTime ?? DateTime.now());
}

String getLastSegment(String paths){
  return paths.split("/").last;
}