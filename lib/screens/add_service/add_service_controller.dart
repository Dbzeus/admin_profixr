import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddServiceController extends GetxController{
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceCategoryController = TextEditingController();
  TextEditingController serviceAmountController = TextEditingController();
  TextEditingController serviceDescriptioncontroller = TextEditingController();

  RxString dropDownValue = "SAR".obs;
  var items = [
    'SAR',
    'RUPEES',
    'DOLLAR',
    'VAR',

  ];
}