import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/features/history/domain/entities/detection_history.dart';
import 'package:ricecare_mobile/features/history/domain/entities/disease.dart';
import 'package:ricecare_mobile/features/history/domain/usecase/get_detection_history.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetDetectionHistory _getDetectionHistory;

  HistoryBloc({
    required GetDetectionHistory getDetectionHistory,
  }) :   _getDetectionHistory = getDetectionHistory,
        super(HistoryInitialState()) {

    on<LoadHistoryEvent>(_onDetectionHistory);
  }

  Future<void> _onDetectionHistory(
      LoadHistoryEvent event,
      Emitter<HistoryState> emit,
      ) async {
    emit(HistoryLoadingState());

    try {
      final eitherResponse = await _getDetectionHistory();

      eitherResponse.fold(
            (failure) => emit(HistoryErrorState(failure.message)),
            (histories) => emit(HistoryLoadedState(histories)),
      );
    } catch (e) {
      emit(HistoryErrorState('Terjadi Kesalahan tidak terduga'));
    }
  }
}
