part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoaded extends LocationState {
  LocationLoaded(this.locations);
  final List<LocationModel> locations;
}

class LocationFailed extends LocationState {}
