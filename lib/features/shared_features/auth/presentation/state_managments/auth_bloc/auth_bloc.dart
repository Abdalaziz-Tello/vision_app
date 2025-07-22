import 'package:bloc/bloc.dart';
import 'package:vision_app/features/shared_features/auth/domain/use_cases/sign_in_usecase.dart';
import 'package:vision_app/features/shared_features/auth/domain/use_cases/sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignUpWithEmailAndPassword signUpWithEmailAndPassword;

  AuthBloc({
    required this.signInWithEmailAndPassword,
    required this.signUpWithEmailAndPassword,
  }) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (authResponse) => emit(AuthSuccess(role: authResponse.id)),
    );
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signUpWithEmailAndPassword(
      email: event.email,
      password: event.password,
      name: event.name,
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (authResponse) => emit(AuthSuccess(role: authResponse.id)),
    );
  }
}
