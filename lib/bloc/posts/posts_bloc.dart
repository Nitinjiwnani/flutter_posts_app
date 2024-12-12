import 'package:bloc/bloc.dart';
import 'package:flutter_posts_app/bloc/posts/posts_event.dart';
import 'package:flutter_posts_app/bloc/posts/posts_state.dart';
import 'package:flutter_posts_app/repository/posts_repository.dart';
import 'package:flutter_posts_app/utils/enums.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsRepository postsRepository = PostsRepository();

  PostsBloc() : super(const PostsState()) {
    on<Postsfetch>(_fetchPosts);
    on<PostsFetchDetails>(_fetchPostsDetails);
  }

  Future<void> _fetchPosts(Postsfetch event, Emitter<PostsState> emit) async {
    try {
      final posts = await postsRepository.fetchPosts();
      emit(state.copywith(
        postsStatus: PostsStatus.success,
        postsList: posts,
        message: 'Posts Fetched Successfully',
      ));
    } catch (e) {
      emit(state.copywith(
        postsStatus: PostsStatus.failure,
        message: e.toString(),
      ));
    }
  }

Future<void> _fetchPostsDetails(PostsFetchDetails event, Emitter<PostsState> emit) async {
  try {
    final post = await postsRepository.fetchPostDetail(event.postId);
    emit(state.copywith(
      postsDetail: post,
      message: 'Post detail fetched successfully',
    ));
  } catch (e) {
    emit(state.copywith(
      postsStatus: PostsStatus.failure,
      message: e.toString(),
    ));
  }
}

}
