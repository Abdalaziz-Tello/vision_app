import 'package:vision_app/core/errors/error_model.dart';

class NoConnectionException implements Exception {}

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});

  String get errorMessage => errorModel.errorMessage;
}

class EmptyCacheException implements Exception {}

