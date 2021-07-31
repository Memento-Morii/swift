import 'package:dio/dio.dart';
import 'package:swift/models/service_model.dart';

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
    String firstName,
    String lastName,
    String email,
    String siteName,
    String houseNumber,
    String blockNumber,
    String phoneNumber,
    String password,
  }) async {
    Map<String, String> data = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "site_name": siteName,
      "house_number": houseNumber,
      "block_number": blockNumber,
      "phone_number": phoneNumber,
      "password": password,
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
      print(response);
      return response;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future getUser(String token) async {
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
      print(response);
    } catch (e) {
      print(e);
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
