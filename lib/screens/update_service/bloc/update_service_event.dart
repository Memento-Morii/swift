part of 'update_service_bloc.dart';

@immutable
abstract class UpdateServiceEvent {}

class UpdateMyService extends UpdateServiceEvent {
  UpdateMyService({this.myService, this.context});
  final MyServicesModel myService;
  final BuildContext context;
}
