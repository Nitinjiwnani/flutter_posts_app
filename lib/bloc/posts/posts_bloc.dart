import 'package:bloc/bloc.dart';
import 'package:flutter_posts_app/bloc/posts/posts_event.dart';
import 'package:flutter_posts_app/bloc/posts/posts_state.dart';
import 'package:flutter_posts_app/model/posts_model.dart';
import 'package:flutter_posts_app/repository/posts_repository.dart';
import 'package:flutter_posts_app/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsRepository postsRepository = PostsRepository();

  PostsBloc() : super(const PostsState()) {
    on<Postsfetch>(_fetchPosts);
    on<PostsFetchDetails>(_fetchPostsDetails);
    on<MarkPostAsRead>(_markPostAsRead);
  }

  Future<void> _fetchPosts(Postsfetch event, Emitter<PostsState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localPosts = prefs.getString('postsList');
      final localReadPosts = prefs.getString('readPosts');

      if (localPosts != null) {
        final posts = (json.decode(localPosts) as List)
            .map((e) => PostsModel.fromJson(e))
            .toList();
        final readPosts = localReadPosts != null
            ? Set<int>.from(json.decode(localReadPosts))
            : <int>{};
        emit(state.copywith(
          postsStatus: PostsStatus.success,
          postsList: posts,
          readPosts: readPosts,
          message: 'Loaded from local storage',
        ));
      }
      final posts = await postsRepository.fetchPosts();
      emit(state.copywith(
        postsStatus: PostsStatus.success,
        postsList: posts,
        message: 'Posts fetched from API',
      ));
      await prefs.setString('postsList', json.encode(posts));
    } catch (e) {
      emit(state.copywith(
        postsStatus: PostsStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _fetchPostsDetails(
      PostsFetchDetails event, Emitter<PostsState> emit) async {
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

  void _markPostAsRead(MarkPostAsRead event, Emitter<PostsState> emit) async {
    final readPosts = Set<int>.from(state.readPosts)..add(event.postId);
    emit(state.copywith(readPosts: readPosts));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('readPosts', json.encode(readPosts.toList()));
  }
}
