import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/storage/di.dart';
import 'package:vision_app/core/storage/user_id.dart';
import 'package:vision_app/features/resources_feature/domain/entity/resource_request_entity.dart';
import 'package:vision_app/features/resources_feature/presentation/academic_bloc/academic_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/requested_resource_bloc/requested_resource_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/resource_request_bloc/resource_request_bloc.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/custom_display_field.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/text_with_expansion_tile_selector.dart';
import 'package:vision_app/features/view/widgets/custom_button.dart';

class AdvancedResourcesRequestPage extends StatefulWidget {
  final String projectId;
  final String projectTitle;
  //  final String projectOwner;
  final int completedPercentage;
  final String projectFieldId;
  const AdvancedResourcesRequestPage({
    super.key,
    required this.projectId,
    required this.projectTitle,
    //  required this.projectOwner,
    required this.completedPercentage,
    required this.projectFieldId,
  });

  @override
  State<AdvancedResourcesRequestPage> createState() =>
      _AdvancedResourcesRequestPageState();
}

class _AdvancedResourcesRequestPageState
    extends State<AdvancedResourcesRequestPage> {
  String? selectedUniversity;
  String? _selectedAcademicId;

  String? selectedResource;
  String? _selectedResourceId;

  @override
  void initState() {
    super.initState();
    context.read<AcademicBloc>().add(GetAllAcademicsRequested());
    context.read<ResourceBloc>().add(FetchRequestedResources());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        //   automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: AppColors.whiteColor,
        //  title: const SizedBox(),
        actions: [Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain)],
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.footer,
            fit: BoxFit.cover,
            width: double.infinity,
          ),

          Center(
            child: SingleChildScrollView(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: AppColors.whiteColor,
                insetPadding: const EdgeInsets.all(30),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTitle(),
                      const SizedBox(height: 16),
                      _buildProjectNameField(),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth >= 800;
                          return _buildDualFieldsRow(isWide);
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildProjectOwnerField(),
                      const SizedBox(height: 10),
                      _buildUniversityField(),
                      const SizedBox(height: 10),
                      _buildResourceField(),
                      const SizedBox(height: 10),
                      _buildUploadButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppString.advancedResourcesRequest,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF3A433E),
      ),
    );
  }

  Widget _buildProjectNameField() => CustomDisplayField(
    title: AppString.project,
    value: widget.projectTitle,
    required: false,
  );

  Widget _buildDualFieldsRow(bool isWide) {
    return isWide
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildProjectTypeField()),
              SizedBox(width: 8),
              Expanded(child: _buildCompletedPartOfProjectField()),
            ],
          )
        : Column(
            children: [
              _buildProjectTypeField(),
              _buildCompletedPartOfProjectField(),
            ],
          );
  }

  Widget _buildCompletedPartOfProjectField() => CustomDisplayField(
    title: AppString.completedPartOfProject,
    value: widget.completedPercentage.toString(),
    required: false,
  );

  Widget _buildProjectTypeField() => CustomDisplayField(
    title: AppString.projectField,
    value: "برمجة ويب",//TODO : i have the ID not the name
    required: false,
  ); //TODO : make it static caming from the privous page or backend
  // //TODO : options from back
  // Widget _buildUniversityField() => TextWithExpansionTileSelector(
  //   label: AppString.educationEntity,
  //   selectedValue: selectedUniversity ?? 'اختر جهة التعليم',
  //   options: ['جامعة الملك سعود', 'جامعة الأمير سلطان', 'جامعة جدة', 'أخرى'],
  //   onSelected: (val) => setState(() => selectedUniversity = val),
  // );

  Widget _buildUniversityField() => BlocBuilder<AcademicBloc, AcademicState>(
    builder: (context, state) {
      List<String> options = [];
      String placeholder = "اختر جهة التعليم";

      // Initial selected value
      String selectedValue = selectedUniversity ?? "";

      if (state is AcademicLoading) {
        options = ["جاري التحميل..."];
        selectedValue = options.first;
      } else if (state is AcademicSuccess) {
        if (state.academics.isEmpty) {
          options = ["لا توجد جهات تعليم"];
          selectedValue = options.first;
        } else {
          options = state.academics.map((e) => e.name).toList();
          selectedValue =
              selectedUniversity ??
              placeholder; // <-- show placeholder only after success
        }
      } else if (state is AcademicFailure) {
        options = ["حدث خطأ، حاول مرة أخرى"];
        selectedValue = options.first;
      }

      return TextWithExpansionTileSelector(
        label: AppString.educationEntity,
        selectedValue: selectedValue,
        options: options,
        onSelected: (val) {
          if (state is AcademicSuccess) {
            final selectedAcademic = state.academics.firstWhere(
              (e) => e.name == val,
              orElse: () => state.academics.first,
            );

            setState(() {
              selectedUniversity = val;
              _selectedAcademicId = selectedAcademic.id;
              print('_selectedAcademicId: $_selectedAcademicId');
              context.read<ResourceBloc>().add(
                FetchRequestedResources(departmentId: _selectedAcademicId),
              );
            });
          } else {
            context.read<AcademicBloc>().add(GetAllAcademicsRequested());
          }
        },
      );
    },
  );

  // Widget _buildResourceField() => TextWithExpansionTileSelector(
  //   label: AppString.requiredResource,
  //   selectedValue: selectedResource ?? 'اختر المورد',
  //   options: ['حاسب خارق', 'خادم سحابي', 'دعم مالي', 'تخزين سحابي', 'أخرى'],
  //   onSelected: (val) => setState(() => selectedResource = val),
  // );

  Widget _buildResourceField() => BlocBuilder<ResourceBloc, ResourceState>(
    builder: (context, state) {
      List<String> options = [];
      String placeholder = "اختر المورد";

      String selectedValue = selectedResource ?? "";

      if (state is ResourceLoading) {
        options = ["جاري التحميل..."];
        selectedValue = options.first;
      } else if (state is ResourceSuccess) {
        if (state.resources.isEmpty) {
          options = ["لا توجد موارد"];
          selectedValue = options.first;
        } else {
          options = state.resources.map((e) => e.name).toList();
          selectedValue = selectedResource ?? placeholder;
        }
      } else if (state is ResourceFailure) {
        options = ["حدث خطأ، حاول مرة أخرى"];
        selectedValue = options.first;
      }

      return TextWithExpansionTileSelector(
        label: AppString.requiredResource,
        selectedValue: selectedValue,
        options: options,
        onSelected: (val) {
          if (state is ResourceSuccess) {
            final selected = state.resources.firstWhere(
              (e) => e.name == val,
              orElse: () => state.resources.first,
            );

            setState(() {
              selectedResource = val;
              _selectedResourceId = selected.id;
              print('_selectedResourceId: $_selectedResourceId');
            });
          } else {
            print('else');
            context.read<ResourceBloc>().add(
              FetchRequestedResources(departmentId: _selectedAcademicId),
            );
          }
        },
      );
    },
  );

  Widget _buildProjectOwnerField() => CustomDisplayField(
    title: 'مالك المشروع',
    value: 'اسم صاحب المشروع',
    required: false,
  );

  //TODO :make the buttons in the hole app the same (DONE)
  Widget _buildUploadButton() {
    return BlocBuilder<ResourceRequestBloc, ResourceRequestState>(
      builder: (context, state) {
        if (state is ResourceRequestLoading) {
          return CircularProgressIndicator(color: AppColors.navyBlue);
        }

        return Align(
          alignment: Alignment.bottomRight,
          child: CustomButton(
            text: AppString.submitRequest,
            width: 200,
            fontSize: 22,
            bgColor: const Color.fromRGBO(33, 193, 242, 1),
            textColor: AppColors.navyBlue,
            onTap: () {
              if (selectedUniversity == null ||
                  selectedResource == null ||
                  _selectedAcademicId == null ||
                  _selectedResourceId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("يرجى تعبئة جميع الحقول المطلوبة"),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              final userId = sl<UserSession>().getCurrentUserId();
              if (userId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("لم يتم تسجيل الدخول"),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              final entity = ResourceRequestEntity(
                projectId: widget.projectId,
                //: widget.projectTitle,
                requestedBy: userId,
                percentageCompleted: widget.completedPercentage,
                projectDomainId: widget.projectFieldId,
                academicDepartmentId: _selectedAcademicId!,
                requestedResourceId: _selectedResourceId!,
              );
              context.read<ResourceRequestBloc>().add(
                SubmitResourceRequest(entity),
              );
            },
            // child: isLoading
            //     ? const SizedBox(
            //         height: 25,
            //         width: 25,
            //         child: CircularProgressIndicator(strokeWidth: 2),
            //       )
            //     : null,
          ),
        );
      },
    );
  }
}
