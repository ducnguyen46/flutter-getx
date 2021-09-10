import 'package:flutter_getx/data_source/local/notification_service.dart';
import 'package:flutter_getx/data_source/remote/api_helper.dart';
import 'package:flutter_getx/data_source/repository/home_repository.dart';
import 'package:flutter_getx/features/controllers/home_controller.dart';
import 'package:get/instance_manager.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationService());
    Get.lazyPut(() => ApiHelper());
    Get.lazyPut(() => HomeRepository(Get.find<ApiHelper>()));
    Get.lazyPut(() => HomeController(Get.find<HomeRepository>()));
  }
}
