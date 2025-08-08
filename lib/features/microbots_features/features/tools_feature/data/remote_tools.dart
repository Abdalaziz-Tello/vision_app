import 'package:vision_app/core/di_storage_listner/supabase_service.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/features/microbots_features/features/tools_feature/data/tools_model.dart';

abstract class ToolsRemoteDataSource {
  Future<List<ToolsModel>> getAllTools();
}

class ToolsRemoteDataSourceImpl implements ToolsRemoteDataSource {
  //  final SupabaseClient supabase;
  final SupabaseService supabaseService;
  ToolsRemoteDataSourceImpl({required this.supabaseService});

  @override
  Future<List<ToolsModel>> getAllTools() async {
    try {
      final result = await supabaseService.select(
        from: AppKeys.toolsKey,
        columns: '*',
      );
      print('getting  "tools in micro" form the back: $result');
      return result.map((json) => ToolsModel.fromJson(json)).toList();
    } catch (e) {
      rethrow; // Error already handled inside SupabaseService
    }
  }
}
