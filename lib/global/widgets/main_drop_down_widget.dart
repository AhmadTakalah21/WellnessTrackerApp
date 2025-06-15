import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

abstract class DropDownItemModel {
  String get displayName;
  int get id;
}

class MainDropDownWidget<T extends DropDownItemModel> extends StatefulWidget {
  const MainDropDownWidget({
    super.key,
    required this.items,
    required this.text,
    this.offsetY = 0,
    required this.onChanged,
    required this.focusNode,
    this.selectedValue,
    this.expandedHeight = 200,
    this.errorText,
    this.height,
    this.width,
    this.label,
    this.backgrounColor,
    this.color,
    this.onClearTap,
    this.prefixIcon,
    this.canClear = true,
  });

  final List<T> items;
  final String text;
  final ValueSetter<T?> onChanged;
  final T? selectedValue;
  final double? expandedHeight;
  final String? errorText;
  final double offsetY;
  final FocusNode focusNode;
  final double? height;
  final double? width;
  final String? label;
  final Color? backgrounColor;
  final Color? color;
  final VoidCallback? onClearTap;
  final bool canClear;
  final IconData? prefixIcon;

  @override
  State<MainDropDownWidget<T>> createState() => _MainDropDownWidgetState<T>();
}

class _MainDropDownWidgetState<T extends DropDownItemModel>
    extends State<MainDropDownWidget<T>> {
  late T? selectedValue = widget.selectedValue;

  @override
  Widget build(BuildContext context) {
    final errorText = widget.errorText;
    final label = widget.text;
    final hasValue = selectedValue != null;
    final hasFocus = widget.focusNode.hasFocus;
    final prefixIcon = widget.prefixIcon;

    return Focus(
      focusNode: widget.focusNode,
      onFocusChange: (_) => setState(() {}),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasFocus || hasValue)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color:
                      errorText != null
                          ? AppColors.red
                          : widget.color ?? AppColors.blue,
                ),
              ),
            ),
          if (hasFocus || hasValue) const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<T>(
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: widget.color,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: widget.expandedHeight,
                      width: widget.width,
                      offset: Offset(0, widget.offsetY),
                    ),
                    selectedItemBuilder: (BuildContext context) {
                      return widget.items.map((T item) {
                        return Row(
                          children: [
                            if (prefixIcon != null) ...[
                              Icon(
                                prefixIcon,
                                size: 20,
                                color:
                                    errorText == null
                                        ? widget.color ?? AppColors.mainColor
                                        : AppColors.red,
                              ),
                              const SizedBox(width: 12),
                            ],
                            Flexible(
                              child: Text(
                                item.displayName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    },
                    buttonStyleData: ButtonStyleData(
                      height: widget.height,
                      padding: const EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                        color: widget.backgrounColor,
                        border: Border.all(
                          color:
                              errorText == null
                                  ? (hasFocus || hasValue)
                                      ? AppColors.mainColor
                                      : AppColors.grey.withValues(alpha: 0.5)
                                  : AppColors.red,
                        ),
                        borderRadius: AppConstants.borderRadius5,
                      ),
                    ),
                    isExpanded: true,
                    value: selectedValue,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.19,
                      overflow: TextOverflow.ellipsis,
                    ),
                    hint: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (prefixIcon != null) ...[
                          Icon(
                            prefixIcon,
                            size: 20,
                            color:
                                errorText == null
                                    ? widget.color ?? AppColors.mainColor
                                    : AppColors.red,
                          ),
                          const SizedBox(width: 12),
                        ],
                        Text(
                          label,
                          style: TextStyle(
                            color:
                                errorText == null
                                    ? widget.color ?? AppColors.grey
                                    : AppColors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.19,
                          ),
                        ),
                      ],
                    ),
                    items:
                        widget.items
                            .map(
                              (T item) => DropdownMenuItem<T>(
                                value: item,
                                child: Text(
                                  item.displayName,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                      widget.onChanged(value);
                    },
                  ),
                ),
              ),
              if (selectedValue != null && widget.canClear)
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedValue = null;
                    });
                    widget.onChanged(null);
                  },
                  icon: const Icon(Icons.close, color: AppColors.grey),
                ),
            ],
          ),
          if (errorText != null) const SizedBox(height: 8),
          if (errorText != null)
            Padding(
              padding: AppConstants.paddingH8,
              child: Text(
                errorText,
                style: const TextStyle(fontSize: 10, color: AppColors.red),
              ),
            ),
        ],
      ),
    );
  }
}
