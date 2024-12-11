// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:ricecare_mobile/features/scan/domain/usecases/upload_scan_usecase.dart';
//
// part 'scan_event.dart';
//
// part 'scan_state.dart';
//
// class ScanBloc extends Bloc<ScanEvent, ScanState> {
//   final UploadScanUseCase uploadScanUseCase;
//
//   ScanBloc({
//     required this.uploadScanUseCase,
//   }) : super(ScanInitial()) {
//     on<UploadScanEvent>(_onUploadScan);
//   }
//
//   Future<void> _onUploadScan(
//       UploadScanEvent event,
//       Emitter<ScanState> emit,
//       ) async {
//     emit(ScanLoading());
//     final result = await uploadScanUseCase(event.imageBytes);
//
//     result.fold(
//           (failure) => emit(ScanError(failure.message)),
//           (scan) => emit(ScanUploaded(scan)),
//     );
//   }
// }
