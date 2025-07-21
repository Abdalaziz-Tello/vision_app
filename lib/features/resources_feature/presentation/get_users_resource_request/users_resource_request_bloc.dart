import 'package:bloc/bloc.dart';
import 'package:vision_app/features/resources_feature/domain/entity/resource_request_entity.dart';
import 'package:vision_app/features/resources_feature/domain/usecase/get_users_resource_request.dart';

part 'users_resource_request_event.dart';
part 'users_resource_request_state.dart';

class UsersResourceRequestBloc
    extends Bloc<UsersResourceRequestEvent, UsersResourceRequestState> {
  final GetUsersResourceRequest getUsersResourceRequest;
  UsersResourceRequestBloc({required this.getUsersResourceRequest})
    : super(UsersResourceRequestInitial()) {
    on<FetchUsersResourceRequestEvent>((event, emit) async {
      emit(UsersResourceRequestLoading());

      final result = await getUsersResourceRequest.call();

      result.fold(
        (failure) => emit(UsersResourceRequestFailure(failure.message)),
        (academics) => emit(UsersResourceRequestSuccess(academics)),
      );
    });
  }
}
