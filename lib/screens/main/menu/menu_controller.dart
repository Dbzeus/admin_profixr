
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';

class MenuController extends GetxController{


  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getMenu();
    debugPrint("oninti");
    super.onInit();

  }

  getMenu()async{
    debugPrint("MENU");
    if (await isNetConnected()) {
      isLoading(true);
      var menuResponse =  await ApiCall().getMenu(1);
      isLoading(false);
      if (menuResponse != null) {
        if (menuResponse["RtnStatus"]) {
          toast(menuResponse["RtnMsg"]);
        } else {
          toast(menuResponse["RtnMsg"]);
        }
      }
    }
  }
}