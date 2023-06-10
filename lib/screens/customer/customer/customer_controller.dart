
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/model/customer_response.dart';

import '../../../apis/api_call.dart';
import '../../../helpers/constant_widgets.dart';
import '../../../helpers/custom_dialog.dart';

class CustomerController extends GetxController{
  RxList<Customer> customers = RxList();
  RxBool isLoading = false.obs;

  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();

  RxBool selectedIsActive = true.obs;

  final box = GetStorage();

  RxString mobileNoDropDownValue = "+966".obs;
  List<String> mobileItems = ["+966", "+967", "+968"];

  RxInt isSelectedTag = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getCustomers();
  }

  getCustomers() async {
    if (await isNetConnected()) {
      isLoading(true);
      CustomerResponse? response = await ApiCall().getProfixerCustomer();
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          customers(response.rtnData);
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }

  createCustomer(data,bool isUpdated) async {
    if (await isNetConnected()) {
      isLoading(true);

      debugPrint(data.toString());
      var response = await ApiCall().insertCustomer(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          customDialog(
              Get.context, isUpdated ? "Updated Successful!": "Added Successful!", "${response['RtnMsg']}", () {
            Get.back();
            getCustomers();
          }, isDismissable: false);
        } else {
          toast('${response['RtnMsg']}');
        }
      }
    }
  }



}