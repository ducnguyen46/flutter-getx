import 'package:flutter/material.dart';

class CusChip extends StatelessWidget {
  const CusChip(
      {Key? key,
      required this.label,
      this.onDeleted,
      this.labelStyle,
      this.backgroundColor,
      this.deleteIcon,
      this.deleteIconColor})
      : super(key: key);
  final Widget label;
  final Function()? onDeleted;
  final TextStyle? labelStyle;
  final Color? backgroundColor;
  final Widget? deleteIcon;
  final Color? deleteIconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 2),
      child: Chip(
        label: label,
        onDeleted: onDeleted,
        labelStyle: labelStyle ?? TextStyle(color: Colors.white),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
        deleteIcon: deleteIcon ??
            Icon(
              Icons.close,
              size: 20,
            ),
        deleteIconColor: deleteIconColor ?? Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
