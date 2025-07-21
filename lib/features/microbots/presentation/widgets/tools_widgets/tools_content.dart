import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/di_storage_listner/build_context_extensions.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/widgets/failure_widget.dart';
import 'package:vision_app/features/microbots/presentation/widgets/tools_widgets/tool_card.dart';
import 'package:vision_app/features/microbots/presentation/widgets/web_refresh_widget.dart';
import 'package:vision_app/features/tools_feature/presentation/all_tools_bloc/all_tools_bloc.dart';

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
  // bool _showHint = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoaded) {
      _hasLoaded = true;
      //  context.read<AllProjectsBloc>().add(FetchAllProjects());
      context.read<AllToolsBloc>().add(FetchAllTools());
    }
  }

  Future<void> _onRefresh() async {
    context.read<AllToolsBloc>().add(FetchAllTools());
    // setState(() {
    //   _showHint = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<AllToolsBloc, AllToolsState>(
      builder: (context, state) {
        if (state is AllToolsSuccess) {
          return Column(
            children: [
              if (kIsWeb && _hasLoaded) WebRefreshWidget(onRefresh: _onRefresh),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.whiteColor,
                  backgroundColor: AppColors.navyBlue,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: state.tools.map((tool) {
                          return SizedBox(
                            width: context.screenWidth < 800
                                ? double.infinity
                                : context.screenWidth /2.2,
                            child: ToolCard(
                              imageUrl: tool.imageUrl,
                              title: tool.name,
                              totalCount: tool.totalCount ?? 0,
                              loanedCount: tool.loanedCount ?? 0,
                              availabilityStatus: tool.availabilityStatus,
                            ),
                          );
                        }).toList(),
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
}
