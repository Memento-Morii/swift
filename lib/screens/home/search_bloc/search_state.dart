part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class Searching extends SearchState {}

class SearchNotFound extends SearchState {}

class SearchFound extends SearchState {
  SearchFound(this.searchResults);
  final List<ServiceCategoryModel> searchResults;
}

class Error extends SearchState {}
