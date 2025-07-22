import 'package:bloc/bloc.dart';
import 'package:vision_app/core/shared/entities/resources_entity/resource_request_entity.dart';
import 'package:vision_app/features/user_features/request_resources_feature/domain/usecase/submit_resource_request_usecase.dart';

part 'resource_request_event.dart';
part 'resource_request_state.dart';

class ResourceRequestBloc
    extends Bloc<ResourceRequestEvent, ResourceRequestState> {
  final SubmitResourceRequestUseCase submitUseCase;

  ResourceRequestBloc(this.submitUseCase) : super(ResourceRequestInitial()) {
    on<SubmitResourceRequest>(_onSubmitRequest);
  }

  Future<void> _onSubmitRequest(
    SubmitResourceRequest event,
    Emitter<ResourceRequestState> emit,
  ) async {
    emit(ResourceRequestLoading());

    final result = await submitUseCase(event.entity);

    result.fold(
      (failure) => emit(ResourceRequestFailure(failure.message)),
      (_) => emit(ResourceRequestSuccess()),
    );
  }
}
