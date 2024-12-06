part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class SearchCatsEvent extends HomeEvent{
  final String query;
  final int page;
  SearchCatsEvent(this.query,this.page);
}

class SearchCatsByRaceEvent extends HomeEvent{
  final String query;
  SearchCatsByRaceEvent(this.query);
}

class ChangePageEvent extends HomeEvent{
  final int page;
  ChangePageEvent(this.page);
}
