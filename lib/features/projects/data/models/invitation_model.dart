/*
id uuid
project_id uuid
invited_email text
invited_by uuid
role text
invitation_token uuid
expires_at timestamp

//optional :
invited_user_id uuid
status text
message text
created_at timestamp
updated_at timestamp
------------------------------------------------------------------
//1. إنشاء الدعوة : CreateInvitationUseCase → create  token > https://yourapp.com/invite/abc-123
//2. إرسال الرابط : share_plus
//3. فتح الرابط : token في Flutter Web
//4. عرض تفاصيل الدعوة : استعلام Supabase
//5. قبول الدعوة	: تحديث status + إضافة لجدول المشروع
-----------------------------------------------------------------

* what i understand :
first i need to insert a row in the table , by inserting it i will create the token

this token will be in the url , but i don't understand how you know the link ?

then after creating the link using "share_plus" , we will send it to the email i have written ?

the senario for me (as the creater of the project ends right ?)>>>>//

then here the senario for the person i sent the email for him started

if he tap into the link , it will opens the app , then it will shows  (so get ) the details of the invitation ,

if he accept it it will update something ?

-------------------------------------------------------------------
? in the backend it suppose that the perosn agree ?! , shall we add something that will add him only if he accept , or it will be a function

? 2. shall i make the invitation as saperated feature ?


*/

// import 'package:vision_app/features/projects/domain/entities/invitation_entity.dart';

// class InvitationModel {
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

//   InvitationModel({
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

//   factory InvitationModel.fromJson(Map<String, dynamic> json) {
//     return InvitationModel(
//       id: json['id'],
//       projectId: json['project_id'],
//       invitedEmail: json['invited_email'],
//       invitedBy: json['invited_by'],
//       role: json['role'],
//       invitationToken: json['invitation_token'],
//       expiresAt: DateTime.parse(json['expires_at']),
//       invitedUserId: json['invited_user_id'],
//       status: json['status'],
//       message: json['message'],
//       createdAt: json['created_at'] != null
//           ? DateTime.tryParse(json['created_at'])
//           : null,
//       updatedAt: json['updated_at'] != null
//           ? DateTime.tryParse(json['updated_at'])
//           : null,
//     );
//   }

//   InvitationEntity toEntity() {
//     return InvitationEntity(
//       id: id,
//       projectId: projectId,
//       invitedEmail: invitedEmail,
//       invitedBy: invitedBy,
//       role: role,
//       invitationToken: invitationToken,
//       expiresAt: expiresAt,
//       invitedUserId: invitedUserId,
//       status: status,
//       message: message,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//     );
//   }
// }
