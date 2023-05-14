import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddCategroyController extends GetxController{
  RxString title = "".obs;
  RxString buttonTitle = "".obs;
TextEditingController categoryNameController = TextEditingController();

@override
  void onInit() {
  title (Get.arguments["title"]);
  buttonTitle(Get.arguments["buttonTitle"]);
  // TODO: implement onInit
    super.onInit();
  }
}