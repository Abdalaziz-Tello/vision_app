import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/shared/widgets/text_with_expansion_tile_selector.dart';
import 'package:vision_app/features/user_features/request_resources_feature/presentation/academic_bloc/academic_bloc.dart';
import 'package:vision_app/features/user_features/request_resources_feature/presentation/requested_resource_bloc/requested_resource_bloc.dart';
import 'package:vision_app/features/user_features/request_resources_feature/utils/resource_request_controller.dart';
import 'package:vision_app/features/user_features/user_projects_features/create_project_feature/presentation/view/widgets/create_project_widgets/custom_display_field.dart';

class ResourceRequestFields extends StatelessWidget {
  final String projectTitle;
  final int completedPercentage;
  final String projectDomainName;
  final String projectOwnerName;
  final ResourceRequestController controller;

  const ResourceRequestFields({
    super.key,
    required this.projectTitle,
    required this.completedPercentage,
    required this.projectDomainName,
    required this.projectOwnerName,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(),
        const SizedBox(height: 16),
        _buildProjectNameField(),
        _buildDualFieldsSection(),
        const SizedBox(height: 10),
        _buildProjectOwnerField(),
        const SizedBox(height: 10),
        _buildUniversityField(context),
        const SizedBox(height: 10),
        _buildResourceField(context),
      ],
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
    value: projectTitle,
    required: false,
  );

  Widget _buildDualFieldsSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 800;
        return isWide
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: _buildProjectTypeField()),
                  const SizedBox(width: 8),
                  Expanded(child: _buildCompletedPartOfProjectField()),
                ],
              )
            : Column(
                children: [
                  _buildProjectTypeField(),
                  _buildCompletedPartOfProjectField(),
                ],
              );
      },
    );
  }

  Widget _buildCompletedPartOfProjectField() => CustomDisplayField(
    title: AppString.completedPartOfProject,
    value: completedPercentage.toString(),
    required: false,
  );

  Widget _buildProjectTypeField() => CustomDisplayField(
    title: AppString.projectField,
    value: projectDomainName,
    required: false,
  );

  Widget _buildProjectOwnerField() => CustomDisplayField(
    title: 'مالك المشروع',
    value: projectOwnerName,
    required: false,
  );

  Widget _buildUniversityField(BuildContext context) {
    return BlocBuilder<AcademicBloc, AcademicState>(
      builder: (context, state) {
        final (options, selectedValue) = _getUniversityOptions(state);
        return TextWithExpansionTileSelector(
          label: AppString.educationEntity,
          selectedValue: selectedValue,
          options: options,
          onSelected: (val) {
            controller.handleUniversitySelection(val, state);
          },
        );
      },
    );
  }

  (List<String>, String) _getUniversityOptions(AcademicState state) {
    final placeholder = AppString.selectEducationEntity; //"اختر جهة التعليم";

    if (state is AcademicLoading) {
      return ([AppString.loading], AppString.loading);
    }
    if (state is AcademicFailure) {
      return (
        [AppString.anErrorOccurredTryAgain],
        AppString.anErrorOccurredTryAgain,
      );
    }
    if (state is! AcademicSuccess) return ([], "");

    if (state.academics.isEmpty) {
      return ([AppString.noEducationEntities], AppString.noEducationEntities);
    }

    return (
      state.academics.map((e) => e.name).toList(),
      controller.selectedUniversity ?? placeholder,
    );
  }

  Widget _buildResourceField(BuildContext context) {
    return BlocBuilder<ResourceBloc, ResourceState>(
      builder: (context, state) {
        final (options, selectedValue) = _getResourceOptions(state);
        return TextWithExpansionTileSelector(
          label: AppString.requiredResource,
          selectedValue: selectedValue,
          options: options,
          onSelected: (val) {
            controller.handleResourceSelection(val, state);
          },
        );
      },
    );
  }

  (List<String>, String) _getResourceOptions(ResourceState state) {
    final placeholder = AppString.selectResource;

    if (state is ResourceLoading) {
      return ([AppString.loading], AppString.loading);
    }
    if (state is ResourceFailure) {
      return (
        [AppString.anErrorOccurredTryAgain],
        AppString.anErrorOccurredTryAgain,
      );
    }
    if (state is! ResourceSuccess) return ([], "");

    final resources = controller.selectedAcademicId == null
        ? state.resources
        : state.resources
              .where(
                (r) => r.academicDepartmentId == controller.selectedAcademicId,
              )
              .toList();

    if (resources.isEmpty) {
      return ([AppString.noResources], AppString.noResources);
    }

    return (
      resources.map((e) => e.name).toList(),
      controller.selectedResource ?? placeholder,
    );
  }
}
