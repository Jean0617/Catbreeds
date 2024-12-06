part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final List<CatModel> data;
  final bool isLoading;
  final int page;

  const HomeState({
    this.data = const [],
    this.isLoading = false,
    this.page = 1
  });

  HomeState copyWith({
    List<CatModel>? data,
    bool? isLoading,
    int? page
  });
}

class HomeInitial extends HomeState {

  const HomeInitial({
    super.data,
    super.isLoading,
    super.page
  });

  @override
  HomeState copyWith({
    List<CatModel>? data,
    bool? isLoading,
    int? page
  }){
    return HomeInitial(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page
    );
  }
}
