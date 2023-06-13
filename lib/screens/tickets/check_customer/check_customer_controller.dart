import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';

import '../../../helpers/utils.dart';
import '../../../model/customer_response.dart';

class CheckCustomerController extends GetxController {
  final _box = GetStorage();
  TextEditingController customerNameController = TextEditingController();
  RxList customers=RxList();
  RxList searchList=RxList();
  RxBool isLoading=false.obs;

  @override
  void onInit() {
    super.onInit();
    getCustomerList();
  }

  getCustomerList() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getProfixerCustomer();
      if(response!=null){
        if(response.rtnStatus){
          customers(response.rtnData);
          searchList(response.rtnData);
        }else{
          toast(response.rtnMsg);
        }
      }
      isLoading(false);
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      customers(searchList);
    } else {
      customers(searchList
          .where((element) =>
      element.firstName
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase()) ||
          element.mobileNo
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList());
    }
  }
}
