import 'package:ricecare_mobile/features/history/domain/entities/disease.dart';

class DetectionHistory {
  final Disease disease;
  final String prevention;
  final String detection_date;
  final String image_path;

  const DetectionHistory({
    required this.disease,
    required this.prevention,
    required this.detection_date,
    required this.image_path,
  });
}