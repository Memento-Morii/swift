import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:swift/models/location_model.dart';
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
        var serviceResponse = await _repos.getServices();
        var locationResponse = await _repos.getLocation();
        // print(response);
        if (serviceResponse.statusCode == 200 && locationResponse.statusCode == 200) {
          List<ServiceModel> _service;
          List<LocationModel> _locations;
          var serviceDecoded = jsonDecode(serviceResponse.data);
          _service = serviceModelFromJson(jsonEncode(serviceDecoded['results']));
          var locationDecoded = jsonDecode(locationResponse.data);
          _locations = locationModelFromJson(jsonEncode(locationDecoded['results']));
          // print(_service);
          yield AddServiceLoaded(
            service: _service,
            locations: _locations,
          );
        } else {
          print(serviceResponse);
          yield AddServiceFailed();
        }
      } catch (_) {
        print(_);
        yield AddServiceFailed();
      }
    }
  }
}
