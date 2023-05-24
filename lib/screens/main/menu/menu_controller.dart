
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/MenuResponse.dart';

import 'package:profixer_admin/model/userResponse.dart';

class ProfixrMenuController extends GetxController{


  RxBool isLoading = false.obs;
  final _box = GetStorage();
  late  UserData userData;
  RxList<MenuData> menuData=RxList();
  @override
  void onInit() {
    super.onInit();
    userData = UserData.fromJson(_box.read(Session.userData));
    menuData((jsonDecode(_box.read(Session.menuData))).map((element) { MenuData.fromJson(element);}).toList());
    getMenu();

  }

  getMenu()async{
    debugPrint("MENU");
    if (await isNetConnected()) {
      isLoading(true);
      MenuResponse? menuResponse =  await ApiCall().getMenu(userData.userID);
      isLoading(false);
      if (menuResponse != null) {
        if (menuResponse.rtnStatus) {
          _box.write(Session.menuData, jsonEncode(menuResponse.rtnData.map((e) => e.toJson()).toList().toString()));
        }
      }
    }
  }
}