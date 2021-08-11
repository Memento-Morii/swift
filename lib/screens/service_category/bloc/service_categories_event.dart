part of 'service_categories_bloc.dart';

@immutable
abstract class ServiceCategoriesEvent {}

class FetchServiceCategories extends ServiceCategoriesEvent {
  FetchServiceCategories(this.serviceId);
  final int serviceId;
}
