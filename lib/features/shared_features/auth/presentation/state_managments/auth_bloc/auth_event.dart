part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({required this.email, required this.password});
}

//_________________________________________________________
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  SignUpRequested({
    required this.email,
    required this.password,
    required this.name,
  });
}
