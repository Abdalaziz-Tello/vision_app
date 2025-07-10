// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:vision_app/core/res/app_images.dart';
// import 'package:vision_app/core/res/app_string.dart';
// import 'package:vision_app/core/res/color/app_colors.dart';
// import 'package:vision_app/core/di_storage_listner/di.dart';
// import 'package:vision_app/core/di_storage_listner/user_id.dart';
// import 'package:vision_app/core/res/keys/navigation_keys.dart';
// import 'package:vision_app/core/widgets/custom_snack_bar_function.dart';
// import 'package:vision_app/features/resources_feature/domain/entity/academic_departments_entity.dart';
// import 'package:vision_app/features/resources_feature/domain/entity/requested_resource_entity.dart';
// import 'package:vision_app/features/resources_feature/domain/entity/resource_request_entity.dart';
// import 'package:vision_app/features/resources_feature/presentation/academic_bloc/academic_bloc.dart';
// import 'package:vision_app/features/resources_feature/presentation/requested_resource_bloc/requested_resource_bloc.dart';
// import 'package:vision_app/features/resources_feature/presentation/resource_request_bloc/resource_request_bloc.dart';
// import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/custom_display_field.dart';
// import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/text_with_expansion_tile_selector.dart';
// import 'package:vision_app/core/widgets/custom_button.dart';

// class AdvancedResourcesRequestPage extends StatefulWidget {
//   final String projectId;
//   final String projectTitle;
//   //  final String projectOwner;
//   final int completedPercentage;
//   final String projectFieldId;
//   final String projectDomainName;
//   final String projectOwnerName;
//   const AdvancedResourcesRequestPage({
//     super.key,
//     required this.projectId,
//     required this.projectTitle,
//     //  required this.projectOwner,
//     required this.completedPercentage,
//     required this.projectFieldId,
//     required this.projectDomainName,
//     required this.projectOwnerName,
//   });

//   @override
//   State<AdvancedResourcesRequestPage> createState() =>
//       _AdvancedResourcesRequestPageState();
// }

// class _AdvancedResourcesRequestPageState
//     extends State<AdvancedResourcesRequestPage> {
//   String? selectedUniversity;
//   String? _selectedAcademicId;

//   String? selectedResource;
//   String? _selectedResourceId;

//   List<AcademicDepartmentsEntity> _allAcademics = [];
//   List<RequestedResourceEntity> _allResources = [];

//   @override
//   void initState() {
//     super.initState();
//     context.read<AcademicBloc>().add(GetAllAcademicsRequested());
//     context.read<ResourceBloc>().add(FetchRequestedResources());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ResourceRequestBloc, ResourceRequestState>(
//       listener: (context, state) {
//         if (state is ResourceRequestSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             //  SnackBar(content: Text("done"), backgroundColor: AppColors.green),
//             customSnackBar('تم إرسال طلبك', AppColors.green),
//           );
//           context.go(NavigationKeys.homePageKey);
//         } else if (state is ResourceRequestFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             // SnackBar(
//             //   content: Text("خطأ: ${state.message}"),
//             //   backgroundColor: AppColors.redColor,
//             // ),
//             customSnackBar(state.message, AppColors.redColor),
//           );
//         }
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.whiteColor,
//         appBar: AppBar(
//           backgroundColor: AppColors.whiteColor,
//           elevation: 0,
//           scrolledUnderElevation: 0,
//           shadowColor: AppColors.whiteColor,
//           actions: [
//             Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain),
//           ],
//         ),
//         body: Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.asset(
//               AppImages.footer,
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//             Center(
//               child: SingleChildScrollView(
//                 child: Container(
//                   margin: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: AppColors.whiteColor,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       _buildTitle().animate().fadeIn(
//                         delay: 0.1.seconds,
//                         duration: 0.2.seconds,
//                       ),
//                       const SizedBox(height: 16),
//                       _buildProjectNameField().animate().fadeIn(
//                         delay: 0.15.seconds,
//                         duration: 0.25.seconds,
//                       ),
//                       LayoutBuilder(
//                         builder: (context, constraints) {
//                           final isWide = constraints.maxWidth >= 800;
//                           return _buildDualFieldsRow(isWide);
//                         },
//                       ).animate().fadeIn(
//                         delay: 0.2.seconds,
//                         duration: 0.3.seconds,
//                       ),
//                       const SizedBox(height: 10),
//                       _buildProjectOwnerField().animate().fadeIn(
//                         delay: 0.25.seconds,
//                         duration: 0.35.seconds,
//                       ),
//                       const SizedBox(height: 10),
//                       _buildUniversityField().animate().fadeIn(
//                         delay: 0.3.seconds,
//                         duration: 0.4.seconds,
//                       ),
//                       const SizedBox(height: 10),
//                       _buildResourceField().animate().fadeIn(
//                         delay: 0.35.seconds,
//                         duration: 0.45.seconds,
//                       ),
//                       const SizedBox(height: 10),
//                       _buildUploadButton().animate().fadeIn(
//                         delay: 0.4.seconds,
//                         duration: 0.5.seconds,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTitle() {
//     return Text(
//       AppString.advancedResourcesRequest,
//       style: const TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//         color: Color(0xFF3A433E),
//       ),
//     );
//   }

