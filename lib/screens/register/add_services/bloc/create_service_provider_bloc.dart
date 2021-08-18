import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/models/service_provider_request_model.dart';
import 'package:swift/screens/home/home_view.dart';
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
        var response = await _repos.createServiceProvider(
          request: event.request,
          token: event.token,
        );
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setInt("serviceProvider", 2);
        if (response.statusCode == 200) {
          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        } else {
          yield CreateServiceProviderFailed(message: response.data.toString());
        }
      } catch (_) {
        yield CreateServiceProviderFailed(message: _.toString());
      }
    }
  }
}
