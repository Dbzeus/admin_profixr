import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddServiceController extends GetxController{

  RxString title = "".obs;
  RxString buttonTitle = "".obs;

  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceCategoryController = TextEditingController();
  TextEditingController serviceAmountController = TextEditingController();
  TextEditingController serviceDescriptionController = TextEditingController();

  RxString imagePath="".obs;

  RxString dropDownValue = "SAR".obs;
  var items = [
    'SAR',
    'RUPEES',
    'DOLLAR',
    'VAR',

  ];
  RxString categoryDropDownValue = "Plumbing".obs;
  var categoryItems = [
    'Plumbing',
    'Electrician',
    'Technician',
  ];

  @override
  void onInit() {
    title (Get.arguments["title"]);
    buttonTitle(Get.arguments["buttonTitle"]);
    // TODO: implement onInit
    super.onInit();
  }
}