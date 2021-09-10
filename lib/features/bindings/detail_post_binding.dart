import 'package:flutter_getx/data_source/remote/api_helper.dart';
import 'package:flutter_getx/data_source/repository/detail_post_repository.dart';
import 'package:flutter_getx/features/controllers/detail_post_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class DetailPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailPostRepository(Get.find<ApiHelper>()));
    Get.lazyPut(() => DetaiPostlController(Get.find<DetailPostRepository>()));
  }
}
