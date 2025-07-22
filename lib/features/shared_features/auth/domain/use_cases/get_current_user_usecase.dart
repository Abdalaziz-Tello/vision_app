// domain/usecases/get_current_user_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:vision_app/core/errors/failures.dart';
import 'package:vision_app/features/shared_features/auth/domain/auth_repository.dart';
import 'package:vision_app/features/shared_features/auth/domain/auth_response.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, AuthEntity?>> call() {
    return repository.getCurrentUser();
  }
}
