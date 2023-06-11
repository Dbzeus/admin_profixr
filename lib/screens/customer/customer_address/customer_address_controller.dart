
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/model/customer_address_response.dart';
import 'package:profixer_admin/model/customer_response.dart';

import '../../../apis/api_call.dart';
import '../../../helpers/constant_widgets.dart';
import '../../../helpers/custom_dialog.dart';
import '../../../helpers/utils.dart';

class CustomerAddressController extends GetxController {
  RxList<CustomerAddress> customerAddress = RxList();
  RxList<CustomerAddress> searchList = RxList();
  RxBool isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  int customerId = 0;

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
      CustomerAddressResponse? response = await ApiCall().getCustomerAddress(
          customerId: customerId);
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          customerAddress(response.rtnData);
          searchList(response.rtnData);
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }

  validation(bool isUpdated, CustomerAddress? address) {
    if (addressTitleController.text.isEmpty &&
        doorNoController.text.isEmpty &&
        streetNameController.text.isEmpty &&
        selectedCity.isEmpty &&
        selectedArea.isEmpty &&
        landmarkController.text.isEmpty

    ) {
      toast("Please Enter All Fields");
    } else if (
    addressTitleController.text.isEmpty
    ) {
      toast("Please Enter Address");
    } else if (
    doorNoController.text.isEmpty
    ) {
      toast("Please Enter DoorNo ");
    } else if (
    streetNameController.text.isEmpty
    ) {
      toast("Please Enter Street Name");
    } else if (
    selectedCity.isEmpty
    ) {
      toast("Please Select City");
    } else if (
    selectedArea.isEmpty
    ) {
      toast("Please Select Area");
    } else if (
    landmarkController.text.isEmpty
    ) {
      toast("Please Enter Landmark");
    } else {
      var data = {
        "AddressID": address?.addressID ?? 0,
        "CustomerID": address?.customerID ?? customerId,
        "AddressTitle": addressTitleController.text
            .trim(),
        "DoorNo": doorNoController.text.trim(),
        "StreetName": streetNameController.text.trim(),
        "CityID": selectedCity.value,
        "AreaID": selectedArea.value,
        "LandMark": landmarkController.text.trim(),
        "Latitude": "",
        "Longitude": "",
        "IsActive": true,
        "CUID": box.read(Session.userId)
      };
      insertCustomerAddress(
          data, isUpdated);
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

onSearchChanged(String text) {
  if (text.isEmpty) {
    customerAddress(searchList);
  } else {
    customerAddress(searchList
        .where((element) =>
    element.firstName
        .toString()
        .toLowerCase()
        .contains(text.toLowerCase()) ||
        element.addressTitle
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase()) ||
        element.landMark
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase()) ||
        element.streetName
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase()))
        .toList());
  }
}


}