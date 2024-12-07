import 'package:ricecare_mobile/features/home/domain/entities/home_entity.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    required super.total_deteksi,
    required super.sakit,
    required super.sehat,
  });

  factory HomeModel.fromJson(Map<String, dynamic> map) {
    return HomeModel(
      total_deteksi: map['total_deteksi'] as int,
      sakit: map['sakit'] as int,
      sehat: map['sehat'] as int,
    );
  }
}