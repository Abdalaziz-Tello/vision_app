import 'package:vision_app/features/auth/domain/auth_response.dart';

class AuthResponseModel extends AuthResponse {
  AuthResponseModel({required super.id});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(id: json['id']);
  }
}
