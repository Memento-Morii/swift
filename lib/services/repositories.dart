import 'package:dio/dio.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/models/signup_request_model.dart';

class Repositories {
  Dio _dio = Dio();
  final String baseUrl = "http://64.227.16.59:4000/api/v1";
  Options options = Options(
    followRedirects: false,
    validateStatus: (status) {
      return status < 500;
    },
  );

  Future<Response> signUp({
    SignupRequest signupRequest,
    // String firstName,
    // String lastName,
    // String email,
    // String siteName,
    // String houseNumber,
    // String blockNumber,
    // String phoneNumber,
    // String password,
  }) async {
    Map<String, String> data = {
      "first_name": signupRequest.firstName,
      "last_name": signupRequest.lastName,
      "email": signupRequest.email,
      "site_name": signupRequest.siteNumber,
      "house_number": signupRequest.houseNumber,
      "block_number": signupRequest.blockNumber,
      "phone_number": signupRequest.phone,
      "password": signupRequest.password,
    };
    try {
      Response response = await _dio.post(
        "$baseUrl/auth/signup",
        data: data,
        options: options,
      );
      // print(response);
      return response;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future signIn({
    String phone,
    String password,
  }) async {
    Map<String, String> data = {
      "phone_number": phone,
      "password": password,
    };
    try {
      final response = await _dio.post(
        "$baseUrl/auth/signin",
        data: data,
        options: options,
      );
      // print(response);
      return response;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<Response> getUser(String token) async {
    try {
      var response = await _dio.get(
        "$baseUrl/user/profile",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      // print(response);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response> getServices() async {
    try {
      var response = await _dio.get("$baseUrl/service/all/", options: options);
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }
}
