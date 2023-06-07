import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';

import '../../../helpers/utils.dart';

class CheckCustomerController extends GetxController {
  final _box = GetStorage();
  TextEditingController customerNameController = TextEditingController();
  RxList customers=RxList();
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
        }else{
          toast(response.rtnMsg);
        }
      }
      isLoading(false);
    }
  }
}
