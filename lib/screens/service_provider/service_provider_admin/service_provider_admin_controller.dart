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
  TextEditingController adminMobNoController = TextEditingController();
  TextEditingController adminEmailController = TextEditingController();
  TextEditingController adminCurrentAddressController = TextEditingController();
  TextEditingController adminPermenantAddressController =
  TextEditingController();
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

  RxList<ServiceProviderData> serviceProviders = RxList();
  RxList<AdminData> serviceProviderAdmin = RxList();
  String dateFormat = "MM/dd/yyyy";

  RxString mobileNoDropDownValue = "+966".obs;
  List<String> mobileItems = ["+966", "+967", "+968"];

  int serviceProviderId = -1;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();


  }

  //for admin
  getServiceProviderAdmin(int serviceProviderId, int userId) async {
    if (await isNetConnected()) {
      isLoading(true);
      AdminResponse? response =
      await ApiCall().getServiceProviderAdmin(serviceProviderId, userId);
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          serviceProviderAdmin(response.rtnData);
          // searchList = response['RtnData'];
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
          getServiceProviderAdmin(serviceProviderId, box.read(Session.userId));
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
          getServiceProviderAdmin(serviceProviderId, box.read(Session.userId));
        }
        toast(response['RtnMsg']);
      }
    }
  }
}
