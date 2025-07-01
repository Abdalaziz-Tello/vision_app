// features/auth/data/models/auth_response_model.dart

import 'package:vision_app/features/auth/domain/auth_response.dart';

class AuthResponseModel {
  final String id;
  final String email;
  final bool isVerified;
  final String? accessToken;
  final String? refreshToken;
  final Map<String, dynamic>? userMetadata;

  AuthResponseModel({
    required this.id,
    required this.email,
    required this.isVerified,
    this.accessToken,
    this.refreshToken,
    this.userMetadata,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      id: json['id'] as String,
      email: json['email'] as String,
      isVerified: json['is_verified'] as bool? ?? false,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      userMetadata: json['user_metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'is_verified': isVerified,
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'user_metadata': userMetadata,
      };

  // Convert model to entity
  AuthEntity toEntity() => AuthEntity(
        id: id,
        email: email,
        isVerified: isVerified,
        accessToken: accessToken,
        refreshToken: refreshToken,
        userMetadata: userMetadata,
      );
}