import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../apis/api_call.dart';
import '../../helpers/constant_widgets.dart';
import '../../helpers/custom_dialog.dart';

class ComplaintNatureController extends GetxController {
  RxList cNatures = RxList();
  RxBool isLoading = false.obs;

  TextEditingController natureNameController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxBool selectedIsActive = true.obs;

  RxString imagePath = "".obs;

  final box = GetStorage();

  RxList<Map<String, String>> services = RxList();
    RxString selectedService = "".obs;

  @override
  void onInit() {
    super.onInit();
    getComplaintNature();
    getServices();
  }

  getServices() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getService();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          for (var e in response['RtnData']) {
            services.add(
                {"id": '${e["ServiceID"]}', "value": "${e['ServiceName']}"});
          }
          if (services.isNotEmpty) {
            selectedService('${services.first['id']}');
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getComplaintNature() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getComplaintNature();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          cNatures(response['RtnData']);
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  createComplaintNature(data, bool isUpdated) async {
    if (await isNetConnected()) {
      isLoading(true);

      if (data['ComplaintNatureImg'].isNotEmpty &&
          !("${data['ComplaintNatureImg']}".isURL)) {
        //upload Image
        var response =
            await ApiCall().uploadAttachment([data['ComplaintNatureImg']]);
        if (response != null) {
          if (response['RtnStatus']) {
            data['ComplaintNatureImg'] = response['RtnMsg'];
          } else {
            toast('${response['RtnMsg']}');
          }
        }
      }
      debugPrint(data.toString());
      var response = await ApiCall().insertComplaintNature(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          customDialog(
              Get.context,
              isUpdated ? "Updated Successful!" : "Added Successful!",
              "${response['RtnMsg']}", () {
            Get.back();
            getComplaintNature();
          }, isDismissable: false);
        } else {
          toast('${response['RtnMsg']}');
        }
      }
    }
  }

  updateComplaintNature(bool val, data) async {
    if (await isNetConnected()) {
      isLoading(true);
      data['IsActive'] = val;
      var response = await ApiCall().insertComplaintNature(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          cNatures.refresh();
        }
        toast(response['RtnMsg']);
      }
    }
  }
}
