// resource_request_controller.dart
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
import 'package:vision_app/core/widgets/custom_button.dart';
import 'package:vision_app/core/widgets/custom_snack_bar_function.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/custom_display_field.dart';
import 'package:vision_app/features/projects/presentation/view/widgets/create_project_widgets/text_with_expansion_tile_selector.dart';
import 'package:vision_app/features/resources_feature/domain/entity/resource_request_entity.dart';
import 'package:vision_app/features/resources_feature/presentation/academic_bloc/academic_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/requested_resource_bloc/requested_resource_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/resource_request_bloc/resource_request_bloc.dart';

class ResourceRequestController extends ChangeNotifier {
  String? selectedUniversity;
  String? selectedAcademicId;
  String? selectedResource;
  String? selectedResourceId;

  void handleUniversitySelection(String value, AcademicState state) {
    if (state is! AcademicSuccess) return;

    final selectedAcademic = state.academics.firstWhere(
      (e) => e.name == value,
      orElse: () => state.academics.first,
    );

    selectedUniversity = value;
    selectedAcademicId = selectedAcademic.id;
    // Reset resource selection when university changes
    selectedResource = null;
    selectedResourceId = null;
    notifyListeners();
  }

  void handleResourceSelection(String value, ResourceState state) {
    if (state is! ResourceSuccess) return;

    final resources = selectedAcademicId == null
        ? state.resources
        : state.resources
              .where((r) => r.academicDepartmentId == selectedAcademicId)
              .toList();

    final selected = resources.firstWhere(
      (e) => e.name == value,
      orElse: () => resources.first,
    );

    selectedResource = value;
    selectedResourceId = selected.id;
    notifyListeners();
  }

  bool validate() {
    return selectedUniversity != null &&
        selectedResource != null &&
        selectedAcademicId != null &&
        selectedResourceId != null;
  }
}
//!__________________________________________________
// resource_request_fields.dart

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
    const placeholder = "اختر جهة التعليم";

    if (state is AcademicLoading)
      return (["جاري التحميل..."], "جاري التحميل...");
    if (state is AcademicFailure)
      return (["حدث خطأ، حاول مرة أخرى"], "حدث خطأ، حاول مرة أخرى");
    if (state is! AcademicSuccess) return ([], "");

    if (state.academics.isEmpty)
      return (["لا توجد جهات تعليم"], "لا توجد جهات تعليم");

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
    const placeholder = "اختر المورد";

    if (state is ResourceLoading)
      return (["جاري التحميل..."], "جاري التحميل...");
    if (state is ResourceFailure)
      return (["حدث خطأ، حاول مرة أخرى"], "حدث خطأ، حاول مرة أخرى");
    if (state is! ResourceSuccess) return ([], "");

    final resources = controller.selectedAcademicId == null
        ? state.resources
        : state.resources
              .where(
                (r) => r.academicDepartmentId == controller.selectedAcademicId,
              )
              .toList();

    if (resources.isEmpty) return (["لا توجد موارد"], "لا توجد موارد");

    return (
      resources.map((e) => e.name).toList(),
      controller.selectedResource ?? placeholder,
    );
  }
}

//!_______________________________________________________________
// resource_request_button.dart

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
        // const SnackBar(
        //   content: Text("يرجى تعبئة جميع الحقول المطلوبة"),
        //   backgroundColor: Colors.red,
        // ),
        customSnackBar("يرجى تعبئة جميع الحقول المطلوبة", AppColors.redColor),
      );
      return;
    }

    final userId = userSession.getCurrentUserId();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        // const SnackBar(
        //   content: Text("لم يتم تسجيل الدخول"),
        //   backgroundColor: Colors.red,
        // ),
        customSnackBar("لم يتم تسجيل الدخول", AppColors.redColor),
      );
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
//!____________________________________________________
// advanced_resources_request_page.dart

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar('تم إرسال طلبك', AppColors.green));
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
