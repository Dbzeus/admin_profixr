import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/apis/api_call.dart';

import '../../helpers/constant_widgets.dart';

class AreaController extends GetxController {
  RxList areas = RxList();
  RxList cities = RxList();
  RxBool isLoading = true.obs;

  Rx selectedCity=Rx(null);

  TextEditingController areaNameController=TextEditingController();
  TextEditingController pincodeController=TextEditingController();
  TextEditingController cityDropdownController=TextEditingController();
  TextEditingController searchController=TextEditingController();
  RxBool selectedIsActive=true.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getArea();
    getCity();
  }

  getArea() async {
    if (await isNetConnected()) {
      var response = await ApiCall().getArea();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          areas(response['RtnData']);
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }



  getCity() async {
    if (await isNetConnected()) {
      var response = await ApiCall().getCity();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          cities(response['RtnData']);
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  updateArea(bool val, area) async {
    if (await isNetConnected()) {
      isLoading(true);
      area['IsActive'] = val;
      var response = await ApiCall().insertArea(area);
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          areas(response['RtnData']);
          getArea();
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }
}
