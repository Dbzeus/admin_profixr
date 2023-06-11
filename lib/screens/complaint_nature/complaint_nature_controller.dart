import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../apis/api_call.dart';
import '../../helpers/constant_widgets.dart';
import '../../helpers/custom_dialog.dart';
import '../../helpers/utils.dart';

class ComplaintNatureController extends GetxController {
  RxList cNatures = RxList();
  RxList searchList = RxList();
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
          searchList(response['RtnData']);
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  createComplaintNature(data, bool isUpdated) async {
    if (selectedService.isEmpty &&
        natureNameController.text.isEmpty &&
        remarkController.text.isEmpty) {
      toast("Please Enter all fields");
    } else if (selectedService.isEmpty) {
      toast("Please select service");
    } else if (natureNameController.text.isEmpty) {
      toast("Please enter ComplaintNature");
    } else if (remarkController.text.isEmpty) {
      toast("Please enter Description");
    } else {
      if (await isNetConnected()) {
        isLoading(true);
        if (data['ComplaintNatureImg'].isNotEmpty &&
            !(data['ComplaintNatureImg'].toString().isURL)) {
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
        data['ComplaintNatureImg'] = getLastSegment(data['ComplaintNatureImg']);

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
  onSearchChanged(String text) {
    if (text.isEmpty) {
      cNatures(searchList);
    } else {
      cNatures(searchList
          .where((element) =>
      element["ServiceName"]
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase()) ||
          element["ComplaintNatureName"]
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()) || element["Remarks"]
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase()))
          .toList());
    }
  }
}