//   Widget _buildProjectNameField() => CustomDisplayField(
//     title: AppString.project,
//     value: widget.projectTitle,
//     required: false,
//   );

//   Widget _buildDualFieldsRow(bool isWide) {
//     return isWide
//         ? Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(child: _buildProjectTypeField()),
//               SizedBox(width: 8),
//               Expanded(child: _buildCompletedPartOfProjectField()),
//             ],
//           )
//         : Column(
//             children: [
//               _buildProjectTypeField(),
//               _buildCompletedPartOfProjectField(),
//             ],
//           );
//   }

//   Widget _buildCompletedPartOfProjectField() => CustomDisplayField(
//     title: AppString.completedPartOfProject,
//     value: widget.completedPercentage.toString(),
//     required: false,
//   );

//   Widget _buildProjectTypeField() => CustomDisplayField(
//     title: AppString.projectField,
//     value: widget.projectDomainName,
//     required: false,
//   );

//   Widget _buildUniversityField() => BlocBuilder<AcademicBloc, AcademicState>(
//     builder: (context, state) {
//       List<String> options = [];
//       String placeholder = "اختر جهة التعليم";

//       String selectedValue = selectedUniversity ?? "";

//       if (state is AcademicLoading) {
//         options = ["جاري التحميل..."];
//         selectedValue = options.first;
//       } else if (state is AcademicSuccess) {
//         _allAcademics = state.academics;
//         if (state.academics.isEmpty) {
//           options = ["لا توجد جهات تعليم"];
//           selectedValue = options.first;
//         } else {
//           options = state.academics.map((e) => e.name).toList();
//           selectedValue = selectedUniversity ?? placeholder;
//         }
//       } else if (state is AcademicFailure) {
//         options = ["حدث خطأ، حاول مرة أخرى"];
//         selectedValue = options.first;
//       }

//       return TextWithExpansionTileSelector(
//         label: AppString.educationEntity,
//         selectedValue: selectedValue,
//         options: options,
//         onSelected: (val) {
//           if (state is AcademicSuccess) {
//             final selectedAcademic = state.academics.firstWhere(
//               (e) => e.name == val,
//               orElse: () => state.academics.first,
//             );

//             setState(() {
//               // Reset resource selection when academic changes
//               selectedResource = null;
//               _selectedResourceId = null;

//               selectedUniversity = val;
//               _selectedAcademicId = selectedAcademic.id;
//             });
//           } else {
//             context.read<AcademicBloc>().add(GetAllAcademicsRequested());
//           }
//         },
//       );
//     },
//   );

