import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/model/ticket_count_response.dart';

import '../../apis/api_call.dart';
import '../../helpers/constant_widgets.dart';
import '../../helpers/utils.dart';
import '../../model/MenuResponse.dart';
import '../../model/userResponse.dart';

class MainController extends GetxController {

  final box = GetStorage();
  late UserData userData;

  RxList<TicketCount> dashboards=RxList();

  RxList<MenuData> menuData=RxList();

  RxBool isLoading=false.obs;


  @override
  void onInit() {
    userData = UserData.fromJson(box.read(Session.userData));
    var menus=jsonDecode(box.read(Session.menuData) ?? "[]");
    menus.forEach((v) {
      menuData.add(MenuData.fromJson(v));
    });
    super.onInit();
    getTicketCounts();
    getMenu();
      }

  getTicketCounts()async{
    if (await isNetConnected()) {
      isLoading(true);
      TicketCountResponse? response =  await ApiCall().getTicketCount(box.read(Session.userId),0,"05-25-2023","05-30-2023");
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
            dashboards(response.rtnData);

          }
        }
      }
    }


  getMenu()async{
    if (await isNetConnected()) {
      MenuResponse? menuResponse =  await ApiCall().getMenu(box.read(Session.userId));
      if (menuResponse != null) {
        if (menuResponse.rtnStatus) {
          if(menuData.value != menuResponse.rtnData) {
            box.write(Session.menuData, jsonEncode(menuResponse.rtnData));
            menuData(menuResponse.rtnData);
          }
        }
      }
    }
  }


}