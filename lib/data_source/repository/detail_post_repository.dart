import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_getx/data_source/remote/api_helper.dart';
import 'package:flutter_getx/data_source/remote/response_handling.dart';
import 'package:flutter_getx/features/models/comment.dart';

class DetailPostRepository {
  final ApiHelper _apiHelper;

  DetailPostRepository(this._apiHelper);

  Future<List<Comment>> getComments(int postId) async {
    final response = await _apiHelper.get('comments?postId=$postId');
    if (response.isOk) {
      final responseBody = response.bodyString;
      return await compute(_parseComment, responseBody!);
    }
    return [];
  }

  static List<Comment> _parseComment(String responseBody) {
    final postRes = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return postRes.map<Comment>((json) => Comment.fromJson(json)).toList();
  }
}
