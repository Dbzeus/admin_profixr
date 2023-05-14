
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TechnicianDetailsController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController identityController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  RxString imagePath="".obs;


  RxBool checkValue = false.obs;
  RxString mobileNoDropDownValue = "+966".obs;
  var mobileItems = [
    '+966',
    '+967',
    '+968',
    '+969',
  ];

  RxString genderDropDownValue = "Male".obs;
  var genderItems = [
    'Male',
    'Female',
    'Other',
  ];

  RxString occupationDropDownValue = "Plumbing".obs;
  var occupationItems = [
    'Plumbing',
    'Electrician',
    'Technician',
  ];

  RxString cityDropDownValue = "Arabia".obs;
  var cityItems = [
    'Arabia',
    'Muscat',
    'Sohar',
  ];
}