import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/serviceprovider_response.dart';

import '../../helpers/constant_widgets.dart';
import '../../helpers/custom_dialog.dart';
import '../../model/technician_response.dart';

class TechnicianController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController dojController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController identityController = TextEditingController();

  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  RxBool isConfirm = true.obs;
  RxBool selectedIsActive = true.obs;
  RxBool isLoading = false.obs;
  String dateFormat = "MM/dd/yyyy";
  RxList<TechnicainData> technicianList = RxList();
  List<TechnicainData> searchList = [];
  RxString mobileNoDropDownValue = "".obs;
  List<String> mobileItems = ["+968"];

  /*RxString serviceProviderDropDownValue = "Plumbing".obs;
  List<Map<String, String>> serviceProviderDropDownItems = [
    {
      "id": "1",
      "value": 'Plumbing',
    },
    {
      "id": "2",
      "value": 'Electrician',
    },
    {
      "id": "3",
      "value": 'Technician',
    }
  ];*/

  final box = GetStorage();
  RxList<Map<String, String>> areaList = RxList();
  String selectedArea = "";
  RxString selectedAreaNames = "".obs;
  RxList<Map<String, String>> servicesList = RxList();
  String selectedService = "";
  RxString selectedServiceName = "".obs;
  RxList<Map<String, String>> serviceProviderList = RxList();
  RxString selectedServiceProvider = "".obs;

  @override
  void onInit() {
    mobileNoDropDownValue(mobileItems.first);
    super.onInit();
    getTechnician();
  }


  getServiceProviders({
    bool isAssigned=true,
    String? selectedId,
}) async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getServiceProvider();
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          serviceProviderList.clear();
          for (var e in response.rtnData) {
            serviceProviderList.add({
              "id": '${e.serviceProviderID}',
              "value": e.serviceProviderName
            });
          }
          if (serviceProviderList.isNotEmpty && isAssigned) {
            selectedServiceProvider('${serviceProviderList.first['id']}');
            getServiceProviderService();
            getServiceProviderArea();
          }
          if(selectedId!=null){
            selectedServiceProvider(selectedId);
          }
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
          providerId: int.parse(selectedServiceProvider.value));
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
          // if (servicesList.isNotEmpty) {
          //   selectedService('${servicesList.first['id']}');
          // }
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
          providerId: int.parse(selectedServiceProvider.value));
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
          // if (areaList.isNotEmpty) {
          //   selectedArea('${areaList.first['id']}');
          // }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getTechnician() async {
    if (await isNetConnected()) {
      isLoading(true);
      TechnicianResponse? response =
          await ApiCall().getTechnician(0, 0); //_box.read(Session.userId), 1
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          technicianList(response.rtnData);
          searchList = response.rtnData;
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }

  insertUpdateTechnician( bool val,
      data,
      bool isUpdated, {
        bool isShowDialog = true,
      }) async {
    if (await isNetConnected()) {
      isLoading(true);
      if(data is TechnicainData){
        data.isActive = val;
      }else {
        data["IsActive"] = val;
      }
      var response = await ApiCall().insertTechnician(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          if (isShowDialog) {
            customDialog(Get.context,
                isUpdated ? "Updated Successful!" : "Created Successful!",
                response['RtnMsg'].toString(),
                    () {
                  Get.back();
                  getTechnician();
                }, isDismissable: false);
          }else{
            getTechnician();
          }
        }else {
          toast(response['RtnMsg']);
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
  onSearchChanged(String text) {
    if (text.isEmpty) {
      technicianList(searchList);
    } else {
      technicianList(searchList
          .where((element) =>
      element.firstName
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase()) ||
          element.mobileNumber
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()) || element.userNAme
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase()))
          .toList());
    }
  }
}
