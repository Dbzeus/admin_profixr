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


  RxList<ServiceProviderData> serviceProviders = RxList();
  RxList<AdminData> serviceProviderAdmin = RxList();
  String dateFormat = "MM/dd/yyyy";

  RxString mobileNoDropDownValue = "+966".obs;
  List<String> mobileItems = ["+966", "+967", "+968"];

  RxList<Map<String, String>> areaList = RxList();
  String selectedArea = "";
  RxString selectedAreaNames = "".obs;
  RxList<Map<String, String>> servicesList = RxList();
  String selectedService = "";
  RxString selectedServiceName = "".obs;

  int serviceProviderId=0;

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

  getServiceProviderService({
    canClear=true,
  }) async {
    if (await isNetConnected()) {
      isLoading(true);
      final response = await ApiCall().getServiceProviderService(
          providerId: serviceProviderId);
      isLoading(false);
      if (response != null) {
        servicesList.clear();
        if(canClear) {
          selectedService = "";
          selectedServiceName("");
        }
        if (response["RtnStatus"]) {
          for (var e in response['RtnData']) {
            servicesList
                .add({"id": '${e["Service"]}', "value": "${e['ServiceName']}"});
          }

        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getServiceProviderArea({
    canClear=true,
  }) async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getServiceProviderArea(
          providerId: serviceProviderId);
      isLoading(false);
      if (response != null) {
        areaList.clear();
        if(canClear) {
          selectedArea = "";
          selectedAreaNames("");
        }
        if (response["RtnStatus"]) {
          for (var e in response['RtnData']) {
            areaList.add({"id": '${e["Area"]}', "value": "${e['AreaName']}"});
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
  getServiceProviderAdmin(int serviceProviderId) async {
    if (await isNetConnected()) {
      isLoading(true);
      AdminResponse? response =
          await ApiCall().getServiceProviderAdmin(serviceProviderId, box.read(Session.userId));
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

  getSelectedServiceItems() {
    return servicesList.map((element) => {
      'id':element['id'],
      'value':element['value'],
      'isSelected': selectedServiceName.split(",").firstWhereOrNull((e) => e==element['value'])!=null
    }).toList().obs;
  }

  getSelectedAreaItems() {
    return areaList.map((element) => {
      'id':element['id'],
      'value':element['value'],
      'isSelected': selectedAreaNames.split(",").firstWhereOrNull((e) => e==element['value'])!=null
    }).toList().obs;
  }


}
