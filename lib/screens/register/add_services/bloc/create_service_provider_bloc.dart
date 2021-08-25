import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/models/service_provider_request_model.dart';
import 'package:swift/services/repositories.dart';

part 'create_service_provider_event.dart';
part 'create_service_provider_state.dart';

class CreateServiceProviderBloc
    extends Bloc<CreateServiceProviderEvent, CreateServiceProviderState> {
  CreateServiceProviderBloc() : super(CreateServiceProviderInitial());
  Repositories _repos = Repositories();
  @override
  Stream<CreateServiceProviderState> mapEventToState(
    CreateServiceProviderEvent event,
  ) async* {
    if (event is CreateServiceProvider) {
      yield CreateServiceProviderLoading();
      try {
        print("Im here");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.get("token");
        print(token);
        var response = await _repos.createServiceProvider(
          request: event.request,
          token: token,
          file: null,
        );
        print(response);
        prefs.setInt("serviceProvider", 2);
        if (response.statusCode == 200) {
          print("success");
          yield CreateServiceProviderSuccess();
        } else {
          print(response);
          yield CreateServiceProviderFailed(message: response.data.toString());
        }
      } catch (_) {
        print(_);
        yield CreateServiceProviderFailed(message: _.toString());
      }
    }
  }
}
