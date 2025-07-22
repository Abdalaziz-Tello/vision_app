class ToolsEntity {
  final String id;
  final String name;
  final String type;
  final String availabilityStatus;
//optional :
  final int? totalCount;
  final int? loanedCount;
  final String? imageUrl;

  ToolsEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.availabilityStatus,
    this.totalCount,
    this.loanedCount,
    this.imageUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ToolsEntity && id == other.id);

  @override
  int get hashCode => id.hashCode;
}
