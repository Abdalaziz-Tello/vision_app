import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/di_storage_listner/di.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/features/microbots/presentation/widgets/microbots_admin_appbar.dart';
import 'package:vision_app/features/microbots/presentation/widgets/projects_widgets/projects_content_widget.dart';
import 'package:vision_app/features/microbots/presentation/widgets/resource_content.dart';
import 'package:vision_app/features/microbots/presentation/widgets/search_container.dart';
import 'package:vision_app/features/microbots/presentation/widgets/tools_widgets/tools_content.dart';
import 'package:vision_app/features/projects/presentation/state_managments/get_all_projects_bloc/all_projects_bloc.dart';
import 'package:vision_app/features/resources_feature/presentation/get_users_resource_request/users_resource_request_bloc.dart';
import 'package:vision_app/features/tools_feature/presentation/all_tools_bloc/all_tools_bloc.dart';

class MicrobotsAdminPage extends StatefulWidget {
  const MicrobotsAdminPage({super.key});

  @override
  State<MicrobotsAdminPage> createState() => _MicrobotsAdminPageState();
}

class _MicrobotsAdminPageState extends State<MicrobotsAdminPage> {
  late PageController _controller;
  int _selectedIndex = 0;
  bool _showSearchOverlay = false;

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _showSearchOverlay = !_showSearchOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: MicrobotsAdminAppBar(
            selectedIndex: _selectedIndex,
            onTabSelected: _onTabSelected,
            showSearch: _showSearchOverlay,
            onSearchTap: _toggleSearch,
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            children: [
              BlocProvider(
                create: (_) => sl<AllProjectsBloc>(),
                child: ProjectsContent(),
              ), //index:0 //TODO : change this ...
              BlocProvider(
                create: (context) => sl<UsersResourceRequestBloc>(),
                child: ResourceContent(),
              ), //index :1
              BlocProvider(
                create: (context) => sl<AllToolsBloc>(),
                child: ToolsContent(),
              ), //index : 2
            ],
          ),
        ),

        //search overlay //TODO : must change this , its really bad !!
        if (_showSearchOverlay)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleSearch,
              child: Container(
                color: AppColors.redColor.withOpacity(0.3),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: kToolbarHeight + 8),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.checkboxInactiveGreyFill,
                  elevation: 4,
                  child: SearchContainer(),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

