import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/features/microbots_features/features/get_all_projects_feature/presentation/get_all_projects_bloc/all_projects_bloc.dart';
import 'package:vision_app/features/microbots_features/features/get_all_projects_feature/presentation/view/projects_widgets/projects_content_widget.dart';
import 'package:vision_app/features/microbots_features/features/get_resource_requests/presentation/get_users_resource_request/users_resource_request_bloc.dart';
import 'package:vision_app/features/microbots_features/features/get_resource_requests/presentation/view/resource_content.dart';
import 'package:vision_app/features/microbots_features/features/tools_feature/presentation/all_tools_bloc/all_tools_bloc.dart';
import 'package:vision_app/features/microbots_features/features/tools_feature/presentation/view/tools_widgets/tools_content.dart';

//projects tab :
class AdminProjectsTab extends StatelessWidget {
  const AdminProjectsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AllProjectsBloc>(),
      child: ProjectsContent(),
    );
  }
}

//___________________________________________________________________
//resources tab :
class AdminResourcesTab extends StatelessWidget {
  const AdminResourcesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UsersResourceRequestBloc>(),
      child: ResourceContent(),
    );
  }
}

//___________________________________________________________________
//tools tab :
class AdminToolsTab extends StatelessWidget {
  const AdminToolsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AllToolsBloc>(),
      child: ToolsContent(),
    );
  }
}
