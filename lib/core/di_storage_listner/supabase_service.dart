import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/entities/upload_file_entity.dart';

class SupabaseService {
  final SupabaseClient client;

  SupabaseService(this.client);

  /// SELECT
  Future<List<Map<String, dynamic>>> select({
    required String from,
    required String columns,
    Map<String, dynamic>? filters,
    List<OrderByClause>? orderBy,
    int? limit,
  }) async {
    try {

      final baseQuery = client.from(from);
      dynamic query = baseQuery.select(columns);


      filters?.forEach((key, value) {
        query = query.eq(key, value);
      });


      if (orderBy != null) {
        for (var order in orderBy) {
          query = (query as PostgrestTransformBuilder).order(
            order.column,
            ascending: order.ascending,
          );
        }
      }


      if (limit != null) {
        query = query.limit(limit);
      }

      final response = await query;

      return (response as List).cast<Map<String, dynamic>>();
    } on PostgrestException catch (e) {
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected: $e"),
      );
    }
  }

  /// INSERT
  Future<void> insert({
    required String into,
    required Map<String, dynamic> data,
  }) async {
    try {
      await client.from(into).insert(data);
    } on PostgrestException catch (e) {
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected: $e"),
      );
    }
  }

  /// RPC
  Future<T> callRpc<T>({
    required String function,
    required Map<String, dynamic> params,
  }) async {
    try {
      final result = await client.rpc<T>(function, params: params);
      return result;
    } on PostgrestException catch (e) {
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected: $e"),
      );
    }
  }

  /// Upload File to Supabase Storage
  Future<UploadFileEntity> uploadFile({
    required PlatformFile file,
    required String bucket,
    required String userId,
  }) async {
    try {
      final bytes = await _readBytes(file);

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = file.extension ?? 'bin';
      final safeFileName = 'file_$timestamp.$extension';
      final path = '$userId/$safeFileName';

      await client.storage.from(bucket).uploadBinary(path, bytes);

      final url = client.storage.from(bucket).getPublicUrl(path);

      return UploadFileEntity(
        fileName: file.name,
        fileType: lookupMimeType(file.name) ?? 'application/octet-stream',
        fileSize: bytes.length,
        fileUrl: url,
      );
    } catch (e) {
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "فشل رفع الملف: $e"),
      );
    }
  }

  Future<Uint8List> _readBytes(PlatformFile file) async {
    if (file.bytes != null) return file.bytes!;
    if (file.path != null) return await File(file.path!).readAsBytes();
    throw ServerException(
      errorModel: ErrorModel(errorMessage: "لا يمكن قراءة الملف"),
    );
  }

  /// Get current user
  User? get currentUser => client.auth.currentUser;
}


//MODEL :
//______________________________________________________
class OrderByClause {
  final String column;
  final bool ascending;

  OrderByClause({required this.column, this.ascending = true});
}
