import 'package:get/get_connect.dart';

class ResponseHandling {
  static T? getResponseBody<T>(Response<T> response) {
    return response.body;
  }
}
