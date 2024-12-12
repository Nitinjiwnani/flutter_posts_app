import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class Postsfetch extends PostsEvent {}

class PostsFetchDetails extends PostsEvent {
  final int postId;
  const PostsFetchDetails(this.postId);

  @override
  List<Object> get props => [postId];
}

class MarkPostAsRead extends PostsEvent {
  final int postId;
  const MarkPostAsRead(this.postId);

  @override
  List<Object> get props => [postId];
}