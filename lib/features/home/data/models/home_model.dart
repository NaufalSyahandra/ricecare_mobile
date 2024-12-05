import '../../domain/entities/home_entity.dart';

class HomeModel extends HomeEntity {
  const HomeModel({
    required super.detected,
    required super.healthy,
    required super.infected,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      detected: json['detected'] as int,
      healthy: json['healthy'] as int,
      infected: json['infected'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'detected': detected,
      'healthy': healthy,
      'infected': infected,
    };
  }
}
