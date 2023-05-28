import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../apis/api_call.dart';
import '../../helpers/constant_widgets.dart';
import '../../helpers/custom_dialog.dart';

class ServiceController extends GetxController{
  RxList services = RxList();
  RxBool isLoading = false.obs;

  TextEditingController serviceNameController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxBool selectedIsActive = true.obs;

  RxString imagePath="".obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getServices();
  }

  getServices() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getService();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          services(response['RtnData']);
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  createService(service,bool isUpdated) async {
    if (await isNetConnected()) {
      isLoading(true);

      if(service['ServiceImg'].isNotEmpty && !("${service['ServiceImg']}".isURL)){
        //upload Image
        var response=await ApiCall().uploadAttachment([service['ServiceImg']]);
        if(response!=null){
          if(response['RtnStatus']){
            service['ServiceImg']=response['RtnMsg'];
          }else{
            toast('${response['RtnMsg']}');
          }
        }
      }
      debugPrint(service.toString());
      var response = await ApiCall().insertService(service);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          customDialog(
              Get.context, isUpdated ? "Updated Successful!": "Added Successful!", "${response['RtnMsg']}", () {
            Get.back();
            getServices();
          }, isDismissable: false);
        } else {
          toast('${response['RtnMsg']}');
        }
      }
    }
  }

  updateService(bool val, data) async {
    if (await isNetConnected()) {
      isLoading(true);
      data['IsActive'] = val;
      var response = await ApiCall().insertService(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          services.refresh();
        }
        toast(response['RtnMsg']);
      }
    }

  }

}