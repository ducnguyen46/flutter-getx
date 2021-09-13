import 'package:flutter/material.dart';
import 'package:flutter_getx/features/pages/widgets/cus_choice_chip/controllers/cus_choice_chip_controller.dart';
import 'package:get/get.dart';

class CusChoiceChip extends StatelessWidget {
  CusChoiceChip({Key? key, required this.onChanged}) : super(key: key);

  // final CusChoiceChipController controller = Get.find();
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CusChoiceChipController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          controller.onChange();
          onChanged(controller.isSelected.value);
        },
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: controller.isSelected.value
                ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                : Colors.black12,
            border: controller.isSelected.value
                ? Border.all(
                    width: 1.5,
                    color: Colors.transparent,
                  )
                : Border.all(width: 1.5),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Center(
            child: Text(
              'Cus Choice Chip',
              style: TextStyle(
                color: controller.isSelected.value
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
