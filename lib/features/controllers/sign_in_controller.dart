import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignInController extends GetxController {
  FocusNode usernameNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  @override
  void onClose() {
    usernameNode.dispose();
    passwordNode.dispose();
    super.onClose();
  }

  String? validateUsername(String? value) {
    if (value != null && value.isEmpty) {
      usernameNode.requestFocus();
      return 'This is required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value != null && value.isEmpty) {
      passwordNode.requestFocus();
      return 'Required';
    }
    if (value != null && value != 'abc') {
      return 'Wrong password';
    }
    return null;
  }
}
