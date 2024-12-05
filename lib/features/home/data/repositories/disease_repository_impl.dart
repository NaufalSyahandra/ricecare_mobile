// // lib/features/home/data/repositories/hama_penyakit_repository.dart
// import 'package:ricecare_mobile/features/home/data/datasources/disease_remote_data_source.dart';
// import 'package:ricecare_mobile/features/home/domain/entities/disease_entity.dart';
//
// class DiseaseRepositoryImpl implements DiseaseRepository {
//   final DisRemoteDataSource remoteDataSource;
//
//   DiseaseRepository({required this.remoteDataSource});
//
//   Future<List<DiseaseEntity>> getHamaPenyakit() async {
//     try {
//       final result = await remoteDataSource.fetchDisease();
//       return result.map((model) => HamaPenyakitEntity(
//         nama: model.nama,
//         deskripsi: model.deskripsi,
//       )).toList();
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
