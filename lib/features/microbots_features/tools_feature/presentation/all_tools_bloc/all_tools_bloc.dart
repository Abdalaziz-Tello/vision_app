// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:vision_app/features/microbots_features/tools_feature/domain/get_all_tools_usecas.dart';
import 'package:vision_app/features/microbots_features/tools_feature/domain/tools_entity.dart';

part 'all_tools_event.dart';
part 'all_tools_state.dart';

class AllToolsBloc extends Bloc<AllToolsEvent, AllToolsState> {
  final GetAllToolsUsecase getAllToolsUsecase;
  AllToolsBloc(this.getAllToolsUsecase) : super(AllToolsInitial()) {
    on<FetchAllTools>((event, emit) async {
      emit(AllToolsLoading());
      final res = await getAllToolsUsecase.call();
      res.fold(
        (failure) => emit(AllToolsFailure(failure.message)),
        (tools) => emit(AllToolsSuccess(tools)),
      );
    });
  }
}
