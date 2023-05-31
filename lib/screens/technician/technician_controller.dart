
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TechnicianController extends GetxController{

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController identityController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxBool isConfirm = true.obs;


  String dateFormat ="MM/dd/yyyy";
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

  RxString serviceProviderDropDownValue = "Plumbing".obs;
  var serviceProviderDropDownItems = [
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