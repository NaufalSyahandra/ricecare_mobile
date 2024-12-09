import 'package:ricecare_mobile/features/history/domain/entities/disease.dart';

class DiseaseModel extends Disease {
  DiseaseModel({
    required super.name_disease,
    required super.symptoms,
    required super.description,
  });

  factory DiseaseModel.fromJson(Map<String, dynamic> json) {
    return DiseaseModel(
      name_disease: json['name_disease'],
      description: json['description'],
      symptoms: json['symptoms'],
    );
  }
}
