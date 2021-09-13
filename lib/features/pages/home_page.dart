import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getx/features/controllers/home_controller.dart';
import 'package:flutter_getx/features/models/province.dart';
import 'package:flutter_getx/features/pages/widgets/cus_chip.dart';
import 'package:flutter_getx/features/pages/widgets/cus_choice_chip/widgets/cus_choice_chip.dart';
import 'package:flutter_getx/features/pages/widgets/cus_choice_chip/widgets/list_cus_choice_chip.dart';
import 'package:flutter_getx/features/pages/widgets/cus_multi_select_bottom_sheet.dart';
import 'package:flutter_getx/resources/translate/translator.dart';
import 'package:flutter_getx/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  final HomeController _homeController = Get.find();
  var _selected = Translator.locale.languageCode;
  int? _value = 1;

  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('home_page'.tr),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoute.signInPage);
              },
              icon: const Icon(Icons.map)),
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoute.notificationPage);
              },
              icon: const Icon(Icons.notification_add)),
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoute.filePickerPage);
              },
              icon: const Icon(Icons.file_upload)),
          DropdownButton(
            icon: const Icon(Icons.arrow_drop_down),
            value: _selected,
            onChanged: (String? code) {
              setState(() {
                _selected = code!;
              });
              Translator.changeLocale(code.toString());
            },
            items: _dropdownItems(),
          ),
        ],
      ),
      body: SafeArea(
        // child: HomeView(size: size, homeController: _homeController),
        child: Container(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 8,
                  ),
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _homeController.selectedList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CusChip(
                                label: Text(_homeController.selectedList
                                    .elementAt(index)
                                    .provinceName),
                                onDeleted: () {
                                  _homeController
                                      .removeItemSelectedListAt(index);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: MultiSelectBottomSheet<Province>(
                                searchable: true,
                                items: _homeController.items,
                                initialValue: _homeController.selectedList,
                                onSelectionChanged: (result) {
                                  _homeController.selectedList = result;
                                },
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CusMultiSelectedBottomSheet<Province>(
                items: _homeController.items,
                selectedItems: _homeController.selectedList,
                listBuilderChip: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _homeController.selectedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CusChip(
                        label: Text(_homeController.selectedList
                            .elementAt(index)
                            .provinceName),
                        onDeleted: () {
                          _homeController.removeItemSelectedListAt(index);
                        },
                      );
                    },
                  ),
                ),
                // searchable: true,
                onSelectionChanged: (result) {
                  _homeController.selectedList = result;
                },
              ),
              ChoiceChip(
                label: Text('Choice chip'),
                selected: true,
                shape: RoundedRectangleBorder(),
                selectedColor: Colors.amber,
                disabledColor: Colors.black12,
              ),
              SizedBox(
                height: 200,
                child: MultiSelectBottomSheet<Province>(
                  items: _homeController.items,
                  initialValue: _homeController.selectedList,
                  listType: MultiSelectListType.CHIP,
                  onSelectionChanged: (result ) {
                    _homeController.selectedList = result;
                  },
                ),


              ),
              Expanded(
                child: MultiSelectChip(onSelectionChanged: (result){
                  print('length: ${result.length}');
                  for(final item in result){
                    print(item);
                  }
                },),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //____________________

  List<DropdownMenuItem<String>> _dropdownItems() {
    List<DropdownMenuItem<String>> items = [];
    for (var index = 0; index < Translator.dropdownLang.keys.length; index++) {
      items.add(
        DropdownMenuItem<String>(
          value: Translator.dropdownLang.keys.elementAt(index),
          child: Translator.dropdownLang.values.elementAt(index),
        ),
      );
    }
    return items;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
    required this.size,
    required HomeController homeController,
  })  : _homeController = homeController,
        super(key: key);

  final Size size;
  final HomeController _homeController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Obx(
        () => ListView.builder(
          controller: _homeController.postsScrollController,
          itemCount: _homeController.isEndOfPage.value
              ? _homeController.posts.length + 1
              : _homeController.posts.length,
          itemBuilder: (context, index) {
            return index < _homeController.posts.length
                ? ListTile(
                    onTap: () {
                      Get.toNamed(AppRoute.detailPost, arguments: index);
                    },
                    title: Text(
                      _homeController.posts[index].title,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    subtitle: Text(
                      _homeController.posts[index].body,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  )
                : const Center(child: Text('End of page'));
          },
        ),
      ),
    );
  }
}
