//rather than "Equatable" package , i used the hasCode
abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServerFailure && super == other;
  }

  @override
  int get hashCode => super.hashCode;
}
