import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/features/home/domain/entities/home_entity.dart';
import 'package:ricecare_mobile/features/home/domain/usecase/get_home_data.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeData _getHomeData;

  HomeBloc({
    required GetHomeData getHomeData,
  }) :   _getHomeData = getHomeData,
        super(HomeInitialState()) {

    on<LoadHomeEvent>(_onHome);
  }

  Future<void> _onHome(
      LoadHomeEvent event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoadingState());

    try {
      final eitherResponse = await _getHomeData();

      eitherResponse.fold(
            (failure) => emit(HomeErrorState(failure.message)),
            (home) => emit(HomeLoadedState(home)),
      );
    } catch (e) {
      emit(HomeErrorState('Terjadi Kesalahan tidak terduga'));
    }
  }
}