import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/failure_widget.dart';
import 'package:vision_app/features/microbots_features/presentation/widgets/shared_widgets/refresh_and_search_row.dart';
import 'package:vision_app/features/microbots_features/features/get_resource_requests/presentation/get_users_resource_request/users_resource_request_bloc.dart';

class ResourceContent extends StatefulWidget {
  const ResourceContent({super.key});

  @override
  State<ResourceContent> createState() => _ResourceContentState();
}

class _ResourceContentState extends State<ResourceContent>
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
      context.read<UsersResourceRequestBloc>().add(
        FetchUsersResourceRequestEvent(),
      );
    }
  }

  Future<void> _onRefresh() async {
    context.read<UsersResourceRequestBloc>().add(
      FetchUsersResourceRequestEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<UsersResourceRequestBloc, UsersResourceRequestState>(
      builder: (context, state) {
        if (state is UsersResourceRequestSuccess) {
          return Column(
            children: [
              RefreshAndSearchRow(
                onRefresh: _onRefresh,
                searchController: TextEditingController(),
                onSearchChanged: (value) {},
                onSearchCleared: () {},
              ),
              //  if (kIsWeb && _hasLoaded) WebRefreshWidget(onRefresh: _onRefresh),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.whiteColor,
                  backgroundColor: AppColors.navyBlue,
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    itemCount: state.resources.length,
                    itemBuilder: (context, index) {
                      final request = state.resources[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.reallyWhite,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackColor.withOpacity(0.05),
                              offset: const Offset(2, 2),
                              blurRadius: 6,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Text(request.projectId),
                      ).animate().scale(
                        duration: (0.1 * index).seconds,
                        delay: (0.1 * index).seconds,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (state is UsersResourceRequestFailure) {
          return FailureWidget(onTap: _onRefresh, failureText: state.message);
        }

        return const Center(
          child: CircularProgressIndicator(color: AppColors.navyBlue),
        );
      },
    );
  }
}
