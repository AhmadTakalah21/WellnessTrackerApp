import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';

abstract class DropDownItemModel {
  String get displayName;
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
    required this.errorMessage,
    this.icon,
    required this.onChanged,
  });

  final List<T> items;
  final ValueSetter<T?> onChanged;
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final String errorMessage;
  final T? selectedValue;
  final IconData? icon;

  @override
  State<MainDropDownWidget<T>> createState() => _MainDropDownWidgetState<T>();
}

class _MainDropDownWidgetState<T extends DropDownItemModel>
    extends State<MainDropDownWidget<T>> {
  late T? selectedValue = widget.selectedValue;

  @override
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedValue,
      hint: Text(
        widget.hintText,
        style: context.tt.bodyMedium?.copyWith(color: Colors.grey[500]),
      ),
      icon: Icon(widget.icon ?? LucideIcons.chevronDown,
          color: context.cs.primary),
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixIcon, color: context.cs.primary),
        labelText: widget.labelText,
        filled: true,
        fillColor: context.cs.surfaceVariant,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.cs.primary, width: 2),
        ),
      ),
      style: context.tt.bodyMedium,
      items: widget.items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item.displayName, style: context.tt.bodyMedium),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => selectedValue = value);
        widget.onChanged(value);
      },
      validator: (value) => value == null ? widget.errorMessage : null,
    );
  }
}
