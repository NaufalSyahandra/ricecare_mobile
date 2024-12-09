part of 'history_bloc.dart';

abstract class HistoryEvent {}

class LoadHistoryEvent extends HistoryEvent {}

class LoadHistoryDetailEvent extends HistoryEvent {}