import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';

import '../../helpers/constant_widgets.dart';
import '../../helpers/custom_dialog.dart';

class AreaController extends GetxController {
  RxList areas = RxList();
  List searchList = [];
  RxList<Map<String, String>> cities = RxList();
  RxBool isLoading = false.obs;

  RxString selectedCity = "".obs;

  TextEditingController areaNameController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxBool selectedIsActive = true.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getArea();
    getCity();
  }

  getArea() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getArea();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          areas(response['RtnData']);
          searchList = response['RtnData'];
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getCity() async {
    if (await isNetConnected()) {
      var response = await ApiCall().getCity();
      if (response != null) {
        if (response['RtnStatus']) {
          (response['RtnData'] as List).sort((a,b)=>a['CityName'].toString().compareTo(b['CityName']));
          for (var e in response['RtnData']) {
            if(e['IsActive']) {
              cities.add({"id": '${e["CityID"]}', "value": "${e['CityName']}"});
            }
          }
          if (cities.isNotEmpty) {
            selectedCity('${cities.first['id']}');
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  createArea(area, bool isUpdated) async {
    if (areaNameController.text.isEmpty &&
    pincodeController.text.isEmpty &&
    selectedCity.isEmpty) {
    toast("Please Enter All Fields");
    } else if (areaNameController.text.isEmpty) {
      toast("Please Enter Area");
    } else if (pincodeController.text.isEmpty) {
      toast("Please Enter Area");
    } else if (selectedCity.isEmpty) {
      toast("Please Enter City");
    } else {
      if (await isNetConnected()) {
        isLoading(true);
        var response = await ApiCall().insertArea(area);
        isLoading(false);
        if (response != null) {
          if (response['RtnStatus']) {
            customDialog(
                Get.context,
                isUpdated ? "Updated Successful!" : "Added Successful!",
                "${response['RtnMsg']}", () {
              Get.back();
              getArea();
            }, isDismissable: false);
          } else {
            toast('${response['RtnMsg']}');
          }
        }
      }
    }
  }

  updateArea(bool val, area) async {
    if (await isNetConnected()) {
      isLoading(true);
      area['IsActive'] = val;
      var response = await ApiCall().insertArea(area);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          areas.refresh();
        }
        toast(response['RtnMsg']);
      }
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      areas(searchList);
    } else {
      areas(searchList
          .where((element) =>
              element["AreaName"]
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element["CityName"]
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()))
          .toList());
    }
  }
}
