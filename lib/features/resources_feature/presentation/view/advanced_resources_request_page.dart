import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/core/di_storage_listner/user_id.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/res/keys/navigation_keys.dart';
import 'package:vision_app/core/widgets/custom_snack_bar_function.dart';
import 'package:vision_app/features/resources_feature/presentation/academic_bloc/academic_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/requested_resource_bloc/requested_resource_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/resource_request_bloc/resource_request_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/view/widgets/resource_request_button.dart';
import 'package:vision_app/features/resources_feature/presentation/view/widgets/resource_request_fields.dart';
import 'package:vision_app/features/resources_feature/utils/resource_request_controller.dart';

class AdvancedResourcesRequestPage extends StatefulWidget {
  final String projectId;
  final String projectTitle;
  final int completedPercentage;
  final String projectFieldId;
  final String projectDomainName;
  final String projectOwnerName;

  const AdvancedResourcesRequestPage({
    super.key,
    required this.projectId,
    required this.projectTitle,
    required this.completedPercentage,
    required this.projectFieldId,
    required this.projectDomainName,
    required this.projectOwnerName,
  });

  @override
  State<AdvancedResourcesRequestPage> createState() =>
      _AdvancedResourcesRequestPageState();
}

class _AdvancedResourcesRequestPageState
    extends State<AdvancedResourcesRequestPage> {
  late final ResourceRequestController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ResourceRequestController();
    _initializeData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeData() {
    context.read<AcademicBloc>().add(GetAllAcademicsRequested());
    context.read<ResourceBloc>().add(FetchRequestedResources());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResourceRequestBloc, ResourceRequestState>(
      listener: _handleResourceRequestState,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  void _handleResourceRequestState(
    BuildContext context,
    ResourceRequestState state,
  ) {
    if (state is ResourceRequestSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(AppString.requestSubmitted, AppColors.green),
      );
      context.go(NavigationKeys.homePageKey);
    } else if (state is ResourceRequestFailure) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar(state.message, AppColors.redColor));
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: AppColors.whiteColor,
      actions: [Image.asset(AppImages.logo, width: 120, fit: BoxFit.contain)],
    );
  }

  Widget _buildBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBackgroundImage(),
        Center(child: SingleChildScrollView(child: _buildFormContainer())),
      ],
    );
  }

  Widget _buildBackgroundImage() {
    return Image.asset(
      AppImages.footer,
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }

  Widget _buildFormContainer() {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ResourceRequestFields(
                projectTitle: widget.projectTitle,
                completedPercentage: widget.completedPercentage,
                projectDomainName: widget.projectDomainName,
                projectOwnerName: widget.projectOwnerName,
                controller: _controller,
              ).animate().fadeIn(delay: 0.1.seconds, duration: 0.5.seconds),
              const SizedBox(height: 10),
              ResourceRequestButton(
                controller: _controller,
                projectId: widget.projectId,
                completedPercentage: widget.completedPercentage,
                projectFieldId: widget.projectFieldId,
                userSession: sl<UserSession>(),
              ).animate().fadeIn(delay: 0.4.seconds, duration: 0.5.seconds),
            ],
          ),
        );
      },
    );
  }
}
