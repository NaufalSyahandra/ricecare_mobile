part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<HomeEntity> home;

  HomeLoadedState(this.home);
}

class HomeDiseaseLoadedState extends HomeState {
  final List<DiseaseEntity> diseases;

  HomeDiseaseLoadedState(this.diseases);
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
