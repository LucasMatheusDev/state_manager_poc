import 'package:flutter/material.dart';
import 'package:state_manager_poc/modules/home/model/entities/post.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;
  final void Function(Post post) onLike;
  const PostList({
    super.key,
    required this.posts,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(posts[index].imageProfile),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        posts[index].author,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.network(
                    posts[index].imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 2),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(
                    Icons.favorite_border_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    onLike(posts[index]);
                  },
                  color: Colors.grey,
                  iconSize: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    posts[index].title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    posts[index].description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
