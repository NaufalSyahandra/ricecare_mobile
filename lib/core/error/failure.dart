class Failure {
  final String message;

  Failure([this.message = '']);

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {}

class UsernameAlreadyExistsFailure extends Failure {
  List<Object> get props => [];
}

class EmailAlreadyExistsFailure extends Failure {
  List<Object> get props => [];
}
