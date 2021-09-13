import 'package:flutter/material.dart';
import 'package:flutter_getx/features/pages/widgets/cus_choice_chip/widgets/cus_choice_chip.dart';
import 'package:flutter_getx/features/pages/widgets/cus_choice_chip/controllers/list_cus_choice_chip_controller.dar.dart';
import 'package:get/get.dart';

class MultiSelectChip extends StatelessWidget {
  MultiSelectChip({Key? key, required this.onSelectionChanged})
      : super(key: key);

  final Function(List<String>) onSelectionChanged;

  final ListCusChoiceChipController _controller =
      Get.put(ListCusChoiceChipController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 5,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 7,
        crossAxisSpacing: 7,
        childAspectRatio: 3,
      ),
      itemBuilder: (context, index) => CusChoiceChip(
        onChanged: (bool isSelected) {
          if (isSelected) {
            _controller.addSelectedItemToList('Co Thanh');
          } else {
            _controller.removeSelectedItemFromList('Co Thanh');
          }
          onSelectionChanged(_controller.selectedItems);
        },
      ),
    );
  }
}
