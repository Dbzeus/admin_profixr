import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_dialog.dart';
import 'package:profixer_admin/model/admin_response.dart';
import 'package:profixer_admin/model/serviceprovider_response.dart';

import '../../../helpers/utils.dart';

class ServiceProviderController extends GetxController {
  TextEditingController servicerProviderNameController =
      TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  TextEditingController taxDetailsController = TextEditingController();
  TextEditingController bankDetailsController = TextEditingController();
  TextEditingController contractStartController = TextEditingController();
  TextEditingController contractEndController = TextEditingController();

  RxBool isConfirm = true.obs;
  RxBool isLoading = false.obs;
  RxBool selectedIsActive = true.obs;
  RxInt selectedTag = 0.obs;
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
    getServiceProvider();
  }

  getServiceProvider() async {
    if (await isNetConnected()) {
      isLoading(true);
      ServiceproviderResponse? response = await ApiCall().getServiceProvider();
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          serviceProviders(response.rtnData);
          // searchList = response['RtnData'];
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }

  getServiceProviderService(int serviceProviderId) async {
    if (await isNetConnected()) {
      isLoading(true);
      final response = await ApiCall()
          .getServiceProviderService(providerId: serviceProviderId);
      isLoading(false);
      if (response != null) {
        serviceList.clear();
        if (response["RtnStatus"]) {
          for (var e in response['RtnData']) {
            serviceList
                .add({"id": '${e["Service"]}', "value": "${e['ServiceName']}"});
          }
          if (serviceList.isNotEmpty) {
            selectedService('${serviceList.first['id']}');
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getServiceProviderArea(int serviceProviderId) async {
    if (await isNetConnected()) {
      isLoading(true);
      var response =
          await ApiCall().getServiceProviderArea(providerId: serviceProviderId);
      isLoading(false);
      if (response != null) {
        areaList.clear();
        if (response["RtnStatus"]) {
          for (var e in response['RtnData']) {
            areaList.add({"id": '${e["Area"]}', "value": "${e['AreaName']}"});
          }
          if (areaList.isNotEmpty) {
            selectedArea('${areaList.first['id']}');
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  insertUpdateServiceProvider(bool val, data) async {
    if (await isNetConnected()) {
      isLoading(true);
      data["IsActive"] = val;
      var response = await ApiCall().insertServiceProvider(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          customDialog(Get.context, "Success", response['RtnMsg'].toString(),
              () {
            Get.back();
            getServiceProvider();
          });

        }
        toast(response['RtnMsg']);
      }
    }
  }

  enableAndDisableServiceProvider(bool val, data) async {
    if (await isNetConnected()) {
      isLoading(true);
      data.isActive = val;
      var response = await ApiCall().insertServiceProvider(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          customDialog(
              Get.context, "Success", response['RtnMsg'].toString(), () {
            getServiceProvider();
          });

        }
        toast(response['RtnMsg']);
      }
    }
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
}
