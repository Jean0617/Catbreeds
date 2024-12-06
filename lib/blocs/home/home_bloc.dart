import 'package:bloc/bloc.dart';
import 'package:catbreeds/models/cat_model.dart';
import 'package:meta/meta.dart';

import '../../services/services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<SearchCatsEvent>(_onSearchCats);
    on<SearchCatsByRaceEvent>(_onSearchCatByRace);
    on<ChangePageEvent>(_onChangePage);
  }

  Future<void> _onSearchCats(SearchCatsEvent event,Emitter<HomeState> emit) async {

    try {
      
        emit(state.copyWith(isLoading: true));

        Map response = await ServicesApi().getCats(event.page);

        if (response['status'] == 200) {

          List<CatModel> data = List.from(event.page == 1? [] : state.data);
          data.addAll(response['data']);

          emit(state.copyWith(data: data, isLoading: false));
        }else{
          emit(state.copyWith(data: [], isLoading: false));
        }
       
    } catch (e) {
      emit(state.copyWith(data: [], isLoading: false));
    }
  }

  Future<void> _onSearchCatByRace(SearchCatsByRaceEvent event,Emitter<HomeState> emit) async {

    try {
      
        emit(state.copyWith(isLoading: true));

        Map response = await ServicesApi().getCatByRace(event.query);

        if (response['status'] == 200) {

          emit(state.copyWith(data: response['data'], isLoading: false));

        }else{
          emit(state.copyWith(data: [], isLoading: false));
        }
       
    } catch (e) {
      emit(state.copyWith(data: [], isLoading: false));
    }
  }

  Future<void> _onChangePage(ChangePageEvent event,Emitter<HomeState> emit) async {
    emit(state.copyWith(page: event.page));
  }
  
}
