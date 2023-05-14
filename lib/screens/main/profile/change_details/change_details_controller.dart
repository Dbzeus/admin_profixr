

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeDetailsController extends GetxController{
  TextEditingController  nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  RxString mobileNoDropDownValue = "+966".obs;
  var mobileItems = [
    '+966',
    '+967',
    '+968',
    '+969',
  ];

  RxString designationDropDownValue = "Male".obs;
  var designationItems = [
    'Male',
    'Female',
    'Other',
  ];
}