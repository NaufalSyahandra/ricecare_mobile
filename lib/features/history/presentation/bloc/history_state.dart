part of 'history_bloc.dart';

abstract class HistoryState {}

class HistoryInitialState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistoryLoadedState extends HistoryState {
  final List<DetectionHistory> history;

  HistoryLoadedState(this.history);
}

class HistoryDetailsLoadedState extends HistoryState {
  final Disease historyDetails;

  HistoryDetailsLoadedState(this.historyDetails);
}

class HistoryErrorState extends HistoryState {
  final String message;

  HistoryErrorState(this.message);
}
