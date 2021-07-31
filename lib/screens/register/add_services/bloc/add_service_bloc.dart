import 'dart:async';

import 'package:bloc/bloc.dart';
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
          ServiceModel _service;
          _service = serviceModelFromJson(response.data);
          yield AddServiceLoaded(_service);
        } else {
          yield AddServiceFailed();
        }
      } catch (_) {
        yield AddServiceFailed();
      }
    }
  }
}
