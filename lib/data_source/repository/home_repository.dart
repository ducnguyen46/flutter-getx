import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_getx/data_source/remote/api_helper.dart';
import 'package:flutter_getx/data_source/remote/response_handling.dart';
import 'package:flutter_getx/features/models/post.dart';

class HomeRepository {
  final ApiHelper _apiHelper;

  HomeRepository(this._apiHelper);

  Future<List<Post>> getPosts({int page = 1}) async {
    final response = await _apiHelper.get('posts?_page=$page&limit=20');
    if (response.isOk) {
      final responseBody = response.bodyString;
      return await compute(_parsePost, responseBody!);
    }
    return [];
  }

  static List<Post> _parsePost(String responseBody) {
    final postRes = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return postRes.map<Post>((json) => Post.fromJson(json)).toList();
  }
}
