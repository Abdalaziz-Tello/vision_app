import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/features/microbots_features/tools_feature/data/tools_model.dart';

abstract class ToolsRemoteDataSource {
  Future<List<ToolsModel>> getAllTools();
}

class ToolsRemoteDataSourceImpl implements ToolsRemoteDataSource {
  final SupabaseClient supabase;
  ToolsRemoteDataSourceImpl({required this.supabase});

  @override
  Future<List<ToolsModel>> getAllTools() async {
    try {
      final response = await supabase.from('tools').select();

      final resultList = response;
      print('sucess getting  "tools" form the back: $resultList');

      return resultList.map((json) => ToolsModel.fromJson(json)).toList();
    } on PostgrestException catch (e) {
      print(e);
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      print(e);
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected error: $e"),
      );
    }
  }
}
