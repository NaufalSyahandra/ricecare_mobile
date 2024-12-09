import 'package:ricecare_mobile/features/history/data/models/disease_model.dart';
import 'package:ricecare_mobile/features/history/domain/entities/detection_history.dart';

class DetectionHistoryModel extends DetectionHistory {
  DetectionHistoryModel({
    required super.disease,
    required super.prevention,
    required super.detection_date,
    required super.image_path,
  });

  factory DetectionHistoryModel.fromJson(Map<String, dynamic> map) {
    return DetectionHistoryModel(
      disease: DiseaseModel.fromJson(map['disease']),
      prevention: map['prevention'],
      detection_date: map['detection_date'],
      image_path: map['image_path'],
    );
  }
}
