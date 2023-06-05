import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/model/profixer_response.dart';

class ProfixerController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController dojController = TextEditingController();
  TextEditingController relievedDateController = TextEditingController();
  TextEditingController relievedReasonController = TextEditingController();
  TextEditingController mobileController = TextEditingController();




  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  RxBool isConfirm = true.obs;
  RxBool isLoading = false.obs;

  RxBool selectedIsActive = true.obs;
  RxBool selectedRelieveIsActive = true.obs;

  RxList profixers = RxList();

  String dateFormat = "MM/dd/yyyy";

  RxString mobileNoDropDownValue = "+966".obs;
  List<String> mobileItems = ["+966", "+967", "+968"];

  RxString designationDropDownValue = "Manager".obs;
  List<Map<String, String>> designationDropDownItems = [
    {
      "id": "1",
      "value": 'Manager',
    },
    {
      "id": "2",
      "value": 'Sales',
    },
    {
      "id": "3",
      "value": 'Profixer',
    }
  ];


  @override
  void onInit() {
    super.onInit();
    getProfixer();
  }


    getProfixer() async {
    if (await isNetConnected()) {
      isLoading(true);
      ProfixerResponse? response = await ApiCall().getProfixerUser();
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          profixers(response.rtnData);
          // searchList = response['RtnData'];
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }
}
