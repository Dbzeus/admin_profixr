
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankDetailsController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController confirmAccountNoController = TextEditingController();
  TextEditingController ifscNoController = TextEditingController();

  RxBool checkValue = false.obs;
}