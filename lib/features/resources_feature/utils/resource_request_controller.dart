import 'package:flutter/material.dart';
import 'package:vision_app/features/resources_feature/presentation/academic_bloc/academic_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/requested_resource_bloc/requested_resource_bloc.dart';

//TODO : change this into cubit , it will be more easier  in testing

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
