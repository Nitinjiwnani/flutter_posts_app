import 'package:equatable/equatable.dart';
import 'package:flutter_posts_app/model/posts_model.dart';
import 'package:flutter_posts_app/utils/enums.dart';

class PostsState extends Equatable {
  final PostsStatus postsStatus;
  final List<PostsModel> postsList;
  final PostsModel? postsDetail;
  final String message;
  final Set<int> readPosts;

  const PostsState({
    this.postsStatus = PostsStatus.loading,
    this.postsList = const <PostsModel>[],
    this.postsDetail,
    this.message = '',
    this.readPosts = const {},
  });

  PostsState copywith({
    PostsStatus? postsStatus,
    List<PostsModel>? postsList,
    PostsModel? postsDetail,
    String? message,
    Set<int>? readPosts,
  }) {
    return PostsState(
      postsStatus: postsStatus ?? this.postsStatus,
      postsList: postsList ?? this.postsList,
      postsDetail: postsDetail ?? this.postsDetail,
      message: message ?? this.message,
      readPosts: readPosts ?? this.readPosts,
    );
  }

  @override
  List<Object?> get props =>
      [postsStatus, postsList, postsDetail, message, readPosts];
}

final class PostsInitial extends PostsState {}
