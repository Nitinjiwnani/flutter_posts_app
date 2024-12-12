import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_app/bloc/posts/posts_bloc.dart';
import 'package:flutter_posts_app/bloc/posts/posts_event.dart';
import 'package:flutter_posts_app/bloc/posts/posts_state.dart';
import 'package:flutter_posts_app/ui/posts_screen/posts_detail_screen.dart';
import 'package:flutter_posts_app/utils/enums.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(Postsfetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts Screen'),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.postsStatus) {
            case PostsStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PostsStatus.failure:
              return const Center(child: Text('Failed to fetch posts'));
            case PostsStatus.success:
              return ListView.builder(
                itemCount: state.postsList.length,
                itemBuilder: (context, index) {
                  final items = state.postsList[index];
                  return GestureDetector(
                    onTap: () {
                      context.read<PostsBloc>().add(MarkPostAsRead(items.id!));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PostsDetailScreen(postId: items.id!);
                      }));
                    },
                    child: ListTile(
                      tileColor: state.readPosts.contains(items.id)
                          ? Colors.white
                          : Colors.yellow.shade100,
                      title: Text('${items.id}. ${items.title}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(items.body.toString()),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.timer, size: 16),
                                SizedBox(width: 4),
                                Text('20s'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
