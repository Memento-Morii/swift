part of 'service_categories_bloc.dart';

@immutable
abstract class ServiceCategoriesState {}

class ServiceCategoriesInitial extends ServiceCategoriesState {}

class ServiceCategoriesFailed extends ServiceCategoriesState {}

class ServiceCategoriesLoaded extends ServiceCategoriesState {
  ServiceCategoriesLoaded(this.categories);
  final List<ServiceCategoryModel> categories;
}
