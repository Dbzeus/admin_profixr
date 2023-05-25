import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/apis/api_call.dart';

import '../../helpers/constant_widgets.dart';

class CityController extends GetxController {
  RxList cities = RxList();
  RxList countries = RxList();
  RxBool isLoading = true.obs;

  Rx selectedCountry=Rx(null);

  TextEditingController cityNameController=TextEditingController();
  TextEditingController countryNameController=TextEditingController();
  RxBool selectedIsActive=true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCity();
    getCountry();
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

  getCountry() async {
    if (await isNetConnected()) {
      var response = await ApiCall().getCountry();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          countries(response['RtnData']);
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  updateCity(bool val, city) async {
    if (await isNetConnected()) {
      isLoading(true);
      city['IsActive'] = val;
      var response = await ApiCall().insertCity(city);
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
}
