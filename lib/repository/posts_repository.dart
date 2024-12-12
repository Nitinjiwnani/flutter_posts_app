import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_posts_app/model/posts_model.dart';

class PostsRepository {
  Future<List<PostsModel>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;
        return body.map((e) {
          return PostsModel(
            userId: e['userId'] as int,
            id: e['id'] as int,
            title: e['title'] as String,
            body: e['body'] as String,
          );
        }).toList();
      }
    } on SocketException {
      throw Exception('Error fetching posts');
    } on TimeoutException {
      throw Exception('Timeout fetching posts');
    } on Error catch (e) {
      throw Exception('Error fetching posts: $e');
    }
    throw Exception('Unknown error fetching posts');
  }

  Future<PostsModel> fetchPostDetail(int postId) async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'),
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return PostsModel.fromJson(body);
      } else {
        throw Exception('Failed to load post details');
      }
    } on SocketException {
      throw Exception('Error fetching post detail');
    } on TimeoutException {
      throw Exception('Timeout fetching post detail');
    } on Error catch (e) {
      throw Exception('Error fetching post detail: $e');
    }
  }
}
