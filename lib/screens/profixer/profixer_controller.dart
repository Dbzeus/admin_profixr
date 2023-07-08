import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/model/profixer_response.dart';

import '../../helpers/custom_dialog.dart';

class ProfixerController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController dojController = TextEditingController();
  TextEditingController relievedDateController = TextEditingController();
  TextEditingController relievedReasonController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController identityController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  RxBool isConfirm = true.obs;
  RxBool isLoading = false.obs;

  RxBool selectedIsActive = true.obs;
  RxBool selectedRelieveIsActive = true.obs;

  RxList<ProfixerData> profixers = RxList();
  List<ProfixerData> searchList = [];

  String dateFormat = "MM/dd/yyyy";

  RxString mobileNoDropDownValue = "".obs;
  List<String> mobileItems = ["+968"];

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getProfixer();
    mobileNoDropDownValue(mobileItems.first);
  }

  getProfixer() async {
    if (await isNetConnected()) {
      isLoading(true);

      ProfixerResponse? response = await ApiCall().getProfixerUser();
      isLoading(false);

      if (response != null) {
        if (response.rtnStatus) {
          profixers(response.rtnData);
          searchList = response.rtnData;
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }

  insertUpdateProfixer(
    bool val,
    data,
    bool isUpdated, {
    bool isShowDialog = true,
  }) async {
    if (await isNetConnected()) {
      isLoading(true);
      if (data is ProfixerData) {
        data.isActive = val;
      } else {
        data["IsActive"] = val;
      }
      var response = await ApiCall().insertProfixerUser(data);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          if (isShowDialog) {
            customDialog(
                Get.context,
                isUpdated ? "Updated Successful!" : "Created Successful!",
                response['RtnMsg'].toString(), () {
              Get.back();
              getProfixer();
            }, isDismissable: false);
          } else {
            getProfixer();
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      profixers(searchList);
    } else {
      profixers(searchList
          .where((element) =>
      element.firstName
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase()) ||
          element.mobileNo
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()) || element.desigination
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase()))
          .toList());
    }
  }
}