//   Widget _buildResourceField() => BlocBuilder<ResourceBloc, ResourceState>(
//     builder: (context, state) {
//       List<String> options = [];
//       String placeholder = "اختر المورد";

//       String selectedValue = selectedResource ?? placeholder;

//       if (state is ResourceLoading) {
//         options = ["جاري التحميل..."];
//         selectedValue = options.first;
//       } else if (state is ResourceSuccess) {
//         _allResources = state.resources;

//         final resourcesToShow = _selectedAcademicId == null
//             ? state.resources
//             : state.resources
//                   .where((r) => r.academicDepartmentId == _selectedAcademicId)
//                   .toList();

//         if (resourcesToShow.isEmpty) {
//           options = ["لا توجد موارد"];
//           selectedValue = options.first;
//         } else {
//           options = resourcesToShow.map((e) => e.name).toList();
//           selectedValue = selectedResource ?? placeholder;
//         }
//       } else if (state is ResourceFailure) {
//         options = ["حدث خطأ، حاول مرة أخرى"];
//         selectedValue = options.first;
//       }

//       return TextWithExpansionTileSelector(
//         label: AppString.requiredResource,
//         selectedValue: selectedValue,
//         options: options,
//         onSelected: (val) {
//           if (state is ResourceSuccess) {
//             final resourcesToSearch = _selectedAcademicId == null
//                 ? state.resources
//                 : state.resources
//                       .where(
//                         (r) => r.academicDepartmentId == _selectedAcademicId,
//                       )
//                       .toList();

//             final selected = resourcesToSearch.firstWhere(
//               (e) => e.name == val,
//               orElse: () => resourcesToSearch.first,
//             );

//             setState(() {
//               selectedResource = val;
//               _selectedResourceId = selected.id;
//             });
//           } else {
//             context.read<ResourceBloc>().add(FetchRequestedResources());
//           }
//         },
//       );
//     },
//   );

//   Widget _buildProjectOwnerField() => CustomDisplayField(
//     title: 'مالك المشروع',
//     value: widget.projectOwnerName,
//     required: false,
//   );

//   Widget _buildUploadButton() {
//     return BlocBuilder<ResourceRequestBloc, ResourceRequestState>(
//       builder: (context, state) {
//         if (state is ResourceRequestLoading) {
//           return CircularProgressIndicator(color: AppColors.navyBlue);
//         }

//         return Align(
//           alignment: Alignment.bottomRight,
//           child: CustomButton(
//             text: AppString.submitRequest,
//             width: 200,
//             fontSize: 22,
//             bgColor: const Color.fromRGBO(33, 193, 242, 1),
//             textColor: AppColors.navyBlue,
//             onTap: () {
//               if (selectedUniversity == null ||
//                   selectedResource == null ||
//                   _selectedAcademicId == null ||
//                   _selectedResourceId == null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   // const SnackBar(
//                   //   content: Text("يرجى تعبئة جميع الحقول المطلوبة"),
//                   //   backgroundColor: Colors.red,
//                   // ),
//                   customSnackBar(
//                     "يرجى تعبئة جميع الحقول المطلوبة",
//                     AppColors.redColor,
//                   ),
//                 );
//                 return;
//               }

//               final userId = sl<UserSession>().getCurrentUserId();
//               if (userId == null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   // const SnackBar(
//                   //   content: Text("لم يتم تسجيل الدخول"),
//                   //   backgroundColor: Colors.red,
//                   // ),
//                   customSnackBar("لم يتم تسجيل الدخول", AppColors.redColor),
//                 );
//                 return;
//               }

//               final entity = ResourceRequestEntity(
//                 projectId: widget.projectId,
//                 requestedBy: userId,
//                 percentageCompleted: widget.completedPercentage,
//                 projectDomainId: widget.projectFieldId,
//                 academicDepartmentId: _selectedAcademicId!,
//                 requestedResourceId: _selectedResourceId!,
//               );
//               context.read<ResourceRequestBloc>().add(
//                 SubmitResourceRequest(entity),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
