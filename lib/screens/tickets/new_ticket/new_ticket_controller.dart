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

  int successCounter = 0;
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
      var response = await ApiCall().getArea( cityId: int.parse(selectedCity.value));
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
          (response['RtnData'] as List).sort((a,b)=>a['CityName'].toString().compareTo(b['CityName']));
          for (var e in response['RtnData']) {
            if(e['IsActive']) {
              cities.add({"id": '${e["CityID"]}', "value": "${e['CityName']}"});
            }
          }
          if (cities.isNotEmpty) {
            selectedCity('${cities.first['id']}');
            getArea();
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
          timeSlots.clear();
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
          types.clear();
          for (var e in response['RtnData']) {
            types.add({
              "id": '${e["ServiceTypeID"]}',
              "value": "${e['ServiceTypeName']}"
            });
          }
          if (types.isNotEmpty) {
            selectedType('${types.first['id']}');
            getComplaintNature();
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
          services.clear();
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
      var response = await ApiCall().getComplaintNature(serviceId: int.parse(selectedService.value));
      isLoading(false);
      if (response != null) {
        if (response['RtnStatus']) {
          cNatures.clear();
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
    if(selectedService.isEmpty &&
        selectedCNature.isEmpty &&
        selectedService.isEmpty&&
        serviceDateController.text.isEmpty &&
        selectedTimeSlot.isEmpty &&
        bookingRemarksController.text.isEmpty
    ){
      toast("Please fill all the fields");
    }else if(selectedService.isEmpty){
      toast("Please Select the service");
    }else if(selectedCNature.isEmpty){
      toast("Please Select the Complaint Nature");
    }else if(selectedService.isEmpty){
      toast("Please Select the Service Type");
    }else if(serviceDateController.text.isEmpty){
      toast("Please select the service date");
    }else if(selectedTimeSlot.isEmpty){
      toast("Please select the TimeSlot");
    }else if(bookingRemarksController.text.isEmpty){
      toast("Please Enter Remarks");
    }else {
      if (await isNetConnected()) {
        try {
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
        }catch(e){
          isLoading(false);
        }
      }
    }

  }

  saveCustomer() async {
    if(customerNameController.text.isEmpty &&
        customerMobileNoController.text.isEmpty &&
        emailController.text.isEmpty&&
        customerMobileNoController.text.isEmpty &&
        dobController.text.isEmpty &&
        remarksController.text.isEmpty
    ){
      toast("Please fill all the fields");
    }else if(customerNameController.text.isEmpty){
      toast("Please Enter Customer Name");
    }else if(customerMobileNoController.text.isEmpty){
      toast("Please Enter Customer Mobile Number");
    }else if(emailController.text.isEmpty){
      toast("Please Enter Email Id");
    }else if(customerMobileNoController.text.isEmpty){
      toast("Please Enter Customer Mobile Number");
    }else if(dobController.text.isEmpty){
      toast("Please Enter date of birth");
    }else if(remarksController.text.isEmpty){
      toast("Please Enter Remarks field");
    }else{
      if (await isNetConnected()) {
        isLoading(true);
        var data = {
          "CustomerID": customerId,
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
            getCity();
            if(successCounter==0){
              successCounter=1;
            }
            currentStep(1);
          } else {
            toast(response['RtnMsg']);
          }
        }
        isLoading(false);
      }
    }

  }

  saveCustomerAddress() async {

    if(customerAddressTitleController.text.isEmpty &&
        doorNoController.text.isEmpty &&
        streetNameController.text.isEmpty&&
        selectedCity.isEmpty &&
        selectedArea.isEmpty
    ){
      toast("Please fill all the fields");
    }else if(customerAddressTitleController.text.isEmpty){
      toast("Please Enter Customer Address");
    }else if(doorNoController.text.isEmpty){
      toast("Please Enter Customer Door or Plot Number");
    }else if(streetNameController.text.isEmpty){
      toast("Please Enter Street name ");
    }else if(selectedCity.isEmpty){
      toast("Please select the city ");
    }else if(selectedArea.isEmpty){
      toast("Please select the area");
    }else{
      if (await isNetConnected()) {
        isLoading(true);
        var data = {
          "AddressID": customerAddressId,
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
            getTimeSlots();
            if(successCounter==1){
              successCounter=2;
            }
            currentStep(2);
          } else {
            toast(response['RtnMsg']);
          }
        }
        isLoading(false);
      }
    }

  }
}
