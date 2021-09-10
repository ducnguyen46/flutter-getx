import 'package:flutter_getx/features/controllers/sign_in_controller.dart';
import 'package:get/instance_manager.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
