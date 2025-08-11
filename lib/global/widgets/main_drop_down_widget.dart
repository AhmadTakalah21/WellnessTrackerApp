import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

abstract class DropDownItemModel {
  String get displayName;
  String get displayEntityName;
  int get id;
}

class MainDropDownWidget<T extends DropDownItemModel> extends StatefulWidget {
  const MainDropDownWidget({
    super.key,
    required this.items,
    this.selectedValue,
    required this.prefixIcon,
    required this.hintText,
    required this.labelText,
    this.errorMessage = "required",
    this.icon,
    required this.onChanged,
    this.isEntityName = false,
    this.onLongPress,
  });

  final List<T> items;
  final void Function(T?) onChanged;
  final void Function(T)? onLongPress;
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final String? errorMessage;
  final T? selectedValue;
  final IconData? icon;
  final bool isEntityName;

  @override
  State<MainDropDownWidget<T>> createState() => _MainDropDownWidgetState<T>();
}

class _MainDropDownWidgetState<T extends DropDownItemModel>
    extends State<MainDropDownWidget<T>> {
  late T? selectedValue = widget.selectedValue;

  @override
  void didUpdateWidget(MainDropDownWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (selectedValue != null &&
        !widget.items.any((item) => item.id == selectedValue?.id)) {
      setState(() {
        selectedValue = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEntityName = widget.isEntityName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText, style: context.tt.titleLarge),
        SizedBox(height: 10),
        // DropdownButtonFormField2<T>(
        //   iconStyleData: IconStyleData(iconEnabledColor: context.cs.primary),
        //   isExpanded: true,
        //   value: selectedValue,
        //   decoration: InputDecoration(
        //     prefixIcon: Icon(widget.prefixIcon, color: context.cs.primary),
        //     filled: true,
        //     contentPadding: AppConstants.padding16,
        //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        //     enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: BorderSide(color: context.cs.primary, width: 2),
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: BorderSide(color: context.cs.primary, width: 2),
        //     ),
        //   ),
        //   hint: Text(
        //     widget.hintText,
        //     style: context.tt.bodyMedium?.copyWith(color: Colors.grey[500]),
        //   ),
        //   items: widget.items.map((item) {
        //     return DropdownMenuItem<T>(
        //       value: item,
        //       child: Text(item.displayName, style: context.tt.bodyMedium),
        //     );
        //   }).toList(),
        //   onChanged: (value) {
        //     setState(() => selectedValue = value);
        //     widget.onChanged(value);
        //   },
        //   validator: (value) => value == null ? widget.errorMessage : null,
        //   dropdownStyleData: DropdownStyleData(
        //     padding: AppConstants.paddingH20,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //   ),
        // )

        DropdownButtonFormField<T>(
          borderRadius: AppConstants.borderRadius20,
          value: selectedValue,
          hint: Text(
            widget.hintText,
            style: context.tt.bodyMedium?.copyWith(color: Colors.grey[500]),
          ),
          icon: Icon(widget.icon ?? LucideIcons.chevronDown,
              color: context.cs.primary),
          decoration: InputDecoration(
            prefixIcon: Icon(widget.prefixIcon, color: context.cs.primary),
            filled: true,
            fillColor: context.cs.surfaceVariant,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.cs.primary, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.cs.primary, width: 2),
            ),
          ),
          style: context.tt.bodyMedium,
          items: widget.items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: InkWell(
                onLongPress: () => widget.onLongPress?.call(item),
                child: Text(
                  isEntityName ? item.displayEntityName : item.displayName,
                  style: context.tt.bodyMedium,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => selectedValue = value);
            widget.onChanged(value);
          },
          validator: (value) =>
              value == null ? widget.errorMessage?.tr() : null,
        ),
      ],
    );
  }
}
