import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/model/customer_response.dart';

import '../../../apis/api_call.dart';
import '../../../helpers/constant_widgets.dart';
import '../../../helpers/custom_dialog.dart';
import '../../../helpers/utils.dart';

class CustomerController extends GetxController {
  RxList<Customer> customers = RxList();
  RxList<Customer> searchList = RxList();
  RxBool isLoading = false.obs;

  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();

  RxBool selectedIsActive = true.obs;

  final box = GetStorage();

  int customerId = 0;
  int userId = 0;

  RxString mobileNoDropDownValue = "+966".obs;
  List<String> mobileItems = ["+966", "+967", "+968"];

  RxInt isSelectedTag = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getCustomers();
  }

  getCustomers() async {
    if (await isNetConnected()) {
      isLoading(true);
      CustomerResponse? response = await ApiCall().getProfixerCustomer();
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          customers(response.rtnData);
          searchList(response.rtnData);
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }

  validation(bool isUpdated){
    if (nameController.text.isEmpty &&
        mobileController.text.isEmpty &&
        emailController.text.isEmpty &&
        permanentAddressController.text.isEmpty &&
        dobController.text.isEmpty &&
        remarkController.text.isEmpty) {
      toast("Please Enter All Fields");
    } else if (nameController.text.isEmpty) {
      toast("Please Enter Customer Name");
    } else if (mobileController.text.isEmpty) {
      toast("Please Enter Mobile Number");
    } else if (emailController.text.isEmpty) {
      toast("Please Enter Email ID");
    } else if (permanentAddressController.text.isEmpty) {
      toast("Please Enter Your Permanent Address");
    } else if (dobController.text.isEmpty) {
      toast("Please Enter Date of Birth");
    } else if (remarkController.text.isEmpty) {
      toast("Please Enter Remarks");
    }else{
      var data = {
        "CustomerID": customerId,
        "UserID": userId,
        "FirstName": nameController.text.trim(),
        "LastName": "",
        "MobileNumber":
        mobileController.text.trim(),
        "EMailID": emailController.text.trim(),
        "CurrentAddress":
        permanentAddressController.text.trim(),
        "DOB":
        toSendDateFormat(dobController.text),
        "Remarks": remarkController.text.trim(),
        "Username": mobileController.text.trim(),
        "Password": "1234",
        "IsActive": true,
        "CUID": box.read(Session.userId)
      };
      createCustomer(
          data, isUpdated);
    }
  }

  createCustomer(data, bool isUpdated) async {

      if (await isNetConnected()) {
        isLoading(true);
        debugPrint(data.toString());
        var response = await ApiCall().insertCustomer(data);
        isLoading(false);
        if (response != null) {
          if (response['RtnStatus']) {
            customDialog(
                Get.context,
                isUpdated ? "Updated Successful!" : "Added Successful!",
                "${response['RtnMsg']}", () {
                  getCustomers();
              isSelectedTag(1);
            }, isDismissable: false);
          } else {
            toast('${response['RtnMsg']}');
          }
        }
      }
    }


  onSearchChanged(String text) {
    if (text.isEmpty) {
      customers(searchList);
    } else {
      customers(searchList
          .where((element) =>
              element.userName
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.firstName
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.mobileNo
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.emailID
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()))
          .toList());
    }
  }
}
