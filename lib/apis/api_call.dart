import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:profixer_admin/apis/urls.dart';

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
    // _dio.interceptors.add(MyApp.alice.getDioInterceptor());
  }

  //Login
  Future<dynamic> checkLogin(String userName, String password, String mobileToken,String webToken) async {
    try {
      var params = {"UserName": userName, "Password": password, "MobileToken": mobileToken, "WebToken": webToken};

      log(jsonEncode(params));

      final response = await _dio.post(loginUrl, data: params);

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


  //sendLoginOTP
  Future<dynamic> sendOTP(String mobileNo, String signature, int otp) async {
    try {
      var params = {"MobileNo": mobileNo, "Signature": signature, "OTP": otp, };

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
  Future<dynamic> loginDetailsByMobile(String mobileNo, String mobileToken,String webToken) async {
    try {
      var params = {"MobileNo": mobileNo, "MobileToken": mobileToken, "WebToken": webToken, };

      log(jsonEncode(params));

      final response = await _dio.post(loginDetailsByMobileUrl, data: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} $params ${response.data}');

      return response.data;
    } on DioError catch (e) {
      debugPrint(e.message);
      toast(e.message);
    } catch (e) {
      log(e.toString());
      toast(null) ;
    }
    return null;
  }

  Future<dynamic> getMenu(int userId) async {
    try {

      var params = {
        "RoleID": userId,

      };
      final response = await _dio.get(getMenuUrl, queryParameters: params);
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


}
