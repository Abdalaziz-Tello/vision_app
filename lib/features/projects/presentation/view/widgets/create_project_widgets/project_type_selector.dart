import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/app_string.dart';
import 'package:vision_app/features/projects/presentation/state_managments/cubits/dialog_form_cubit/dialog_form_cubit.dart';
import 'package:vision_app/features/projects/presentation/state_managments/project_domains_bloc/project_domains_bloc.dart';
import 'package:vision_app/core/widgets/text_with_expansion_tile_selector.dart';

class ProjectTypeSelector extends StatelessWidget {
  const ProjectTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDomainsBloc, ProjectDomainsState>(
      builder: (context, domainState) {
        final cubit = context.read<DialogFormCubit>();

        List<String> options = [];
        final placeholder = AppString.chooseProjectField;

        if (domainState is ProjectDomainsLoading) {
          options = [AppString.loading];
        } else if (domainState is ProjectDomainsSuccess) {
          options = domainState.domains.isEmpty
              ? [AppString.thereAreNoFieldsAvailable]
              : domainState.domains.map((d) => d.name).toList();
        } else if (domainState is ProjectDomainsFailure) {
          options = [AppString.anErrorOccurredTryAgain];
        } else {
          options = [placeholder];
        }

        final selectedVal =
            context.watch<DialogFormCubit>().state.selectedDomainName ??
            placeholder;

        return TextWithExpansionTileSelector(
          label: AppString.projectField,
          selectedValue: selectedVal,
          options: options,
          onSelected: (val) {
            if (domainState is ProjectDomainsSuccess) {
              final domain = domainState.domains.firstWhere(
                (d) => d.name == val,
                orElse: () => domainState.domains.first,
              );
              cubit.setDomain(domain.id, val);
            } else {
              context.read<ProjectDomainsBloc>().add(
                FetchProjectDomainsRequested(),
              );
            }
          },
        );
      },
    );
  }
}