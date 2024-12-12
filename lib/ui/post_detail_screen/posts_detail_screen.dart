import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_app/bloc/posts/posts_bloc.dart';
import 'package:flutter_posts_app/bloc/posts/posts_event.dart';
import 'package:flutter_posts_app/bloc/posts/posts_state.dart';
import 'package:flutter_posts_app/utils/enums.dart';

class PostsDetailScreen extends StatefulWidget {
  final int postId;
  const PostsDetailScreen({required this.postId, super.key});

  @override
  State<PostsDetailScreen> createState() => _PostsDetailScreenState();
}

class _PostsDetailScreenState extends State<PostsDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(PostsFetchDetails(widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Details')),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.postsStatus) {
            case PostsStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PostsStatus.failure:
              return const Center(child: Text('Failed to fetch posts'));
            case PostsStatus.success:
              final posts = state.postsList
                  .firstWhere((element) => element.id == widget.postId);
              return Column(
                children: [
                  ListTile(
                    title: Text(posts.title.toString()),
                    subtitle: Text(posts.body.toString()),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
