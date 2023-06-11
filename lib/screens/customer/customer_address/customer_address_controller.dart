
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/model/customer_address_response.dart';
import 'package:profixer_admin/model/customer_response.dart';

import '../../../apis/api_call.dart';
import '../../../helpers/constant_widgets.dart';
import '../../../helpers/custom_dialog.dart';

class CustomerAddressController extends GetxController{
  RxList<CustomerAddress> customerAddress = RxList();
  RxBool isLoading = false.obs;

  TextEditingController  searchController= TextEditingController();

  int customerId=0;

  //address form
  TextEditingController  addressTitleController= TextEditingController();
  TextEditingController  doorNoController= TextEditingController();
  TextEditingController  streetNameController= TextEditingController();
  TextEditingController  landmarkController= TextEditingController();

  RxBool selectedIsActive = true.obs;

  final box = GetStorage();

  RxString mobileNoDropDownValue = "+966".obs;
  List<String> mobileItems = ["+966", "+967", "+968"];

  RxList<Map<String, String>> cities = RxList();
  RxString selectedCity = "".obs;

  RxList<Map<String, String>> areas = RxList();
  RxString selectedArea = "".obs;


  @override
  void onInit() {
    super.onInit();
  }

  getArea() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getArea(cityId: int.parse(selectedCity.value));
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          areas.clear();
          for (var e in response['RtnData']) {
            areas.add({"id": '${e["AreaID"]}', "value": "${e['AreaName']}"});
          }
          if (areas.isNotEmpty) {
            selectedArea('${areas.first['id']}');
          }else{
            selectedArea('');
          }
          areas.refresh();
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getCity() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getCity();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          cities.clear();
          for (var e in response['RtnData']) {
            cities.add({"id": '${e["CityID"]}', "value": "${e['CityName']}"});
          }
          if (cities.isNotEmpty) {
            selectedCity('${cities.first['id']}');
            getArea();
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getCustomerAddress() async {
    if (await isNetConnected()) {
      isLoading(true);
      CustomerAddressResponse? response = await ApiCall().getCustomerAddress(customerId: customerId);
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          customerAddress(response.rtnData);
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }

  insertCustomerAddress(data, bool isUpdated, {bool showDialog = true}) async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().insertCustomerAddress(data);
      if (response != null) {
        if (response['RtnStatus']) {
          if(showDialog) {
            customDialog(
                Get.context,
                isUpdated ? "Updated Successful!" : "Added Successful!",
                "${response['RtnMsg']}",
                    () {
                  getCustomerAddress();
                  Get.back();
                }, isDismissable: false);
          }else{
            customerAddress.firstWhere((element) => element.addressID==data.addressID).isActive=data[''];
            customerAddress.refresh();
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
      isLoading(false);
    }
  }



}