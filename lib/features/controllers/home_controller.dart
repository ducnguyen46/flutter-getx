import 'package:flutter/material.dart';
import 'package:flutter_getx/data_source/repository/home_repository.dart';
import 'package:flutter_getx/features/models/post.dart';
import 'package:flutter_getx/features/models/province.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class HomeController extends GetxController {
  HomeController(this._homeRepository);

  final HomeRepository _homeRepository;

  var posts = <Post>[].obs;
  var page = 1.obs;
  var isEndOfPage = false.obs;
  ScrollController postsScrollController = ScrollController();

  @override
  void onInit() {
    getPosts();
    postsScrollController.addListener(_loadMore);
    super.onInit();
  }

  Future getPosts({int page = 1}) async {
    final result = await _homeRepository.getPosts(page: page);
    if (result.isEmpty) {
      page--;
      isEndOfPage = RxBool(true);
    }
    posts.addAll(result);
  }

  _loadMore() {
    if (postsScrollController.position.pixels ==
        postsScrollController.position.maxScrollExtent) {
      page++;
      getPosts(page: page.value);
    }
  }

  // __________________________ //
  RxList<MultiSelectItem<Province>> items = [
    MultiSelectItem(Province(provinceName: 'Hà Nội', carCount: 29), 'Hà Nội'),
    MultiSelectItem(
        Province(provinceName: 'Hải Dương', carCount: 34), 'Hải Dương'),
    MultiSelectItem(
        Province(provinceName: 'Hải Phòng', carCount: 16), 'Hải Phòng'),
    MultiSelectItem(
        Province(provinceName: 'Quảng Ninh', carCount: 14), 'Quảng Ninh'),
  ].obs;

  RxList<Province> _selectedList = <Province>[].obs;

  RxList<Province> get selectedList => _selectedList;
  set selectedList(List<Province> value) {
    _selectedList.value = value;
    _selectedList.refresh();
  }

  void addItemSelectedList(Province item) {
    _selectedList.add(item);
    _selectedList.refresh();
  }

  void removeItemSelectedListAt(int position) {
    _selectedList.removeAt(position);
    _selectedList.refresh();
  }

  void removeItemSelectedList(Province item) {
    _selectedList.remove(item);
    _selectedList.refresh();
  }
}
