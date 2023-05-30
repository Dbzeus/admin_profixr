import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:profixer_admin/apis/urls.dart';
import 'package:profixer_admin/main.dart';
import 'package:profixer_admin/model/MenuResponse.dart';
import 'package:profixer_admin/model/customer_response.dart';
import 'package:profixer_admin/model/ticket_count_response.dart';
import 'package:profixer_admin/model/userResponse.dart';

import '../helpers/constant_widgets.dart';

class ApiCall {
  static final ApiCall _instance = ApiCall._internal();

  static final Dio _dio = Dio();

  factory ApiCall() {
    return _instance;
  }

  ApiCall._internal() {
    _dio.options.baseUrl = baseUrl;
    // _dio.options.connectTimeout = 1000 * 60;
    _dio.interceptors.add(MyApp.alice.getDioInterceptor());
  }

  /** account Apis */
  //Login
  Future<UserDataResponse?> checkLogin(String userName, String password,
      String mobileToken, String webToken) async {
    try {
      var params = {
        "UserName": userName,
        "Password": password,
        "MobileToken": mobileToken,
        "WebToken": webToken
      };

      log(jsonEncode(params));

      final response = await _dio.post(loginUrl, data: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return UserDataResponse.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  //sendLoginOTP
  Future<dynamic> sendOTP(String mobileNo, String signature, int otp) async {
    try {
      var params = {
        "MobileNo": mobileNo,
        "Signature": signature,
        "OTP": otp,
      };

      log(jsonEncode(params));

      final response = await _dio.post(loginOtpUrl, data: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      debugPrint(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  //check Log in by mobileNumber verify otp.(this api is used for get the user details using mobile number)
  Future<UserDataResponse?> loginDetailsByMobile(
      String mobileNo, String mobileToken, String webToken) async {
    try {
      var params = {
        "MobileNo": mobileNo,
        "MobileToken": mobileToken,
        "WebToken": webToken,
      };

      log(jsonEncode(params));

      final response = await _dio.post(loginDetailsByMobileUrl, data: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return UserDataResponse.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<MenuResponse?> getMenu(int userId) async {
    try {
      var params = {
        "RoleID": userId,
      };
      final response = await _dio.get(getMenuUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return MenuResponse.fromJson(response.data);
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  /** account Apis */

  /*master apis*/
  Future<dynamic> getCountry({int countryId = 0}) async {
    try {
      var params = {
        "CountryID": countryId,
      };
      final response = await _dio.get(getCountryUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> getCity({int countryId = 0, int cityId = 0}) async {
    try {
      var params = {
        "CountryID": countryId,
        "CityID": cityId,
      };
      final response = await _dio.get(getCityUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> insertCity(var body) async {
    try {
      /*
      * {
          "CityID": 0,
          "CityName": "string",
          "CountryID": 0,
          "IsActive": true,
          "CUID": 0
        }
      * */

      final response = await _dio.post(insertCityUrl, data: body);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> getArea({int cityId = 0, int areaId = 0}) async {
    try {
      var params = {
        "AreaID": areaId,
        "CityID": cityId,
      };
      final response = await _dio.get(getAreaUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> insertArea(var body) async {
    try {
      /*
      * {
        "AreaID": 0,
        "AreaName": "string",
        "PinCode": "string",
        "CityID": 0,
        "IsActive": true,
        "CUID": 0
      }
      * */

      final response = await _dio.post(insertAreaUrl, data: body);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> getService({int serviceId = 0}) async {
    try {
      var params = {
        "ServiceID": serviceId,
      };
      final response = await _dio.get(getServiceUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> insertService(var body) async {
    try {
      /*
      *
        {
  "ServiceID": 0,
  "ServiceName": "string",
  "ServiceImg": "string",
  "Remarks": "string",
  "IsActive": true,
  "CUID": 0
}
      * */

      final response = await _dio.post(insertServiceUrl, data: body);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> getComplaintNature(
      {int serviceId = 0, int complaintNatureId = 0}) async {
    try {
      var params = {
        "ServiceID": serviceId,
        "ComplaintNatureID": complaintNatureId,
      };
      final response =
          await _dio.get(getComplaintNatureUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> insertComplaintNature(var body) async {
    try {
      /*
      *
        {
  "ComplaintNatureID": 0,
  "ServiceID": 0,
  "ComplaintNatureName": "string",
  "ComplaintNatureImg": "string",
  "Remarks": "string",
  "IsActive": true,
  "CUID": 0
}
      * */

      final response = await _dio.post(insertComplaintNatureUrl, data: body);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> getProfixerUser({int userId = 0}) async {
    try {
      var params = {
        "UserID": userId,
      };
      final response =
          await _dio.get(getProfixerUserUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> insertProfixerUser(var body) async {
    try {
      /*
      *
       {
  "UserID": 0,
  "FirstName": "string",
  "LastName": "string",
  "Desigination": "string",
  "DOB": "2023-05-24T16:16:05.411Z",
  "DOJ": "2023-05-24T16:16:05.411Z",
  "MobileNo": "string",
  "CurrentAddress": "string",
  "PermanentAddress": "string",
  "IsRelived": true,
  "RelivedDate": "2023-05-24T16:16:05.411Z",
  "RelivedReason": "string",
  "UserName": "string",
  "Password": "string",
  "IsActive": true,
  "CUID": 0
}
      * */

      final response = await _dio.post(insertProfixerUrl, data: body);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> getServiceProvider({int providerId = 0}) async {
    try {
      var params = {
        "ServiceProviderID": providerId,
      };
      final response =
          await _dio.get(getServiceProviderUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> insertServiceProvider(var body) async {
    try {
      /*
      *
       {
  "ServiceProviderID": 0,
  "ServiceProviderName": "string",
  "ContactPerson": "string",
  "ContactNumber": "string",
  "ContactMailID": "string",
  "ContactAddress": "string",
  "TaxDetails": "string",
  "BankDetails": "string",
  "ServiceIDs": "string",
  "AreaIDs": "string",
  "ContractStartDate": "2023-05-24T16:16:05.417Z",
  "ContractEndDate": "2023-05-24T16:16:05.417Z",
  "IsActive": true,
  "CUID": 0
}
      * */

      final response = await _dio.post(insertServiceProviderUrl, data: body);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> getServiceProviderService({int providerId = 0}) async {
    try {
      var params = {
        "ServiceProviderID": providerId,
      };
      final response =
          await _dio.get(getServiceProviderServiceUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> getServiceProviderArea({int providerId = 0}) async {
    try {
      var params = {
        "ServiceProviderID": providerId,
      };
      final response =
          await _dio.get(getServiceProviderAreaUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return MenuResponse.fromJson(response.data);
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  //Forget Password
  Future<dynamic> forgetPassword(
    String mobileNo,
  ) async {
    try {
      var params = {
        "MobileNo": mobileNo,
      };

      log(jsonEncode(params));

      final response =
          await _dio.post(forgetPasswordUrl, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      debugPrint(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  //Reset Password
  Future<dynamic> resetPassword(
      String mobileNo, String oldPassword, String newPassword) async {
    try {
      var params = {
        "MobileNo": mobileNo,
        "OldPwd": oldPassword,
        "NewPwd": newPassword
      };

      log(jsonEncode(params));

      final response =
          await _dio.post(resetPasswordUrl, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      debugPrint(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> insertServiceProviderTechnician(var body) async {
    try {
      /*
      *
{
  "TechnicianID": 0,
  "UserID": 0,
  "ServiceProviderID": 0,
  "FirstName": "string",
  "LastName": "string",
  "MobileNumber": "string",
  "MailID": "string",
  "ContactAddress": "string",
  "PermanentAddress": "string",
  "DOB": "2023-05-24T16:16:05.429Z",
  "DOJ": "2023-05-24T16:16:05.429Z",
  "ServiceIDs": "string",
  "AreaIDs": "string",
  "Username": "string",
  "Password": "string",
  "IsActive": true,
  "CUID": 0
}
      * */

      final response =
          await _dio.post(insertServiceProviderTechnicianUrl, data: body);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<CustomerResponse?> getProfixerCustomer({int userId = 0}) async {
    try {
      var params = {
        "UserID": userId,
      };
      final response = await _dio.get(getCustomerUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return CustomerResponse.fromJson(response.data);
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> insertProfixerCustomer(var body) async {
    try {
      /*
      *
{
  "CustomerID": 0,
  "UserID": 0,
  "FirstName": "string",
  "LastName": "string",
  "MobileNumber": "string",
  "EMailID": "string",
  "CurrentAddress": "string",
  "DOB": "2023-05-24T16:16:05.435Z",
  "Remarks": "string",
  "Username": "string",
  "Password": "string",
  "IsActive": true,
  "CUID": 0
}
      * */

      final response = await _dio.post(insertCustomerUrl, data: body);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> getCustomerAddress({int customerId = 0}) async {
    try {
      var params = {
        "CustomerID": customerId,
      };
      final response =
          await _dio.get(getCustomerAddressUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> insertCustomerAddress(var body) async {
    try {
      /*
      *
{
  "AddressID": 0,
  "CustomerID": 0,
  "AddressTitle": "string",
  "DoorNo": "string",
  "StreetName": "string",
  "CityID": 0,
  "AreaID": 0,
  "LandMark": "string",
  "Latitude": "string",
  "Longitude": "string",
  "IsActive": true,
  "CUID": 0
}
      * */

      final response = await _dio.post(insertCustomerAddressUrl, data: body);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> uploadAttachment(List<String> filePaths) async {
    debugPrint(filePaths.toString());
    try {
      var files = filePaths
          .map((e) async => await MultipartFile.fromFile(
                e,
              ))
          .toList();

      debugPrint('${files.length}');

      var data = FormData.fromMap({"files": files});

      final response = await _dio.post(uploadAttachmentUrl, data: data);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  //holiday
  Future<dynamic> getHoliday({int holidayId = 0}) async {
    try {
      var params = {
        "HolidayID": holidayId,
      };
      final response = await _dio.get(getHolidayUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> deleteHoliday(int holidayId) async {
    try {
      var params = {
        "HolidayID": holidayId,
      };
      final response =
      await _dio.get(deleteHolidayUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> insertHoliday(var body) async {
    try {
      /*
      *
{
  "HolidayID": 0,
  "HolidayDate": "2023-05-27T05:28:48.068Z",
  "Reason": "string",
  "IsFullDay": true,
  "TimeFrom": "string",
  "TimeTo": "string",
  "Remarks": "string",
  "CUID": 0
}
      * */

      final response = await _dio.post(insertHolidayUrl, data: body);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

  Future<dynamic> getTimeSlot({int timeSlotId=0}) async {
    try {
      var params = {
        "TimeSlotID": timeSlotId,
      };
      final response =
      await _dio.get(getTimeSlotUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return response.data;
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

/*end master apis*/

/*support desk*/

  Future<TicketCountResponse?> getTicketCount(
      int userId, int ticketStatusId, String fromDate, String toDate) async {
    try {
      var params = {
        "UserID": userId,
        "TicketStatusID": ticketStatusId,
        "FromDate": fromDate,
        "ToDate": toDate,
      };
      final response =
          await _dio.get(ticketCountUrl, queryParameters: params);
      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      return TicketCountResponse.fromJson(response.data);
    } on DioError catch (e) {
      log(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null);
    }
    return null;
  }

/*end of support desk*/
}
