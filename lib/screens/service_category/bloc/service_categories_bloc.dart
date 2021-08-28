import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift/models/service_category_model.dart';
import 'package:swift/services/repositories.dart';

part 'service_categories_event.dart';
part 'service_categories_state.dart';

class ServiceCategoriesBloc extends Bloc<ServiceCategoriesEvent, ServiceCategoriesState> {
  ServiceCategoriesBloc() : super(ServiceCategoriesInitial());
  Repositories _repo = Repositories();
  @override
  Stream<ServiceCategoriesState> mapEventToState(
    ServiceCategoriesEvent event,
  ) async* {
    if (event is FetchServiceCategories) {
      try {
        var response = await _repo.getServicesCategories(event.serviceId);
        if (response.statusCode == 200) {
          var decoded = jsonDecode(response.data);
          var encoded = jsonEncode(decoded['results']);
          // print(encoded);
          List<ServiceCategoryModel> categories = serviceCategoryModelFromJson(encoded);
          if (categories.length == 0) {
            yield ServiceCategoriesEmpty();
          } else {
            yield ServiceCategoriesLoaded(categories);
          }
        }
      } catch (_) {
        print(_);
        yield ServiceCategoriesFailed();
      }
    }
  }
}
