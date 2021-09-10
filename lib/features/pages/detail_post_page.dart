import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getx/features/controllers/detail_post_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DetailPostPage extends StatelessWidget {
  DetailPostPage({Key? key}) : super(key: key);

  final DetaiPostlController _detaiPostlController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('detail_post'.tr),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Obx(
          () => ListView.builder(
            itemCount: _detaiPostlController.comments.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                _detaiPostlController.comments.elementAt(index).name,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              subtitle:
                  Text(_detaiPostlController.comments.elementAt(index).body),
            ),
          ),
        ),
      ),
    );
  }
}
