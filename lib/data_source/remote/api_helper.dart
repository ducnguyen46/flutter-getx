import 'dart:io';

import 'package:get/get_connect.dart';

class ApiHelper extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://jsonplaceholder.typicode.com/';
    addRequestModifier();
    super.onInit();
  }

  void addRequestModifier() {
    httpClient.addRequestModifier<dynamic>((request) {
      // if (token != null) {
      //   request.headers[HttpHeaders.authorizationHeader] = token;
      // }
      request.headers[HttpHeaders.contentTypeHeader] =
          ContentType.json.mimeType;

      return request;
    });
  }
}
