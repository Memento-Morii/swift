import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift/models/location_model.dart';
import 'package:swift/services/repositories.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial());
  Repositories _repos = Repositories();
  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is FetchLocation) {
      try {
        var locationResponse = await _repos.getLocation();
        if (locationResponse.statusCode == 200) {
          List<LocationModel> _locations;
          var locationDecoded = jsonDecode(locationResponse.data);
          _locations = locationModelFromJson(jsonEncode(locationDecoded['results']));
          yield LocationLoaded(_locations);
        } else {
          print(locationResponse);
          yield LocationFailed();
        }
      } catch (_) {
        print(_);
        yield LocationFailed();
      }
    }
  }
}
