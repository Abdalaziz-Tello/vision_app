import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_app/core/res/color/app_colors.dart';
import 'package:vision_app/core/shared/widgets/failure_widget.dart';
import 'package:vision_app/features/microbots_features/presentation/widgets/web_refresh_widget.dart';
import 'package:vision_app/features/microbots_features/get_resource_requests/presentation/get_users_resource_request/users_resource_request_bloc.dart';

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
    // setState(() {
    //   _showHint = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<UsersResourceRequestBloc, UsersResourceRequestState>(
      builder: (context, state) {
        if (state is UsersResourceRequestSuccess) {
          return Column(
            children: [
              if (kIsWeb && _hasLoaded) WebRefreshWidget(onRefresh: _onRefresh),
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
