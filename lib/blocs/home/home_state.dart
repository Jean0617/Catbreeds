part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final List<CatModel> data;
  final bool isLoading;
  final bool isLoadingMore;
  final int page;

  const HomeState({
    this.data = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.page = 1
  });

  HomeState copyWith({
    List<CatModel>? data,
    bool? isLoading,
    bool? isLoadingMore,
    int? page
  });
}

class HomeInitial extends HomeState {

  const HomeInitial({
    super.data,
    super.isLoading,
    super.isLoadingMore,
    super.page
  });

  @override
  HomeState copyWith({
    List<CatModel>? data,
    bool? isLoading,
    bool? isLoadingMore,
    int? page
  }){
    return HomeInitial(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      page: page ?? this.page
    );
  }
}
