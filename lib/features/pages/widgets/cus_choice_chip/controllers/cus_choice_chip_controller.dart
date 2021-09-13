import 'package:get/get.dart';

class CusChoiceChipController extends GetxController {
  var isSelected = false.obs;

  void onChange(){
    isSelected.value = !isSelected.value;
    update();
  }
}