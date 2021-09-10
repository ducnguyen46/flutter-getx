import 'package:flutter_getx/data_source/repository/detail_post_repository.dart';
import 'package:flutter_getx/features/models/comment.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DetaiPostlController extends GetxController {
  DetaiPostlController(this._detailPostRepository);

  final DetailPostRepository _detailPostRepository;

  RxInt? postId;
  RxList<Comment> comments = <Comment>[].obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      postId = RxInt(Get.arguments);
    } else {
      postId = RxInt(0);
    }
    getCommentsofPost();
    super.onInit();
  }

  void getCommentsofPost() async {
    List<Comment> commentsResult =
        await _detailPostRepository.getComments(postId!.value);

    comments.addAll(commentsResult);
    update();
  }
}
