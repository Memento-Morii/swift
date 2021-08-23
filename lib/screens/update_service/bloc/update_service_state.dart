part of 'update_service_bloc.dart';

@immutable
abstract class UpdateServiceState {}

class UpdateServiceInitial extends UpdateServiceState {}

class UpdateServiceFailed extends UpdateServiceState {}

class UpdateServiceLoading extends UpdateServiceState {}
