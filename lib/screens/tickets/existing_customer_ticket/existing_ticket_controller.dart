import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/screens/main/main_controller.dart';

import '../../../helpers/custom_dialog.dart';
import '../../../helpers/utils.dart';
import '../../../model/customer_address_response.dart';
import '../../../model/customer_response.dart';

class ExistingTicketController extends GetxController {
  RxBool isLoading = false.obs;

  final _box = GetStorage();

  Customer customer = Get.arguments['customer'];

  RxList<Map<String, String>> cities = RxList();
  RxString selectedCity = "".obs;

  RxList<Map<String, String>> areas = RxList();
  RxString selectedArea = "".obs;

//Personal details TextEditingController
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerMobileNoController = TextEditingController();

  //Address TextEditingController
  RxList<Map<String, String>> addresses = RxList();
  RxString selectedAddress = "".obs;

//Booking TextEditingController
  RxList<Map<String, String>> services = RxList();
  RxString selectedService = "".obs;

  RxList<Map<String, String>> cNatures = RxList();
  RxString selectedCNature = "".obs;

  RxList<Map<String, String>> types = RxList();
  RxString selectedType = "".obs;

  RxList<Map<String, String>> timeSlots = RxList();
  RxString selectedTimeSlot = "".obs;

  TextEditingController serviceDateController = TextEditingController();
  TextEditingController bookingRemarksController = TextEditingController();

  RxString imagePath = ''.obs;

  RxString mobileNoDropDownValue = "+966".obs;
  var mobileItems = [
    '+966',
    '+967',
    '+968',
    '+969',
  ];

  @override
  void onInit() {
    super.onInit();
    setupCustomer();
    getCustomerAddress();
    getTimeSlots();
    getServiceType();
    getServices();
    getComplaintNature();
  }

  setupCustomer() {
    customerNameController.text = customer.firstName;
    customerMobileNoController.text = customer.mobileNo;
  }

  getCustomerAddress() async {
    if (await isNetConnected()) {
      isLoading(true);
      CustomerAddressResponse? response =
          await ApiCall().getCustomerAddress(customerId: customer.customerID);
      isLoading(false);
      if (response != null) {
        if (response.rtnStatus) {
          for (var e in response.rtnData) {
            addresses.add({"id": '${e.addressID}', "value": e.addressTitle});
          }
          if (addresses.isNotEmpty) {
            selectedAddress('${addresses.first['id']}');
          }
        } else {
          toast(response.rtnMsg);
        }
      }
    }
  }

  getTimeSlots() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getTimeSlot();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          for (var e in response['RtnData']) {
            timeSlots
                .add({"id": '${e["TimeSlotID"]}', "value": "${e['TimeSlot']}"});
          }
          if (timeSlots.isNotEmpty) {
            selectedTimeSlot('${timeSlots.first['id']}');
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getServiceType() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getServiceType();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          for (var e in response['RtnData']) {
            types.add({
              "id": '${e["ServiceTypeID"]}',
              "value": "${e['ServiceTypeName']}"
            });
          }
          if (types.isNotEmpty) {
            selectedType('${types.first['id']}');
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getServices() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getService();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          for (var e in response['RtnData']) {
            services.add(
                {"id": '${e["ServiceID"]}', "value": "${e['ServiceName']}"});
          }
          if (services.isNotEmpty) {
            selectedService('${services.first['id']}');
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getComplaintNature() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getComplaintNature();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          for (var e in response['RtnData']) {
            cNatures.add({
              "id": '${e["ComplaintNatureID"]}',
              "value": "${e['ComplaintNatureName']}"
            });
          }
          if (cNatures.isNotEmpty) {
            selectedCNature('${cNatures.first['id']}');
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  bookATicket() async {
    if(customerNameController.text.isEmpty &&
        customerMobileNoController.text.isEmpty &&
        selectedAddress.isEmpty&&
        selectedService.isEmpty &&
        selectedCNature.isEmpty &&
        selectedType.isEmpty &&
        selectedTimeSlot.isEmpty
    ){
      toast("Please fill all the fields");
    }else if(customerNameController.text.isEmpty){
      toast("Please Enter Customer Name");
    }else if(customerMobileNoController.text.isEmpty){
      toast("Please Enter Customer Mobile Number");
    }else if(selectedAddress.isEmpty){
      toast("Please select the address");
    }else if(selectedService.isEmpty){
      toast("Please select the service");
    }else if(selectedCNature.isEmpty){
      toast("Please select the complaint Nature ");
    }else if(selectedType.isEmpty){
      toast("Please select the service type ");
    }else if(selectedTimeSlot.isEmpty){
      toast("Please select the Timeslot");
    }else{if (await isNetConnected()) {
      try {
        debugPrint("is book called");
        isLoading(true);

        var image = "";
        if (imagePath.value.isNotEmpty) {
          //upload Image
          var response = await ApiCall().uploadAttachment([imagePath.value]);
          if (response != null) {
            if (response['RtnStatus']) {
              image = response['RtnMsg'];
            } else {
              toast('${response['RtnMsg']}');
            }
          }
        }
        image = getLastSegment(image);

        var data = {
          "TicketID": 0,
          "TicketStatusID": 0,
          "CustomerID": customer.customerID,
          "CustomerAddressID": selectedAddress.value,
          "ServiceID": selectedService.value,
          "ComplaintNatureID": selectedCNature.value,
          "ServiceTypeID": selectedType.value,
          "ServiceProviderID": 0,
          "TechnicianID": 0,
          "AppoinmentDate": toSendDateFormat(serviceDateController.text),
          "TimeSlotID": selectedTimeSlot.value,
          "Reason": "",
          "Remarks": bookingRemarksController.text.trim(),
          "Images": image,
          "CUID": _box.read(Session.userId)
        };

        var response = await ApiCall().bookATicket(data);
        isLoading(false);

        if (response != null) {
          customDialog(
              Get.context,
              response['RtnStatus']
                  ? "Booking Successful!"
                  : "Booking Unsuccessful!",
              "${response['RtnMsg']}", () {
            final con = Get.find<MainController>();
            con.getTicketCounts();
            Get.back();
          }, isDismissable: false);
        }
      } catch (e) {
        //ignore
        isLoading(false);
      }
    }}

  }
}
