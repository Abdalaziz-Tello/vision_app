import 'package:bloc/bloc.dart';
import 'package:vision_app/features/user_features/request_resources_feature/domain/entity/requested_resource_entity.dart';
import 'package:vision_app/features/user_features/request_resources_feature/domain/usecase/get_requested_resources_usecase.dart';

part 'requested_resource_event.dart';
part 'requested_resource_state.dart';

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final GetRequestedResourcesUseCase useCase;

  ResourceBloc(this.useCase) : super(ResourceInitial()) {
    on<FetchRequestedResources>(_onFetchResources);
  }

  Future<void> _onFetchResources(
    FetchRequestedResources event,
    Emitter<ResourceState> emit,
  ) async {
    emit(ResourceLoading());

    final result = await useCase(departmentId: event.departmentId);

    result.fold(
      (failure) => emit(ResourceFailure(failure.message)),
      (resources) => emit(ResourceSuccess(resources)),
    );
  }
}
