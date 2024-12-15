import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/features/home/domain/entities/home_entity.dart';
import 'package:ricecare_mobile/features/home/domain/entities/disease_entity.dart';
import 'package:ricecare_mobile/features/home/domain/usecase/get_disease.dart';
import 'package:ricecare_mobile/features/home/domain/usecase/get_home_data.dart';

part 'home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeData _getHomeData;
  final GetDisease _getDisease; // Add a use case for disease data

  HomeBloc({
    required GetHomeData getHomeData,
    required GetDisease getDisease, // Inject the use case
  })  : _getHomeData = getHomeData,
        _getDisease = getDisease,
        // Assign the use case
        super(HomeInitialState()) {
    on<LoadHomeEvent>(_onHome);
    on<LoadDiseaseEvent>(_onDisease); // Handle disease loading
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

  Future<void> _onDisease(
    LoadDiseaseEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());

    try {
      final eitherResponse =
          await _getDisease(); // Use the disease use case

      eitherResponse.fold(
        (failure) => emit(HomeErrorState(failure.message)),
        (diseases) => emit(HomeDiseaseLoadedState(diseases)),
      );
    } catch (e) {
      emit(HomeErrorState('Terjadi Kesalahan tidak terduga'));
    }
  }
}
