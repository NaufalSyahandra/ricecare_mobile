import 'package:either_dart/either.dart';
import 'package:ricecare_mobile/core/error/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}