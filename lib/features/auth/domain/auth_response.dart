// class AuthResponse {
//   final String id;// (role)

//   AuthResponse({required this.id});
// }

class AuthEntity {
  final String id;
  final String email;
  final bool isVerified;
  final String? accessToken;
  final String? refreshToken;
  final Map<String, dynamic>? userMetadata;

  const AuthEntity({
    required this.id,
    required this.email,
    required this.isVerified,
    this.accessToken,
    this.refreshToken,
    this.userMetadata,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}