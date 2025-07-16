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
  Future<List<ProjectModel>> getTopCompletedProjects();
  Future<List<ProjectModel>> getProjects();
  Future<List<ProjectModel>> getProjectsByUserId(String userId);

  //  Future<void> createInvitation(InvitationModel invitation);
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
    print(
      "- Path: ${file.path}",
    ); //! maybe it have problem here //Path: blob:http://localhost:49852/345283cc-8dae-43b6-be03-2c952cce5a19
    print("- Bytes: ${file.bytes != null ? 'In memory' : 'null'}");

    Uint8List bytes;

    // Read the file bytes safely
    try {
      //  bytes = file.bytes ?? await File(file.path!).readAsBytes();
      if (file.bytes != null) {
        bytes = file.bytes!;
      } else if (file.path != null) {
        bytes = await File(file.path!).readAsBytes();
      } else {
        throw ServerException(
          errorModel: ErrorModel(
            errorMessage: "لا يمكن قراءة الملف، لا توجد بيانات أو مسار.",
          ),
        );
      }

      print("✅ File bytes loaded (${bytes.length} bytes)");
    } catch (e, stackTrace) {
      print("❌ Failed to read file bytes: $e");
      print(stackTrace);
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "تعذر قراءة الملف"),
      );
    }

    // Ensure user is authenticated
    final user = supabase.auth.currentUser;
    if (user == null) {
      print("❌ User not logged in");
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "المستخدم غير مسجل الدخول"),
      );
    }

    // Prepare file info
    final mime = lookupMimeType(file.name) ?? 'application/octet-stream';
    // final uniqueName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
    // final safeFileName = Uri.encodeComponent(file.name);
    // final path = '${user.id}/$safeFileName';

    // Get the file extension safely
    String extension = file.extension ?? 'bin'; // fallback to .bin

    // Generate a unique and safe filename
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final safeFileName = 'file_$timestamp.$extension';

    // Construct the full storage path
    final path = '${user.id}/$safeFileName';
    print("📤 Uploading to Supabase...");
    print("- MimeType: $mime");
    print("- Storage Path: $path");

    // Try to upload
    String? res;
    try {
      res = await supabase.storage
          .from('project-attachments')
          .uploadBinary(
            path,
            Uint8List.fromList(bytes),
            //   fileOptions: FileOptions(contentType: mime, upsert: true),
          );
      /*
final res = await supabase.storage.from('project-attachments').createSignedUrl(path, 60 * 60);

*/

      print("📥 Supabase response: $res");
    } catch (e, stackTrace) {
      print("❌ Upload error: $e");
      print(stackTrace);
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "فشل رفع الملف: $e"),
      );
    }

    // Validate upload result
    if (res.isEmpty) {
      print("❌ Upload failed (empty response)");
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "فشل رفع الملف"),
      );
    }

    // Generate public URL
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
          .select('''
          *,
          project_attachments (
            id,
            file_url,
            file_name,
            file_type,
            file_size,
            uploaded_at
          )
        ''')
          .eq('id', projectId)
          .maybeSingle();

      if (response == null) {
        throw ServerException(
          errorModel: ErrorModel(errorMessage: "Project not found"),
        );
      }
      print('successfully>>');
      print(response);
      return ProjectModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected: $e"),
      );
    }
  }
  //_____________________________________________________________________

  @override
  Future<List<ProjectModel>> getTopCompletedProjects() async {
    try {
      final response = await supabase
          .from('projects')
          .select('''
          *,
          project_attachments (
            id,
            file_url,
            file_name,
            file_type,
            file_size,
            uploaded_at
          )
        ''')
          .eq('is_public', true) // Only public projects
          .lte('percentage_completed', 100) // Up to 100%
          .order('percentage_completed', ascending: false) // Highest first
          .limit(3); // Top 3 only

      print('top projects : $response');
      return (response as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      print(e);
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      print(e);
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected: $e"),
      );
    }
  }

  //_____________________________________________________________
  @override
  Future<List<ProjectModel>> getProjects() async {
    try {
      final response = await supabase.from('projects').select('''
          *,
          project_attachments (
            id,
            file_url,
            file_name,
            file_type,
            file_size,
            uploaded_at
          )
        ''');

      print('all projects : $response');
      return (response as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      print(e);
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      print(e);
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected: $e"),
      );
    }
  }

  //_____________________________________________________________________
  @override
  Future<List<ProjectModel>> getProjectsByUserId(String userId) async {
    try {
      final response = await supabase
          .from('projects')
          .select('''
        *,
        project_attachments (
          id,
          file_url,
          file_name,
          file_type,
          file_size,
          uploaded_at
        )
      ''')
          .eq('created_by', userId);
      print(response);
      return (response as List).map((e) => ProjectModel.fromJson(e)).toList();
    } on PostgrestException catch (e) {
      print(e);
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    } catch (e) {
      print(e);
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "Unexpected: $e"),
      );
    }
  }

  //? get projects by user id :
  //_______________________________________________________________________
}
