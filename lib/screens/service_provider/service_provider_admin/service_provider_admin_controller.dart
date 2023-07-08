import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_dialog.dart';
import 'package:profixer_admin/model/admin_response.dart';
import 'package:profixer_admin/model/serviceprovider_response.dart';

import '../../../helpers/utils.dart';

class ServiceProviderAdminController extends GetxController {


  //Admin controllers
  TextEditingController adminFirstNameController = TextEditingController();
  TextEditingController adminLastNameController = TextEditingController();
  TextEditingController adminUserNameController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();
  TextEditingController identityController = TextEditingController();
  TextEditingController adminMobNoController = TextEditingController();
  TextEditingController adminEmailController = TextEditingController();
  TextEditingController adminCurrentAddressController = TextEditingController();
  TextEditingController adminPermenantAddressController = TextEditingController();
  TextEditingController adminDobController = TextEditingController();
  TextEditingController adminDojController = TextEditingController();
  TextEditingController searchController = TextEditingController();


  RxBool isConfirm = true.obs;
  RxBool isLoading = false.obs;
  RxBool selectedIsActive = true.obs;

  RxList<Map<String, String>> serviceList = RxList();
  RxString selectedService = "".obs;

  RxList<Map<String, String>> areaList = RxList();
  RxString selectedArea = "".obs;

  //RxBool selectedTag = false.obs;


  RxList<AdminData> serviceProviderAdmin = RxList();
  List<AdminData> searchList = [];
  String dateFormat = "MM/dd/yyyy";

  RxString mobileNoDropDownValue = "".obs;
  List<String> mobileItems = ["+968"];


  final box = GetStorage();

  var serviceProviderId=0;

  @override
  void onInit(){
    super.onInit();
    mobileNoDropDownValue(mobileItems.first);

  }
  //for admin
  getServiceProviderAdmin(int serviceProviderId) async {
    this.serviceProviderId=serviceProviderId;
    if (await isNetConnected()) {
      isLoading(true);
      AdminResponse? response =
      await ApiCall().getServiceProviderAdmin(serviceProviderId,0);
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          serviceProviderAdmin(response.rtnData);
          searchList = response.rtnData;
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }

  //for admin
  insertUpdateServiceProviderAdmin(bool val, data) async {
    if (await isNetConnected()) {
      isLoading(true);
      data["IsActive"] = val;
      var response = await ApiCall().insertServiceProviderAdmin(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          customDialog(Get.context, "Success", response['RtnMsg'].toString(),
                  () {
                Get.back();
              });
          getServiceProviderAdmin(serviceProviderId);
        }
        toast(response['RtnMsg']);
      }
    }
  }

  enableAndDisableServiceProviderAdmin(bool val, data) async {
    if (await isNetConnected()) {
      isLoading(true);
      data.isActive= val;
      var response = await ApiCall().insertServiceProviderAdmin(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          customDialog(Get.context, "Success", response['RtnMsg'].toString(),
                  () {
                Get.back();
              });
          getServiceProviderAdmin(serviceProviderId);
        }
        toast(response['RtnMsg']);
      }
    }
  }
  onSearchChanged(String text) {
    if (text.isEmpty) {
      serviceProviderAdmin(searchList);
    } else {
      serviceProviderAdmin(searchList
          .where((element) =>
      element.serviceProviderName
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase()) ||
          element.firstName
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()) || element.mobileNumber
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase()))
          .toList());
    }
  }
}
