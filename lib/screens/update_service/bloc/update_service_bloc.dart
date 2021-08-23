import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/my_services_model.dart';
import 'package:swift/services/repositories.dart';

part 'update_service_event.dart';
part 'update_service_state.dart';

class UpdateServiceBloc extends Bloc<UpdateServiceEvent, UpdateServiceState> {
  UpdateServiceBloc() : super(UpdateServiceInitial());
  Repositories _repo = Repositories();
  @override
  Stream<UpdateServiceState> mapEventToState(
    UpdateServiceEvent event,
  ) async* {
    if (event is UpdateMyService) {
      yield UpdateServiceLoading();
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.get("token");
        var response = await _repo.updateMyService(token: token, myService: event.myService);
        if (response.statusCode == 200) {
          Utils.showToast(event.context, false, "Updated", 2);
          yield UpdateServiceInitial();
        } else {
          Utils.showToast(event.context, true, "Error", 2);
          yield UpdateServiceInitial();
        }
      } catch (_) {
        print(_);
        yield UpdateServiceFailed();
      }
    }
  }
}
