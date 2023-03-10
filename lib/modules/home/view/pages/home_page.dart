import 'package:flutter/material.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';
import 'package:state_manager_poc/modules/home/view/pages/widgets/friend_profile.dart';
import 'package:state_manager_poc/modules/home/view/pages/widgets/post_list.dart';
import 'package:state_manager_poc/modules/home/view/states/account_views_state.dart';
import 'package:state_manager_poc/modules/home/view/states/action/home_action.dart';
import 'package:state_manager_poc/modules/home/view/states/home_state.dart';
import 'package:state_manager_poc/modules/home/view/states/state_managers/home_state_manager.dart';

class HomePage extends StatefulWidget {
  final HomeStateManager stateManager;
  const HomePage({
    super.key,
    required this.stateManager,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.stateManager.emitAction(
      HomeActionInitState(),
    );
  }

  @override
  void dispose() {
    widget.stateManager.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.stateManager.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Social App',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          ValueListenableBuilder(
            valueListenable: widget.stateManager.accountViews,
            builder: (context, state, child) {
              if (state is AccountViewsSuccessState) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Views in your profile: ${state.accountViews}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          widget.stateManager.emitAction(
            HomeActionRefresh(),
          );
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: widget.stateManager.friendState,
                builder: (context, state, child) {
                  if (state is FriendSuccessState) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 120,
                        minHeight: 80,
                      ),
                      child: FriendProfile(friends: state.posts),
                    );
                  } else if (state is FriendInitial) {
                    return const SizedBox.shrink();
                  } else if (state is FriendLoadingState) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is FriendFailureState) {
                    return const Center(
                      child: Text('We have a problem :('),
                    );
                  } else if (state is FriendNotFoundException) {
                    return const Center(
                      child: Text('No posts found :('),
                    );
                  } else {
                    return const Center(
                      child: Text('Error'),
                    );
                  }
                },
              ),
              const SizedBox(height: 5),
              ValueListenableBuilder(
                valueListenable: widget.stateManager.postState,
                builder: (context, state, child) {
                  if (state is PostSuccessState) {
                    return PostList(
                      posts: state.posts,
                      onLike: (post) {
                        widget.stateManager.emitAction(
                          HomeActionLikePost(post),
                        );
                      },
                    );
                  } else if (state is PostInitial) {
                    return const SizedBox.shrink();
                  } else if (state is PostLoadingState) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ));
                  } else if (state is PostFailureState) {
                    return Center(
                      child: TextButton(
                        onPressed: () => widget.stateManager
                            .emitAction(HomeActionSearchPost()),
                        child: const Text(
                          'We have a problem :( \n Try again?',
                        ),
                      ),
                    );
                  } else if (state is PostNotFoundException) {
                    return Center(
                      child: TextButton(
                        onPressed: () => widget.stateManager
                            .emitAction(HomeActionSearchPost()),
                        child: const Text('Not found, try again?'),
                      ),
                    );
                  } else if (state is PostDefaultException) {
                    return Center(
                      child: Text((state as PostDefaultException).message),
                    );
                  } else {
                    return const Center(
                      child: Text('Error '),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
