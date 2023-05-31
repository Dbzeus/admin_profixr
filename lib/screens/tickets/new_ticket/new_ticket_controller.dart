import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTicketController extends GetxController{

  RxInt currentStep = 0.obs;


//Personal details TextEditingController
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerMobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  //Address TextEditingController
  TextEditingController customerAddressTitleController = TextEditingController();
  TextEditingController doorNoController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  RxString cityDropDownValue = "Muscat".obs;
  var cityDropDownItems = [
    'Muscat',
    'Oman',
  ];
  TextEditingController areaNameController = TextEditingController();
  RxString areaDropDownValue = "Muscat".obs;
  var areaDropDownItems = [
    'Muscat',
    'Oman',
  ];

//Booking TextEditingController
  TextEditingController serviceDateController = TextEditingController();
  TextEditingController bookingRemarksController = TextEditingController();
  TextEditingController serviceTypeController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceCategoryController = TextEditingController();
  TextEditingController serviceAmountController = TextEditingController();
  TextEditingController serviceTimeController = TextEditingController();
  RxString imagePath=''.obs;

  String dateFormat ="MM/dd/yyyy";
  String timeFormat = 'hh:mm a';

  RxString categoryDropDownValue = "Plumbing".obs;
  var categoryItems = [
    'Plumbing',
    'Electrician',
    'Technician',
  ];
  RxString serviceNameDropDownValue = "Tap Fixing".obs;
  var serviceNameItems = [
    'Tap Fixing',
    'Full Work',
      ];
  RxString serviceTypeDropDownValue = "Scheduled Service".obs;
  var serviceTypeItems = [
    'Scheduled Service',
    'Hourly basis',
  ];
  RxString amountDropDownValue = "SAR".obs;
  var amountItems = [
    'SAR',
    'RUPEES',
    'DOLLAR',
    'VAR',
  ];

  RxString mobileNoDropDownValue = "+966".obs;
  var mobileItems = [
    '+966',
    '+967',
    '+968',
    '+969',

  ];


}