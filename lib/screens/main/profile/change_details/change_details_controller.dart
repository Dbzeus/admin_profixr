

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChangeDetailsController extends GetxController{
  TextEditingController  nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  final box=GetStorage();

  RxString mobileNoDropDownValue = "+966".obs;
  var mobileItems = [
    '+966',
    '+967',
    '+968',
    '+969',
  ];

  RxString designationDropDownValue = "Admin".obs;
  var designationItems = [
    'Admin',
    'Techinician',
    'Customer',
  ];
}