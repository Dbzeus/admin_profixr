import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../apis/api_call.dart';
import '../../helpers/constant_widgets.dart';
import '../../helpers/utils.dart';
import '../../model/MenuResponse.dart';
import '../../model/userResponse.dart';

class MainController extends GetxController {

  final _box = GetStorage();
  late  UserData userData;


  var dashboard = [
    {
      "icon": "assets/icon/dashboard/booked.svg",
      "title": "Booked",
      "count": "58",
    },
    {
      "icon": "assets/icon/dashboard/accepted.svg",
      "title": "Accepted",
      "count": "20",
    },
    {
      "icon": "assets/icon/dashboard/rejected.svg",
      "title": "Rejected",
      "count": "2",
    },
    {
      "icon": "assets/icon/dashboard/assigned.svg",
      "title": "Assigned",
      "count": "15",
    },
    {
      "icon": "assets/icon/dashboard/reassign.svg",
      "title": "Re-Assign",
      "count": "8",
    },
    {
      "icon": "assets/icon/dashboard/inprogress.svg",
      "title": "In-Progress",
      "count": "13",
    },
    {
      "icon": "assets/icon/dashboard/resolved.svg",
      "title": "Resolved",
      "count": "5",
    },
    {
      "icon": "assets/icon/dashboard/onhold.svg",
      "title": "On-Hold",
      "count": "11",
    },
    {
      "icon": "assets/icon/dashboard/completed.svg",
      "title": "Completed",
      "count": "30",
    },


  ];

  RxList<MenuData> menuData=RxList();


  @override
  void onInit() {
    userData = UserData.fromJson(_box.read(Session.userData));
    menuData((jsonDecode(_box.read(Session.menuData))).map((element) { MenuData.fromJson(element);}).toList());
    super.onInit();
    getMenu();
  }


  getMenu()async{
    if (await isNetConnected()) {
      MenuResponse? menuResponse =  await ApiCall().getMenu(_box.read(Session.userId));
      if (menuResponse != null) {
        if (menuResponse.rtnStatus) {
          if(menuData.value != menuResponse.rtnData) {
            _box.write(Session.menuData, jsonEncode(
                menuResponse.rtnData.map((e) => e.toJson())
                    .toList()
                    .toString()));
            menuData(menuResponse.rtnData);
          }
        }
      }
    }
  }


}