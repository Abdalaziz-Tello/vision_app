import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/features/projects/data/models/create_project_model.dart';
import 'package:vision_app/features/projects/data/models/project_domains_model.dart';
import 'package:vision_app/features/projects/data/models/project_model.dart';
import 'package:vision_app/features/projects/domain/entities/upload_file_entity.dart';

abstract class ProjectRemoteDataSource {
  Future<List<ProjectDomainsModel>> getAllProjectDomains();
  Future<String> createProject(CreateProjectModel model);
  Future<UploadFileEntity> uploadFile(PlatformFile file);
  Future<ProjectModel> getProjectById(String projectId);
}

class ProjectDomainRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final SupabaseClient supabase;

  ProjectDomainRemoteDataSourceImpl({required this.supabase});

  @override
  Future<List<ProjectDomainsModel>> getAllProjectDomains() async {
    try {
      final response = await supabase.from('project_domains').select();

      final resultList = response;
      print('sucess getting the data form the back: $resultList');

      return resultList
          .map((json) => ProjectDomainsModel.fromJson(json))
          .toList();
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

  //!_________________________________________________________________

  @override
  Future<String> createProject(CreateProjectModel model) async {
    try {
      print("Calling Supabase RPC 'create_project' with:");
      print(" Payload: ${model.toJson()}");

      final result = await supabase.rpc<String>(
        'create_project',
        params: model.toJson(),
      );

      print(" RPC Response: $result");

      return result;
    } on PostgrestException catch (e) {
      print("PostgrestException: ${e.message}");
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      print("Unexpected error: $e");
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected error: $e"),
      );
    }
  }

  //_______________________________________________________________
  @override
  Future<UploadFileEntity> uploadFile(PlatformFile file) async {
    print("🚀 Starting file upload...");
    print("📁 File Info:");
    print("- Name: ${file.name}");
    print("- Size: ${file.size} bytes");
    print("- Path: ${file.path}");
    print("- Bytes: ${file.bytes != null ? 'In memory' : 'null'}");

    Uint8List bytes;

    // Step 1: Read the file bytes safely
    try {
      bytes = file.bytes ?? await File(file.path!).readAsBytes();
      print("✅ File bytes loaded (${bytes.length} bytes)");
    } catch (e, stackTrace) {
      print("❌ Failed to read file bytes: $e");
      print(stackTrace);
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "تعذر قراءة الملف"),
      );
    }

    //Step 2: Ensure user is authenticated
    final user = supabase.auth.currentUser;
    if (user == null) {
      print("❌ User not logged in");
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "المستخدم غير مسجل الدخول"),
      );
    }

    //Step 3: Prepare file info
    final mime = lookupMimeType(file.name) ?? 'application/octet-stream';
    final uniqueName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
    final path = '${user.id}/$uniqueName';

    print("📤 Uploading to Supabase...");
    print("- MimeType: $mime");
    print("- Storage Path: $path");

    //Step 4: Try to upload
    String? res;
    try {
      res = await supabase.storage
          .from('project-attachments')
          .uploadBinary(
            path,
            Uint8List.fromList(bytes),
            fileOptions: FileOptions(contentType: mime, upsert: true),
          );
      print("📥 Supabase response: $res");
    } catch (e, stackTrace) {
      print("❌ Upload error: $e");
      print(stackTrace);
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "فشل رفع الملف: $e"),
      );
    }

    // Step 5: Validate upload result
    if (res == null || res.isEmpty) {
      print("❌ Upload failed (empty response)");
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "فشل رفع الملف"),
      );
    }

    //  Step 6: Generate public URL
    final url = supabase.storage.from('project-attachments').getPublicUrl(path);
    print("✅ Upload successful!");
    print("🔗 Public URL: $url");

    return UploadFileEntity(
      fileName: file.name,
      fileType: mime,
      fileSize: bytes.length,
      fileUrl: url,
    );
  }

  //_________________________________________________________________________
  @override
  Future<ProjectModel> getProjectById(String projectId) async {
    try {
      final response = await supabase
          .from('projects')
          .select()
          .eq('id', projectId)
          .maybeSingle();
      if (response == null) {
        print('project respons null');
        throw ServerException(
          errorModel: ErrorModel(errorMessage: "Not found"),
        );
      }
      print('successfully>>');
      return ProjectModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected: $e"),
      );
    }
  }
}
