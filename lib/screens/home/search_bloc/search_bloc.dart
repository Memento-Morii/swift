import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift/models/service_category_model.dart';
import 'package:swift/services/repositories.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());
  Repositories _repo = Repositories();
  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is Search) {
      yield Searching();
      try {
        if (event.searchTerm == '') {
          yield SearchInitial();
        } else {
          var response = await _repo.searchCategories(event.searchTerm);
          if (response.statusCode == 200) {
            var decoded = jsonDecode(response.data);
            if (decoded['results'] != null) {
              List<ServiceCategoryModel> searchResults =
                  serviceCategoryModelFromJson(jsonEncode(decoded['results']));
              yield SearchFound(searchResults);
            } else {
              yield SearchNotFound();
            }
          } else {
            print(response);
            yield Error();
          }
        }
      } catch (_) {
        print(_);
        yield Error();
      }
    }
  }
}
