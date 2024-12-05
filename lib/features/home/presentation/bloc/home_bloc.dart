import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../domain/usecase/get_home_data.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeData getHomeData;

  HomeBloc(this.getHomeData) : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        final data = await getHomeData();
        emit(HomeLoaded(data));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
