import 'package:dio/dio.dart';
import 'package:profixer_admin/apis/urls.dart';

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

  /*Future<dynamic> sendOtp(
    String mobileNo,
    String signature,
  ) async {
    try {
      var params = {
        "MobileNo": mobileNo,
        "Signature": signature,
        "OTP": '0',
      };

      log('${_dio.options.baseUrl} $MOBILE_OTP_URL ${jsonEncode(params)}');
      final response =
          await _dio.post(MOBILE_OTP_URL, data: jsonEncode(params));
      log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');

      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }*/

}
