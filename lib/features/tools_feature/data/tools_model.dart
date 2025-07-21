import 'package:vision_app/features/tools_feature/domain/tools_entity.dart';

class ToolsModel {
  final String id;
  final String name;
  final String type;
  final String availabilityStatus;

  final int? totalCount;
  final int? loanedCount;
  final String? imageUrl;

  ToolsModel({
    required this.id,
    required this.name,
    required this.type,
    required this.availabilityStatus,
    this.totalCount,
    this.loanedCount,
    this.imageUrl,
  });

  factory ToolsModel.fromJson(Map<String, dynamic> json) {
    return ToolsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      availabilityStatus: json['availability_status'] as String,
      totalCount: json['total_count'] as int?,
      loanedCount: json['loaned_count'] as int?,
      imageUrl: json['image_url'] as String?,
    );
  }

  ToolsEntity toEntity() {
    return ToolsEntity(
      id: id,
      name: name,
      type: type,
      availabilityStatus: availabilityStatus,
      totalCount: totalCount,
      loanedCount: loanedCount,
      imageUrl: imageUrl,
    );
  }
}
