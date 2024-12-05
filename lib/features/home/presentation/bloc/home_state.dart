import 'package:equatable/equatable.dart';
import '../../domain/entities/home_entity.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

// State awal
class HomeInitial extends HomeState {}

// State loading saat data sedang diambil
class HomeLoading extends HomeState {}

// State ketika data berhasil dimuat
class HomeLoaded extends HomeState {
  final HomeEntity data;

  HomeLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

// State ketika terjadi error
class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
