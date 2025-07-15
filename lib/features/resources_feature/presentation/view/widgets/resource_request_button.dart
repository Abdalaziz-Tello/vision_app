import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/di_storage_listner/user_id.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/widgets/custom_button.dart';
import 'package:vision_app/core/widgets/custom_snack_bar_function.dart';
import 'package:vision_app/features/resources_feature/domain/entity/resource_request_entity.dart';
import 'package:vision_app/features/resources_feature/presentation/resource_request_bloc/resource_request_bloc.dart';
import 'package:vision_app/features/resources_feature/utils/resource_request_controller.dart';

class ResourceRequestButton extends StatelessWidget {
  final ResourceRequestController controller;
  final String projectId;
  final int completedPercentage;
  final String projectFieldId;
  final UserSession userSession;

  const ResourceRequestButton({
    super.key,
    required this.controller,
    required this.projectId,
    required this.completedPercentage,
    required this.projectFieldId,
    required this.userSession,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceRequestBloc, ResourceRequestState>(
      builder: (context, state) {
        if (state is ResourceRequestLoading) {
          return const CircularProgressIndicator(color: AppColors.navyBlue);
        }

        return Align(
          alignment: Alignment.bottomRight,
          child: CustomButton(
            text: AppString.submitRequest,
            width: 200,
            fontSize: 22,
            bgColor: const Color.fromRGBO(33, 193, 242, 1),
            textColor: AppColors.navyBlue,
            onTap: () => _submitRequest(context),
          ),
        );
      },
    );
  }

  void _submitRequest(BuildContext context) {
    if (!controller.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          AppString.pleaseFillAllRequiredFields,
          AppColors.redColor,
        ),
      );
      return;
    }

    final userId = userSession.getCurrentUserId();
    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar(AppString.notLoggedIn, AppColors.redColor));
      return;
    }

    context.read<ResourceRequestBloc>().add(
      SubmitResourceRequest(
        ResourceRequestEntity(
          projectId: projectId,
          requestedBy: userId,
          percentageCompleted: completedPercentage,
          projectDomainId: projectFieldId,
          academicDepartmentId: controller.selectedAcademicId!,
          requestedResourceId: controller.selectedResourceId!,
        ),
      ),
    );
  }
}
