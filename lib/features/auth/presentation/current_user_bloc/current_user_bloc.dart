import 'package:bloc/bloc.dart';
import 'package:vision_app/features/auth/domain/auth_response.dart';
import 'package:vision_app/features/auth/domain/use_cases/get_current_user_usecase.dart';

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
    emit(CurrentUserLoading());

    final result = await getCurrentUserUseCase();

    result.fold((failure) => emit(CurrentUserFailure(failure.message)), (user) {
      if (user == null) {
        emit(CurrentUserNotLoggedIn());
      } else {
        emit(CurrentUserLoaded(user));
      }
    });
  }
}
