import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/di_storage_listner/build_context_extensions.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/failure_widget.dart';
import 'package:vision_app/features/microbots_features/features/tools_feature/presentation/view/tools_widgets/tool_card.dart';
import 'package:vision_app/features/microbots_features/presentation/widgets/shared_widgets/refresh_and_search_row.dart';
import 'package:vision_app/features/microbots_features/features/tools_feature/presentation/all_tools_bloc/all_tools_bloc.dart';

class ToolsContent extends StatefulWidget {
  const ToolsContent({super.key});

  @override
  State<ToolsContent> createState() => _ToolsContentState();
}

class _ToolsContentState extends State<ToolsContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _hasLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasLoaded) {
      _hasLoaded = true;
      context.read<AllToolsBloc>().add(FetchAllTools());
    }
  }

  Future<void> _onRefresh() async {
    context.read<AllToolsBloc>().add(FetchAllTools());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<AllToolsBloc, AllToolsState>(
      builder: (context, state) {
        if (state is AllToolsSuccess) {
          return Column(
            children: [
              RefreshAndSearchRow(
                //TODO : fix this , but first know , what the search here depends on
                onRefresh: _onRefresh,
                searchController: TextEditingController(),
                onSearchChanged: (value) {},
                onSearchCleared: () {},
              ),
              //  if (kIsWeb ) WebRefreshWidget(onRefresh: _onRefresh),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.whiteColor,
                  backgroundColor: AppColors.navyBlue,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: _buildToolCards(state.tools),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is AllToolsFailure) {
          return FailureWidget(onTap: _onRefresh, failureText: state.error);
        }

        return const Center(
          child: CircularProgressIndicator(color: AppColors.navyBlue),
        );
      },
    );
  }

  List<Widget> _buildToolCards(List tools) {
    final isSmallScreen = context.screenWidth < 800;
    final cardWidth = isSmallScreen
        ? double.infinity
        : context.screenWidth / 2.2;

    return List.generate(tools.length, (i) {
      final tool = tools[i];
      return SizedBox(
        width: cardWidth,
        child: ToolCard(
          imageUrl: tool.imageUrl,
          title: tool.name,
          totalCount: tool.totalCount ?? 0,
          loanedCount: tool.loanedCount ?? 0,
          availabilityStatus: tool.availabilityStatus,
        ),
      ).animate().scale(duration: (0.1 * i).seconds, delay: (0.1 * i).seconds);
    });
  }
}
