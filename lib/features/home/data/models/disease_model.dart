import 'package:ricecare_mobile/features/home/domain/entities/disease_entity.dart';

class DiseaseModel extends DiseaseEntity {
  const DiseaseModel({
    required super.name_disease,
    required super.description,
    required super.image_disease,
  });

  factory DiseaseModel.fromJson(Map<String, dynamic> map) {
    return DiseaseModel(
      name_disease: map['name_disease'],
      description: map['description'],
      image_disease: map['image_disease'],
    );
  }
}
