import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:vision_app/core/di_storage_listner/supabase_service.dart';
import 'package:vision_app/core/errors/error_model.dart';
import 'package:vision_app/core/errors/exceptions.dart';
import 'package:vision_app/core/res/keys/app_keys.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/data/models/create_project_model.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/data/models/project_domains_model.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/domain/entities/upload_file_entity.dart';

abstract class ProjectRemoteDataSource {
  //user features :
  Future<List<ProjectDomainsModel>> getAllProjectDomains();
  Future<UploadFileEntity> uploadFile(PlatformFile file);
  Future<String> createProject(CreateProjectModel model);
}

class ProjectDomainRemoteDataSourceImpl implements ProjectRemoteDataSource {
  //final SupabaseClient supabase;
 final SupabaseService supabaseService;
  ProjectDomainRemoteDataSourceImpl({required this.supabaseService});


//   //_______________________________________________________________
//   @override
//   Future<UploadFileEntity> uploadFile(PlatformFile file) async {
//     print("🚀 Starting file upload...");
//     print("📁 File Info:");
//     print("- Name: ${file.name}");
//     print("- Size: ${file.size} bytes");
//     print(
//       "- Path: ${file.path}",
//     ); //! maybe it have problem here //Path: blob:http://localhost:49852/345283cc-8dae-43b6-be03-2c952cce5a19
//     print("- Bytes: ${file.bytes != null ? 'In memory' : 'null'}");

//     Uint8List bytes;

//     // Read the file bytes safely
//     try {
//       //  bytes = file.bytes ?? await File(file.path!).readAsBytes();
//       if (file.bytes != null) {
//         bytes = file.bytes!;
//       } else if (file.path != null) {
//         bytes = await File(file.path!).readAsBytes();
//       } else {
//         throw ServerException(
//           errorModel: ErrorModel(
//             errorMessage: "لا يمكن قراءة الملف، لا توجد بيانات أو مسار.",
//           ),
//         );
//       }

//       print("✅ File bytes loaded (${bytes.length} bytes)");
//     } catch (e, stackTrace) {
//       print("❌ Failed to read file bytes: $e");
//       print(stackTrace);
//       throw ServerException(
//         errorModel: ErrorModel(errorMessage: "تعذر قراءة الملف"),
//       );
//     }

//     // Ensure user is authenticated
//     final user = supabase.auth.currentUser;
//     if (user == null) {
//       print("❌ User not logged in");
//       throw ServerException(
//         errorModel: ErrorModel(errorMessage: "المستخدم غير مسجل الدخول"),
//       );
//     }

//     // Prepare file info
//     final mime = lookupMimeType(file.name) ?? 'application/octet-stream';
//     // final uniqueName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
//     // final safeFileName = Uri.encodeComponent(file.name);
//     // final path = '${user.id}/$safeFileName';

//     // Get the file extension safely
//     String extension = file.extension ?? 'bin'; // fallback to .bin

//     // Generate a unique and safe filename
//     final timestamp = DateTime.now().millisecondsSinceEpoch;
//     final safeFileName = 'file_$timestamp.$extension';

//     // Construct the full storage path
//     final path = '${user.id}/$safeFileName';
//     print("📤 Uploading to Supabase...");
//     print("- MimeType: $mime");
//     print("- Storage Path: $path");

//     // Try to upload
//     String? res;
//     try {
//       res = await supabase.storage
//           .from(AppKeys.projectattachmentsKey)
//           .uploadBinary(
//             path,
//             Uint8List.fromList(bytes),
//             //   fileOptions: FileOptions(contentType: mime, upsert: true),
//           );
//       /*
// final res = await supabase.storage.from('project-attachments').createSignedUrl(path, 60 * 60);

// */

//       print("📥 Supabase response: $res");
//     } catch (e, stackTrace) {
//       print("❌ Upload error: $e");
//       print(stackTrace);
//       throw ServerException(
//         errorModel: ErrorModel(errorMessage: "فشل رفع الملف: $e"),
//       );
//     }

//     // Validate upload result
//     if (res.isEmpty) {
//       print("❌ Upload failed (empty response)");
//       throw ServerException(
//         errorModel: ErrorModel(errorMessage: "فشل رفع الملف"),
//       );
//     }

//     // Generate public URL
//     final url = supabase.storage
//         .from(AppKeys.projectattachmentsKey)
//         .getPublicUrl(path);
//     print("✅ Upload successful!");
//     print("🔗 Public URL: $url");

//     return UploadFileEntity(
//       fileName: file.name,
//       fileType: mime,
//       fileSize: bytes.length,
//       fileUrl: url,
//     );
//   }

  @override
  Future<List<ProjectDomainsModel>> getAllProjectDomains() async {
    print("📦 Fetching all project domains...");

    final result = await supabaseService.select(
      from: AppKeys.projectDomainsKey,
      columns: '*',
    );

    print('✅ Success: Received data from backend: $result');

    return result.map((json) => ProjectDomainsModel.fromJson(json)).toList();
  }

  //!_________________________________________________________________

  @override
  Future<String> createProject(CreateProjectModel model) async {
    print("🚀 Calling Supabase RPC 'create_project'...");
    print("📦 Payload: ${model.toJson()}");

    final result = await supabaseService.callRpc<String>(
      function: AppKeys.createProjectKey,
      params: model.toJson(),
    );

    print("✅ RPC Response: $result");
    return result;
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

    final user = supabaseService.currentUser;
    if (user == null) {
      print("❌ User not logged in");
      throw ServerException(
        errorModel: ErrorModel(errorMessage: "المستخدم غير مسجل الدخول"),
      );
    }

    // Call shared upload service
    final uploadResult = await supabaseService.uploadFile(
      file: file,
      bucket: AppKeys.projectattachmentsKey,
      userId: user.id,
    );

    print("✅ Upload successful!");
    print("🔗 Public URL: ${uploadResult.fileUrl}");

    return uploadResult;
  }
}
