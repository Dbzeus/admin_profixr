import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTicketController extends GetxController{

  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController customerMobileNoController = TextEditingController();
  TextEditingController serviceTypeController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceCategoryController = TextEditingController();
  TextEditingController serviceAmountController = TextEditingController();
  TextEditingController serviceDateController = TextEditingController();
  TextEditingController serviceTimeController = TextEditingController();

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