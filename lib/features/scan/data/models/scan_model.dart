import 'package:ricecare_mobile/features/scan/domain/entities/scan.dart';

class ScanModel extends Scan {
  ScanModel({
    required super.name_disease,
    required super.prevention,
    required super.symptoms,
    required super.image_path,
  });

  // Factory constructor to convert JSON to ScanModel
  factory ScanModel.fromJson(Map<String, dynamic> map) {
    return ScanModel(
      name_disease: map['name_disease'],
      prevention: map['prevention'],
      symptoms: map['symptoms'],
      image_path: map['image_path'],
    );
  }
}
