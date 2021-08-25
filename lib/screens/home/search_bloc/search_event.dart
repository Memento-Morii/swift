part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class Search extends SearchEvent {
  Search(this.searchTerm);
  final String searchTerm;
}
