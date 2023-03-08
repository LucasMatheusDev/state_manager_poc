import 'package:flutter/material.dart';
import 'package:state_manager_poc/modules/home/model/entities/friend.dart';
import 'package:state_manager_poc/modules/home/model/entities/post.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';
import 'package:state_manager_poc/modules/home/view/states/home_state.dart';
import 'package:state_manager_poc/modules/home/view/states/state_managers/home_state_manager.dart';

class HomePage extends StatelessWidget {
  final HomeStateManager stateManager;
  const HomePage({
    super.key,
    required this.stateManager,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media App'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: stateManager.friendState,
              builder: (context, state, child) {
                if (state is FriendSuccessState) {
                  return FriendProfile(friends: state.posts);
                } else if (state is FriendInitial) {
                  return const SizedBox.shrink();
                } else if (state is FriendLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is FriendLoadingState) {
                  return const CircularProgressIndicator();
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
            const SizedBox(height: 30),
            ValueListenableBuilder(
              valueListenable: stateManager.postState,
              builder: (context, state, child) {
                if (state is PostSuccessState) {
                  return CustomPostList(posts: state.posts);
                } else if (state is PostInitial) {
                  return const SizedBox.shrink();
                } else if (state is PostLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PostLoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is PostFailureState) {
                  return const Center(
                    child: Text('We have a problem :('),
                  );
                } else if (state is PostNotFoundException) {
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
          ],
        ),
      ),
    );
  }
}

class CustomPostList extends StatelessWidget {
  final List<Post> posts;
  const CustomPostList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Image.network(
                posts[index].imageUrl,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      posts[index].title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FriendProfile extends StatelessWidget {
  final List<Friend> friends;
  const FriendProfile({
    super.key,
    required this.friends,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: friends.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(friends[0].imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
