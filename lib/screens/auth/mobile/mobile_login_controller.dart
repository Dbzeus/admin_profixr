


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MobileLoginController extends GetxController{
  TextEditingController mobNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isVisible= true.obs;
  RxString dropDownValue = "+966".obs;
  var items = [
    '+966',
    '+967',
    '+968',
    '+969',

  ];
}