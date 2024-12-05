import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event untuk memuat data awal di halaman Home
class LoadHomeData extends HomeEvent {}
