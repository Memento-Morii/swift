import 'package:dio/dio.dart';
import 'package:swift/models/order_request_model.dart';
import 'package:swift/models/service_provider_request_model.dart';
import 'package:swift/models/signup_request_model.dart';
import 'package:swift/models/user_model.dart';

class Repositories {
  Dio _dio = Dio();
  final String baseUrl = "http://64.227.16.59:4000/api/v1";
  Options options = Options(
    followRedirects: false,
    validateStatus: (status) {
      return status < 500;
    },
  );

  //USER

  Future<Response> signUp({
    SignupRequest signupRequest,
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

  Future<Response> signIn({
    String phone,
    String password,
  }) async {
    Map<String, String> data = {
      "phone_number": phone,
      "password": password,
    };
    try {
      Response response = await _dio.post(
        "$baseUrl/auth/signin",
        data: data,
        options: options,
      );
      return response;
    } catch (e) {
      print(e);
      return null;
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

  Future<Response> updateUser({UserModel user, String token}) async {
    Map data = {
      "first_name": user.firstName,
      "last_name": user.lastName,
      "site_name": user.siteName,
      "house_number": user.houseNumber,
      "block_number": user.blockNumber,
    };
    try {
      var response = await _dio.put(
        "$baseUrl/user/update-profile",
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }
  ///////////////////////////////////////////////////////////////////////

  // SERVICES
  Future<Response> getServices() async {
    try {
      var response = await _dio.get("$baseUrl/service", options: options);
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  Future<Response> getServicesCategories(int serviceId) async {
    try {
      var response = await _dio.get("$baseUrl/service-categories/$serviceId", options: options);
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  Future<Response> createServiceProvider({ServiceProviderRequest request, String token}) async {
    Map data = {
      "document": request.document,
      "lat": request.lat,
      "lng": request.lng,
      "address": request.address,
      "price_range_from": request.priceRangeFrom,
      "price_range_to": request.priceRangeTo,
      "time_range_from": "2021-07-15 12:39:58",
      "time_range_to": "2021-07-15 12:39:58",
      "service_id": request.serviceId,
      "service_category_id": request.serviceCategoryId,
      "description": request.description,
    };
    try {
      var response = await _dio.post(
        "$baseUrl/service-provider/create",
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      print(response);
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  ///////////////////////////////////////////////////////////////////////

  /// ORDERS
  Future<Response> getOrderHistory(String token) async {
    try {
      var response = await _dio.get(
        "$baseUrl/order/user",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  Future<Response> createOrder(OrderRequest orderRequest, bool isAddress, String token) async {
    try {
      Map dataWithAddress = {
        "service_id": orderRequest.serviceId,
        "service_category_id": orderRequest.serviceCategoryId,
        "lat": orderRequest.lat,
        "lng": orderRequest.lng,
        "house_number": orderRequest.houseNumber,
        "site_name": orderRequest.siteName,
        "block_number": orderRequest.blockNumber,
      };
      Map dataWithOutAddress = {
        "service_id": orderRequest.serviceId,
        "service_category_id": orderRequest.serviceCategoryId,
      };
      var response = await _dio.post(
        "$baseUrl/order/create",
        data: isAddress ? dataWithAddress : dataWithOutAddress,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }
}
