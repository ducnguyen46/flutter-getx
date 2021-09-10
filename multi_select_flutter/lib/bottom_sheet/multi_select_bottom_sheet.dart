import 'package:flutter/material.dart';
import '../util/multi_select_item.dart';
import '../util/multi_select_actions.dart';
import '../util/multi_select_list_type.dart';

/// A bottom sheet widget containing either a classic checkbox style list, or a chip style list.
class MultiSelectBottomSheet<V> extends StatefulWidget
    with MultiSelectActions<V> {
  /// List of items to select from.
  final List<MultiSelectItem<V>> items;

  /// The list of selected values before interaction.
  final List<V>? initialValue;

  /// The text at the top of the BottomSheet.
  final Widget? title;

  /// Fires when the an item is selected / unselected.
  final void Function(List<V>)? onSelectionChanged;

  /// Fires when confirm is tapped.
  final void Function(List<V>)? onConfirm;

  /// Toggles search functionality.
  final bool? searchable;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// An enum that determines which type of list to render.
  final MultiSelectListType? listType;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color? selectedColor;

  /// Set the initial height of the BottomSheet.
  final double? initialChildSize;

  /// Set the minimum height threshold of the BottomSheet before it closes.
  final double? minChildSize;

  /// Set the maximum height of the BottomSheet.
  final double? maxChildSize;

  /// Set the placeholder text of the search field.
  final String? searchHint;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color? Function(V)? colorator;

  /// Color of the chip body or checkbox border while not selected.
  final Color? unselectedColor;

  /// Icon button that shows the search field.
  final Widget? searchIcon;

  /// Icon button that hides the search field
  final Widget? closeSearchIcon;

  /// Style the text on the chips or list tiles.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Style the search text.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  /// Show action button OK [onConfirm] and Cancel.
  /// Default value is false
  final bool isShowActionButton;

  MultiSelectBottomSheet({
    required this.items,
    required this.initialValue,
    this.title,
    this.onSelectionChanged,
    this.onConfirm,
    this.listType,
    this.cancelText,
    this.confirmText,
    this.searchable,
    this.selectedColor,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.colorator,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchTextStyle,
    this.searchHint,
    this.searchHintStyle,
    this.selectedItemsTextStyle,
    this.checkColor,
    this.isShowActionButton = false,
  });

  @override
  _MultiSelectBottomSheetState<V> createState() =>
      _MultiSelectBottomSheetState<V>(items);
}

class _MultiSelectBottomSheetState<V> extends State<MultiSelectBottomSheet<V>> {
  List<V> _selectedValues = [];
  List<MultiSelectItem<V>> _items;

  _MultiSelectBottomSheetState(this._items);

  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _selectedValues.addAll(widget.initialValue!);
    }
  }

  /// Returns a CheckboxListTile
  Widget _buildListItem(MultiSelectItem<V> item) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: widget.unselectedColor ?? Colors.black54,
        accentColor: widget.selectedColor ?? Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          CheckboxListTile(
            checkColor: widget.checkColor,
            value: _selectedValues.contains(item.value),
            activeColor: widget.colorator != null
                ? widget.colorator!(item.value) ?? widget.selectedColor
                : widget.selectedColor,
            title: Text(
              item.label,
              style: _selectedValues.contains(item.value)
                  ? widget.selectedItemsTextStyle
                  : widget.itemsTextStyle,
            ),
            controlAffinity: ListTileControlAffinity.leading,
            // contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            onChanged: (checked) {
              setState(() {
                _selectedValues = widget.onItemCheckedChange(
                    _selectedValues, item.value, checked!);
              });
              if (widget.onSelectionChanged != null) {
                widget.onSelectionChanged!(_selectedValues);
              }
            },
          ),
          const Divider(
            color: Colors.black,
            thickness: 1.5,
            height: 0,
          ),
        ],
      ),
    );
  }

  /// Returns a ChoiceChip
  Widget _buildChipItem(MultiSelectItem<V> item) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        backgroundColor: widget.unselectedColor,
        selectedColor:
            widget.colorator != null && widget.colorator!(item.value) != null
                ? widget.colorator!(item.value)
                : widget.selectedColor != null
                    ? widget.selectedColor
                    : Theme.of(context).primaryColor.withOpacity(0.35),
        label: Text(
          item.label,
          style: _selectedValues.contains(item.value)
              ? TextStyle(
                  color: widget.colorator != null &&
                          widget.colorator!(item.value) != null
                      ? widget.selectedItemsTextStyle != null
                          ? widget.selectedItemsTextStyle!.color ??
                              widget.colorator!(item.value)!.withOpacity(1)
                          : widget.colorator!(item.value)!.withOpacity(1)
                      : widget.selectedItemsTextStyle != null
                          ? widget.selectedItemsTextStyle!.color ??
                              (widget.selectedColor != null
                                  ? widget.selectedColor!.withOpacity(1)
                                  : Theme.of(context).primaryColor)
                          : widget.selectedColor != null
                              ? widget.selectedColor!.withOpacity(1)
                              : null,
                  fontSize: widget.selectedItemsTextStyle != null
                      ? widget.selectedItemsTextStyle!.fontSize
                      : null,
                )
              : widget.itemsTextStyle,
        ),
        selected: _selectedValues.contains(item.value),
        onSelected: (checked) {
          setState(() {
            _selectedValues = widget.onItemCheckedChange(
                _selectedValues, item.value, checked);
          });
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged!(_selectedValues);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: widget.initialChildSize ?? 1,
      minChildSize: widget.minChildSize ?? 0.5,
      maxChildSize: widget.maxChildSize ?? 1,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Column(
          children: [
            if (widget.searchable != null && widget.searchable!)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 24,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: widget.searchIcon ?? Icon(Icons.search),
                      ),

                      // Nếu cho phép search

                      // hiển thị [TextField]
                      Expanded(
                        child: TextField(
                          style: widget.searchTextStyle,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 8,
                            ),
                            border: InputBorder.none,
                            hintStyle: widget.searchHintStyle,
                            hintText: widget.searchHint ?? "Search",
                          ),
                          onChanged: (val) {
                            setState(() {
                              _items =
                                  widget.updateSearchQuery(val, widget.items);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Expanded(
              child: widget.listType == null ||
                      widget.listType == MultiSelectListType.LIST
                  ? ListView.builder(
                      // controller: scrollController,
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return _buildListItem(_items[index]);
                      },
                    )
                  : SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Wrap(
                          children: _items.map(_buildChipItem).toList(),
                        ),
                      ),
                    ),
            ),
            if (widget.isShowActionButton)
              Container(
                padding: EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          widget.onCancelTap(context, widget.initialValue!);
                        },
                        child: widget.cancelText ??
                            Text(
                              "CANCEL",
                              style: TextStyle(
                                color: (widget.selectedColor != null &&
                                        widget.selectedColor !=
                                            Colors.transparent)
                                    ? widget.selectedColor!.withOpacity(1)
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          widget.onConfirmTap(
                              context, _selectedValues, widget.onConfirm);
                        },
                        child: widget.confirmText ??
                            Text(
                              "OK",
                              style: TextStyle(
                                color: (widget.selectedColor != null &&
                                        widget.selectedColor !=
                                            Colors.transparent)
                                    ? widget.selectedColor!.withOpacity(1)
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
