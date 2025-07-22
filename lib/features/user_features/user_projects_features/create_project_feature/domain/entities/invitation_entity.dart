// class InvitationEntity {
//   final String id;
//   final String projectId;
//   final String invitedEmail;
//   final String invitedBy;
//   final String role;
//   final String invitationToken;
//   final DateTime expiresAt;

//   final String? invitedUserId;
//   final String? status;
//   final String? message;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   InvitationEntity({
//     required this.id,
//     required this.projectId,
//     required this.invitedEmail,
//     required this.invitedBy,
//     required this.role,
//     required this.invitationToken,
//     required this.expiresAt,
//     this.invitedUserId,
//     this.status,
//     this.message,
//     this.createdAt,
//     this.updatedAt,
//   });

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is InvitationEntity &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           invitationToken == other.invitationToken;

//   @override
//   int get hashCode => id.hashCode ^ invitationToken.hashCode;
// }
