import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/models/my_services_model.dart';
import 'package:swift/services/repositories.dart';

part 'my_services_event.dart';
part 'my_services_state.dart';

class MyServicesBloc extends Bloc<MyServicesEvent, MyServicesState> {
  MyServicesBloc() : super(MyServicesInitial());
  Repositories _repo = Repositories();
  @override
  Stream<MyServicesState> mapEventToState(
    MyServicesEvent event,
  ) async* {
    if (event is FetchMyServices) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.get("token");
        var response = await _repo.getServiceProvider(token);

        if (response.statusCode == 200) {
          var decoded = jsonDecode(response.data);
          // print(decoded);
          List<MyServicesModel> myServices =
              myServicesModelFromJson(jsonEncode(decoded['results']));
          yield MyServicesLoaded(myServices);
        } else {
          print(response);
          yield MyServicesFailed();
        }
      } catch (_) {
        print(_);
        yield MyServicesFailed();
      }
    }
  }
}
