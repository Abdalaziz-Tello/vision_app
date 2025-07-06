part of 'current_user_bloc.dart';

abstract class CurrentUserState {}

class CurrentUserInitial extends CurrentUserState {}

class CurrentUserLoading extends CurrentUserState {}

class CurrentUserLoaded extends CurrentUserState {
  final AuthEntity user;

  CurrentUserLoaded(this.user);
}

class CurrentUserNotLoggedIn extends CurrentUserState {}

class CurrentUserFailure extends CurrentUserState {
  final String message;

  CurrentUserFailure(this.message);
}
