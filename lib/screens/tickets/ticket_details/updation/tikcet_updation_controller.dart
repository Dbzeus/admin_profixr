import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../apis/api_call.dart';
import '../../../../helpers/constant_widgets.dart';
import '../../../../helpers/utils.dart';

class TicketUpdationController extends GetxController {
  TextEditingController remarksController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  RxList<Map<String, String>> providers = RxList();
  RxString selectedProvider = "".obs;

  RxList<Map<String, String>> technicians = RxList();
  RxString selectedTechnicians = "".obs;

  RxBool isLoading = false.obs;
  RxString imagePath = "".obs;

  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  getServiceProviders() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getServiceProvider();
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          providers.clear();
          for (var e in response.rtnData) {
            providers.add({
              "id": '${e.serviceProviderID}',
              "value": e.serviceProviderName
            });
          }
          if (providers.isNotEmpty) {
            selectedProvider('${providers.first['id']}');
            getTechnicians();
          }
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }

  getTechnicians() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getTechnician(0, int.parse(selectedProvider.value));
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          technicians.clear();
          for (var e in response.rtnData) {
            technicians
                .add({"id": '${e.technicianID}', "value": "${e.userNAme}"});
          }
          if (technicians.isNotEmpty) {
            selectedTechnicians('${technicians.first['id']}');
          }
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }
}
