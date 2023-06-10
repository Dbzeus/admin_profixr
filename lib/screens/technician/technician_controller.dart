import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/utils.dart';

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
  RxString mobileNoDropDownValue = "+966".obs;
  List<String> mobileItems = ["+966", "+967", "+968"];

  RxString serviceProviderDropDownValue = "Plumbing".obs;
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
  ];

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getTechnician();
  }

  getTechnician() async {
    if (await isNetConnected()) {
      isLoading(true);
      TechnicianResponse? response =
          await ApiCall().getTechnician(0,0);//_box.read(Session.userId), 1
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          technicianList(response.rtnData);
          //searchList = response['RtnData'];
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }

  insertUpdateTechnician(data) async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().insertTechnician(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          customDialog(Get.context, "Success", response['RtnMsg'].toString(),
                  () {
                Get.back();
                getTechnician();
              },isDismissable: false);
        }
        toast(response['RtnMsg']);
      }
    }
  }
}
