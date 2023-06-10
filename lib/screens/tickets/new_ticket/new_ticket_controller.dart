import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profixer_admin/apis/api_call.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/screens/main/main_controller.dart';

import '../../../helpers/custom_dialog.dart';
import '../../../helpers/utils.dart';

class NewTicketController extends GetxController {
  RxInt currentStep = 0.obs;
  RxBool isLoading = false.obs;

  final _box = GetStorage();

  int customerId = 0;
  int customerAddressId = 0;

  RxList<Map<String, String>> cities = RxList();
  RxString selectedCity = "".obs;

  RxList<Map<String, String>> areas = RxList();
  RxString selectedArea = "".obs;

//Personal details TextEditingController
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerMobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  //Address TextEditingController
  TextEditingController customerAddressTitleController =
      TextEditingController();
  TextEditingController doorNoController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

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

  RxString amountDropDownValue = "SAR".obs;
  var amountItems = [
    'SAR',
    'RUPEES',
    'DOLLAR',
    'VAR',
  ];

  RxString mobileNoDropDownValue = "+966".obs;
  var mobileItems = [
    '+966',
    '+967',
    '+968',
    '+969',
  ];

  getArea() async {
    if (await isNetConnected()) {
      isLoading(true);
      var response = await ApiCall().getArea();
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          areas.clear();
          for (var e in response['RtnData']) {
            areas.add({"id": '${e["AreaID"]}', "value": "${e['AreaName']}"});
          }
          if (areas.isNotEmpty) {
            selectedArea('${areas.first['id']}');
          }
        } else {
          toast(response['RtnMsg']);
        }
      }
    }
  }

  getCity() async {
    if (await isNetConnected()) {
      var response = await ApiCall().getCity();
      if (response != null) {
        if (response['RtnStatus']) {
          cities.clear();
          for (var e in response['RtnData']) {
            cities.add({"id": '${e["CityID"]}', "value": "${e['CityName']}"});
          }
          if (cities.isNotEmpty) {
            selectedCity('${cities.first['id']}');
          }
        } else {
          toast(response['RtnMsg']);
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
    if (await isNetConnected()) {
      isLoading(true);

      var image = "";
      if (imagePath.isNotEmpty) {
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

      var data = {
        "TicketID": 0,
        "TicketStatusID": 0,
        "CustomerID": customerId,
        "CustomerAddressID": customerAddressId,
        "ServiceID": selectedService.value,
        "ComplaintNatureID": selectedCNature.value,
        "ServiceTypeID": selectedType.value,
        "ServiceProviderID": 0,
        "TechnicianID": 0,
        "AppoinmentDate": toSendDateFormat(serviceDateController.text.trim()),
        "TimeSlotID": selectedTimeSlot.value,
        "Reason": "",
        "Remarks": bookingRemarksController.text.trim(),
        "Images": image,
        "CUID": _box.read(Session.userId)
      };

      var response = await ApiCall().bookATicket(data);
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
      isLoading(false);
    }
  }

  saveCustomer() async {
    if (await isNetConnected()) {
      isLoading(true);
      var data = {
        "CustomerID": 0,
        "UserID": 0,
        "FirstName": customerNameController.text.trim(),
        "LastName": "",
        "MobileNumber": customerMobileNoController.text.trim(),
        "EMailID": emailController.text.trim(),
        "CurrentAddress": "",
        "DOB": toSendDateFormat(dobController.text.trim()),
        "Remarks": remarksController.text.trim(),
        "Username": customerMobileNoController.text.trim(),
        "Password": "1234",
        "IsActive": true,
        "CUID": _box.read(Session.userId)
      };

      var response = await ApiCall().insertCustomer(data);
      if (response != null) {
        if (response['RtnStatus']) {
          customerId = response['ID'];
          getArea();
          getCity();
          currentStep(1);
        } else {
          toast(response['RtnMsg']);
        }
      }
      isLoading(false);
    }
  }

  saveCustomerAddress() async {
    if (await isNetConnected()) {
      isLoading(true);
      var data = {
        "AddressID": 0,
        "CustomerID": customerId,
        "AddressTitle": customerAddressTitleController.text.trim(),
        "DoorNo": doorNoController.text.trim(),
        "StreetName": streetNameController.text.trim(),
        "CityID": selectedCity.value,
        "AreaID": selectedArea.value,
        "LandMark": landmarkController.text.trim(),
        "Latitude": "",
        "Longitude": "",
        "IsActive": true,
        "CUID": _box.read(Session.userId)
      };

      var response = await ApiCall().insertCustomerAddress(data);
      if (response != null) {
        if (response['RtnStatus']) {
          customerAddressId = response['ID'];
          getServices();
          getServiceType();
          getComplaintNature();
          getTimeSlots();
          currentStep(2);
        } else {
          toast(response['RtnMsg']);
        }
      }
      isLoading(false);
    }
  }
}
