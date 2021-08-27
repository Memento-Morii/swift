part of 'get_all_services_bloc.dart';

@immutable
abstract class GetAllServicesState {}

class GetAllServicesInitial extends GetAllServicesState {}

class GotServices extends GetAllServicesState {
  GotServices({this.allServices, this.frequentServices});
  final List<ServiceModel> allServices;
  final List<ServiceCategoryModel> frequentServices;
}

class GettingFailed extends GetAllServicesState {}
