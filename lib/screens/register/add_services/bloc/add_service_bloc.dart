import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/services/repositories.dart';

part 'add_service_event.dart';
part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  AddServiceBloc() : super(AddServiceInitial());
  Repositories _repos = Repositories();
  @override
  Stream<AddServiceState> mapEventToState(
    AddServiceEvent event,
  ) async* {
    if (event is FetchServices) {
      try {
        var response = await _repos.getServices();
        // print(response);
        if (response.statusCode == 200) {
          List<ServiceModel> _service;
          var decoded = jsonDecode(response.data);
          _service = serviceModelFromJson(jsonEncode(decoded['results']));
          // print(_service);
          yield AddServiceLoaded(_service);
        } else {
          print(response);
          yield AddServiceFailed();
        }
      } catch (_) {
        print(_);
        yield AddServiceFailed();
      }
    }
  }
}
