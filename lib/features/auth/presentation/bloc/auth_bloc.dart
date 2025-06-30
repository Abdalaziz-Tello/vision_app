import 'package:bloc/bloc.dart';
import 'package:vision_app/features/auth/domain/sign_in_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailAndPassword signInWithEmailAndPassword;

  AuthBloc(this.signInWithEmailAndPassword) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
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
}
