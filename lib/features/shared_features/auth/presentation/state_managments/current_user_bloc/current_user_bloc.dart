import 'package:bloc/bloc.dart';
import 'package:vision_app/features/shared_features/auth/domain/auth_response.dart';
import 'package:vision_app/features/shared_features/auth/domain/use_cases/get_current_user_usecase.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;

  CurrentUserBloc({required this.getCurrentUserUseCase})
    : super(CurrentUserInitial()) {
    on<LoadCurrentUser>(_onLoadCurrentUser);
  }

  Future<void> _onLoadCurrentUser(
    LoadCurrentUser event,
    Emitter<CurrentUserState> emit,
  ) async {
    print('[CurrentUserBloc] Loading current user...');
    emit(CurrentUserLoading());

    final result = await getCurrentUserUseCase.call();

    result.fold(
      (failure) {
        print('[CurrentUserBloc] Failed: ${failure.message}');
        emit(CurrentUserFailure(failure.message));
      },
      (user) {
        if (user == null) {
          print('[CurrentUserBloc] No user found. Not logged in.');
          print(user);
          emit(CurrentUserNotLoggedIn());
        } else {
          print('[CurrentUserBloc] User loaded: ${user.email}');
          emit(CurrentUserLoaded(user));
        }
      },
    );
  }
}
