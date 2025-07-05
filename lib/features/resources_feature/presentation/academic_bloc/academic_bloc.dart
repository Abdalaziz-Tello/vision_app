import 'package:bloc/bloc.dart';
import 'package:vision_app/features/resources_feature/domain/entity/academic_departments_entity.dart';
import 'package:vision_app/features/resources_feature/domain/usecase/get_all_academics_usecase.dart';

part 'academic_event.dart';
part 'academic_state.dart';

class AcademicBloc extends Bloc<AcademicEvent, AcademicState> {
  final GetAllAcademicsUseCase useCase;

  AcademicBloc(this.useCase) : super(AcademicInitial()) {
    on<GetAllAcademicsRequested>(_onRequested);
  }

  Future<void> _onRequested(
    GetAllAcademicsRequested event,
    Emitter<AcademicState> emit,
  ) async {
    emit(AcademicLoading());

    final result = await useCase();

    result.fold(
      (failure) => emit(AcademicFailure(failure.message)),
      (academics) => emit(AcademicSuccess(academics)),
    );
  }
}
