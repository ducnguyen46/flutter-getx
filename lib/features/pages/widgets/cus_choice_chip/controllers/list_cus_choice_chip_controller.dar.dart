import 'package:get/get.dart';

class ListCusChoiceChipController extends GetxController{
  RxList<String> _items = <String>['Ha Noi', 'Ba Vi', 'Chi Linh'].obs;
  RxList<String> _selectedItems = <String>[].obs;

  set items(List<String> value){
    _items.value = value;
    _items.refresh();
  }

  List<String> get selectedItems => _selectedItems;
  set selectedItems(List<String> value){
    _selectedItems.value = value;
    _selectedItems.refresh();
  }

  addSelectedItemToList(String item){
    _selectedItems.add(item);
    _selectedItems.refresh();
  }

  removeSelectedItemFromList(String item){
    _selectedItems.remove(item);
    _selectedItems.refresh();
  }

}