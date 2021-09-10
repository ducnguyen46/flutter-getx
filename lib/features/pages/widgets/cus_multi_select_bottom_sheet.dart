import 'package:flutter/material.dart';
import 'package:flutter_getx/features/pages/widgets/cus_chip.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CusMultiSelectedBottomSheet<V> extends StatelessWidget {
  const CusMultiSelectedBottomSheet({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.listBuilderChip,
    this.onSelectionChanged,
    this.isShowActionButton = false,
    this.onConfirm,
    this.confirmText,
    this.cancelText,
    this.selectedColor,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.searchable,
    this.searchHint,
    this.searchIcon,
    this.searchTextStyle,
    this.searchHintStyle,
    this.itemsTextStyle,
    this.selectedItemsTextStyle,
    this.checkColor,
  }) : super(key: key);

  /// List of items to select from.
  final List<MultiSelectItem<V>> items;

  /// The list of selected values before interaction.
  final List<V> selectedItems;

  /// Fires when the an item is selected / unselected.
  final void Function(List<V>)? onSelectionChanged;

  /// Show action button OK [onConfirm] and Cancel.
  /// Default value is false
  final bool isShowActionButton;

  /// Fires when confirm is tapped.
  final void Function(List<V>)? onConfirm;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color? selectedColor;

  /// Set the initial height of the BottomSheet.
  final double? initialChildSize;

  /// Set the minimum height threshold of the BottomSheet before it closes.
  final double? minChildSize;

  /// Set the maximum height of the BottomSheet.
  final double? maxChildSize;

  /// Toggles search functionality.
  final bool? searchable;

  /// Set the placeholder text of the search field.
  final String? searchHint;

  /// Icon button that shows the search field.
  final Widget? searchIcon;

  /// Style the search text.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Style the text on the chips or list tiles.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  /**
   * List [CusChip] hoặc [Chip] hiển thị các phần được lựa chọn
   ** Example: 
   * 
    *         ListView.builder(
    *              scrollDirection: Axis.horizontal,
    *              itemCount: selectedItems.length,
    *              itemBuilder: (BuildContext context, int index) {
    *                 return CusChip(
    *                     label: Text(selectedItems
    *                            elementAt(index)
    *                            .provinceName),
    *                     onDeleted: () {
    *                         controller
    *                          .removeItemSelectedListAt(index);
    *                     },
    *                 );
    *             },
    *          ),
   */
  final Widget listBuilderChip;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: listBuilderChip,
          ),
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: MultiSelectBottomSheet<V>(
                    items: items,
                    initialValue: selectedItems,
                    onSelectionChanged: onSelectionChanged,
                    onConfirm: onConfirm,
                    cancelText: cancelText,
                    confirmText: confirmText,
                    searchable: searchable,
                    selectedColor: selectedColor,
                    initialChildSize: initialChildSize,
                    minChildSize: minChildSize,
                    maxChildSize: maxChildSize,
                    searchIcon: searchIcon,
                    itemsTextStyle: itemsTextStyle,
                    searchTextStyle: searchTextStyle,
                    searchHint: searchHint,
                    searchHintStyle: searchHintStyle,
                    selectedItemsTextStyle: selectedItemsTextStyle,
                    checkColor: checkColor,
                    isShowActionButton: isShowActionButton,
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
    );
  }
}
