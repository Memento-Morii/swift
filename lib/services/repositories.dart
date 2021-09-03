import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/models/location_model.dart';
import 'package:swift/models/my_services_model.dart';
import 'package:swift/models/order_request_model.dart';
import 'package:swift/models/service_provider_request_model.dart';
import 'package:swift/models/signup_request_model.dart';
import 'package:swift/models/user_model.dart';

class Repositories {
  Dio _dio = Dio();
  static final String baseUrl = "https://swiftolio.com/api/v1";
  Options options = Options(
    followRedirects: false,
    validateStatus: (status) {
      return status < 500;
    },
  );
  Future<Options> optionsWithHeader() async {
    return Options(
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
      headers: {"Authorization": "Bearer ${await getToken()}"},
    );
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    return token;
  }
  //USER

  Future<Response> signUp({
    SignupRequest signupRequest,
  }) async {
    Map data = {
      "first_name": signupRequest.firstName,
      "last_name": signupRequest.lastName,
      "email": signupRequest.email,
      "site_name": signupRequest.siteNumber,
      "house_number": signupRequest.houseNumber,
      "block_number": signupRequest.blockNumber,
      "phone_number": signupRequest.phone,
      "lat": signupRequest.lat,
      "lng": signupRequest.lng,
      "is_service_provider": signupRequest.isServiceProvider,
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
  }) async {
    Map<String, String> data = {
      "phone_number": phone,
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
        options: await optionsWithHeader(),
      );
      // print(response);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response> updateUser({UserModel user, PlatformFile photo}) async {
    var data = FormData.fromMap({
      "first_name": user.firstName,
      "last_name": user.lastName,
      "site_name": user.siteName,
      "house_number": user.houseNumber,
      "block_number": user.blockNumber,
      "user_image": photo == null
          ? null
          : await MultipartFile.fromFile(
              photo.path,
              filename: "profile",
            ),
    });
    try {
      var response = await _dio.put(
        "$baseUrl/user/update-profile",
        data: data,
        options: await optionsWithHeader(),
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

  Future<Response> getFrequentServices() async {
    try {
      var response =
          await _dio.get("$baseUrl/service-categories/frequent-services", options: options);
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

  Future<Response> searchCategories(String searchTerm) async {
    try {
      var response = await _dio.get(
        "$baseUrl/service-categories/search-service-categories?service_category_name=$searchTerm",
        options: options,
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  Future<Response> createServiceProvider({ServiceProviderRequest request}) async {
    var data = FormData.fromMap({
      "document": request.document == null
          ? null
          : await MultipartFile.fromFile(
              request.document.path,
              filename: "document",
            ),
      "lat": request.lat,
      "lng": request.lng,
      "address": request.address,
      "price_range_from": request.priceRangeFrom,
      "price_range_to": request.priceRangeTo,
      "time_range_from": request.timeRangeFrom,
      "time_range_to": request.timeRangeTo,
      "service_id": request.serviceId,
      "service_category_id": request.serviceCategoryId,
      "description": request.description,
    });
    try {
      var response = await _dio.post(
        "$baseUrl/service-provider/create",
        data: data,
        options: await optionsWithHeader(),
      );
      print(response);
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  ///////////////////////////////////////////////////////////////////////
  /// SERVICE PROVIDER
  Future<Response> getServiceProvider(String token) async {
    try {
      var response = await _dio.get(
        "$baseUrl/service-provider/user/services",
        options: await optionsWithHeader(),
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  Future<Response> updateMyService({String token, MyServicesModel myService}) async {
    Map data = {
      'uuid': myService.uuid,
      'document': 'test',
      'lat': myService.lat,
      'lng': myService.lng,
      'address': myService.address,
      'price_range_from': myService.priceRangeFrom,
      'price_range_to': myService.priceRangeTo,
      'time_range_from': myService.timeRangeFrom,
      'time_range_to': myService.timeRangeTo,
      'service_id': myService.service.id,
      'service_category_id': myService.serviceCategory.id,
    };
    try {
      var response = await _dio.put(
        "$baseUrl/service-provider/update",
        data: data,
        options: await optionsWithHeader(),
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }
  ///////////////////////////////////////////////////////////////////////

  /// ORDERS
  Future<Response> getOrderHistory() async {
    try {
      var response = await _dio.get(
        "$baseUrl/order/user",
        options: await optionsWithHeader(),
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  Future<Response> getServiceProviderOrder() async {
    try {
      var response = await _dio.get(
        "$baseUrl/order/service-provider",
        options: await optionsWithHeader(),
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  Future<Response> createOrder(OrderRequest orderRequest, bool isAddress) async {
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
        options: await optionsWithHeader(),
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  Future<Response> declineOrder(String orderId) async {
    Map data = {"order_id": orderId};
    try {
      var response = await _dio.post(
        "$baseUrl/order/decline",
        data: data,
        options: await optionsWithHeader(),
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  Future<Response> submitPayment({
    int orderId,
    int userId,
    int serviceProviderId,
    double payment,
  }) async {
    Map data = {
      "order_id": orderId,
      "user_id": userId,
      "service_provider_id": serviceProviderId,
      "payment": payment,
    };
    try {
      var response = await _dio.post(
        "$baseUrl/order/submit-payment",
        data: data,
        options: await optionsWithHeader(),
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  Future<Response> acceptOrder(String orderId) async {
    Map data = {"order_id": orderId};
    try {
      var response = await _dio.post(
        "$baseUrl/order/accept",
        data: data,
        options: await optionsWithHeader(),
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  Future<Response> getOrderDetails(String orderId) async {
    try {
      var response = await _dio.get(
        "$baseUrl/order/detail/$orderId",
        options: await optionsWithHeader(),
      );
      return response;
    } catch (_) {
      print(_);
      return null;
    }
  }

  ///////////////////////////////////////////////////////////////////////
  ///LOCATION
  Future<Response> getLocation() async {
    try {
      var response = await _dio.get(
        "$baseUrl/location/all",
        options: await optionsWithHeader(),
      );
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<LocationModel>> searchLocation(String searchTerm) async {
    List<LocationModel> locations;
    try {
      var response = await _dio.get(
        "$baseUrl/location/search?location_name=$searchTerm",
        options: options,
      );
      if (response.statusCode == 200) {
        var locationDecoded = jsonDecode(response.data);
        locations = locationModelFromJson(jsonEncode(locationDecoded['results']));
      }
      return locations;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
