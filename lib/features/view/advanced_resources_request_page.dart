import 'package:flutter/material.dart';
import 'package:vision_app/core/res/app_images.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/custom_display_field.dart';
import 'package:vision_app/features/view/widgets/create_project_widgets/text_with_expansion_tile_selector.dart';

class AdvancedResourcesRequestPage extends StatefulWidget {
  const AdvancedResourcesRequestPage({super.key});

  @override
  State<AdvancedResourcesRequestPage> createState() =>
      _AdvancedResourcesRequestPageState();
}

class _AdvancedResourcesRequestPageState
    extends State<AdvancedResourcesRequestPage> {
  String? selectedUniversity;
  String? selectedResource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
    value: "مشروع منصة ",
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
    value: " 25%",
    required: false,
  );

  Widget _buildProjectTypeField() => CustomDisplayField(
    title: AppString.projectField,
    value: "برمجة ويب",
    required: false,
  ); //TODO : make it static caming from the privous page or backend
  //TODO : options from back
  Widget _buildUniversityField() => TextWithExpansionTileSelector(
    label: AppString.educationEntity,
    selectedValue: selectedUniversity ?? 'اختر جهة التعليم',
    options: ['جامعة الملك سعود', 'جامعة الأمير سلطان', 'جامعة جدة', 'أخرى'],
    onSelected: (val) => setState(() => selectedUniversity = val),
  );

  Widget _buildResourceField() => TextWithExpansionTileSelector(
    label: AppString.requiredResource,
    selectedValue: selectedResource ?? 'اختر المورد',
    options: ['حاسب خارق', 'خادم سحابي', 'دعم مالي', 'تخزين سحابي', 'أخرى'],
    onSelected: (val) => setState(() => selectedResource = val),
  );

  Widget _buildProjectOwnerField() => CustomDisplayField(
    title:   'مالك المشروع',
    value: 'اسم صاحب المشروع',
    required: false,
  );

  Widget _buildUploadButton() {
    //TODO :make the buttons in the hole app the same
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () {
          //    final formValid = _formKey.currentState?.validate() ?? false;

          if (
          //!formValid ||
          selectedUniversity == null || selectedResource == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("يرجى تعبئة جميع الحقول المطلوبة وإضافة مرفقات"),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          // TODO: Proceed with upload
          print('true ');
        },
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(33, 193, 242, 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              AppString.submitRequest,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.navyBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
