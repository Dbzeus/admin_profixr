import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/custom_dialog.dart';

import '../../helpers/constant_widgets.dart';

class CityController extends GetxController {
  RxList cities = RxList();
  List searchList = [];
  RxList<Map<String, String>> countries = RxList();
  RxBool isLoading = false.obs;

  RxString selectedCountry = "".obs;

  TextEditingController cityNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxBool selectedIsActive = true.obs;

  final box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCity();
    getCountry();
  }

  getCity() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getCity();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          cities(response['RtnData']);
          searchList = response['RtnData'];
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getCountry() async {
    if (await isNetConnected()) {
      var response = await ApiCall().getCountry();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          for (var e in response['RtnData']) {
            countries.add(
                {"id": '${e["CountryID"]}', "value": "${e['CountryName']}"});
          }
          if (countries.isNotEmpty) {
            selectedCountry('${countries.first['id']}');
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  createCity(city, bool isUpdated) async {
     if (cityNameController.text.isEmpty) {
      toast("Please Enter City");
    } else if (selectedCountry.isEmpty) {
      toast("Please Enter Country");
    }else{
      if (await isNetConnected()) {
        isLoading(true);
        var response = await ApiCall().insertCity(city);
        isLoading(false);
        if (response != null) {
          if (response['RtnStatus']) {
            customDialog(
                Get.context,
                isUpdated ? "Updated Successful!" : "Added Successful!",
                "${response['RtnMsg']}", () {
              Get.back();
              getCity();
            }, isDismissable: false);
          } else {
            toast('${response['RtnMsg']}');
          }
        }
      }
    }

  }

  updateCity(bool val, city) async {
    if (await isNetConnected()) {
      isLoading(true);
      city['IsActive'] = val;
      var response = await ApiCall().insertCity(city);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          cities.refresh();
        }
        toast(response['RtnMsg']);
      }
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      cities(searchList);
    } else {
      cities(searchList
          .where((element) =>
              element["CityName"]
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element["CountryName"]
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()))
          .toList());
    }
  }
}
