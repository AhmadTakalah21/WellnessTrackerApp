import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

class MutliSelectorDropDown<T extends DropDownItemModel>
    extends StatefulWidget {
  const MutliSelectorDropDown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    this.selectedValues,
    this.errorMessage,
    this.icon,
    this.validator,
    this.onLongPress,
  });

  final List<T> items;
  final void Function(List<T>) onChanged;
  final void Function(T)? onLongPress;
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final String? errorMessage;
  final List<T>? selectedValues;
  final IconData? icon;
  final String? Function(T? value)? validator;

  @override
  State<MutliSelectorDropDown<T>> createState() =>
      _MutliSelectorDropDownState<T>();
}

class _MutliSelectorDropDownState<T extends DropDownItemModel>
    extends State<MutliSelectorDropDown<T>> {
  late List<T> selectedItems = widget.selectedValues ?? [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText, style: context.tt.titleLarge),
        SizedBox(height: 10),
        DropdownButtonHideUnderline(
          child: DropdownButton2<T>(
            iconStyleData: IconStyleData(
              openMenuIcon:
                  Icon(LucideIcons.chevronUp, color: context.cs.primary),
              icon: Icon(LucideIcons.chevronDown, color: context.cs.primary),
            ),
            isExpanded: true,
            hint: Text(
              widget.hintText,
              style: context.tt.bodyMedium?.copyWith(color: Colors.grey[500]),
            ),
            items: widget.items.map((item) {
              return DropdownMenuItem(
                value: item,
                enabled: false,
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    final isSelected = selectedItems.contains(item);
                    return InkWell(
                      onLongPress: () => widget.onLongPress?.call(item),
                      onTap: () {
                        isSelected
                            ? selectedItems.remove(item)
                            : selectedItems.add(item);
                        setState(() {});
                        menuSetState(() {});
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: context.cs.primary,
                              checkColor: context.cs.surface,
                              side: BorderSide(color: context.cs.secondary),
                              value: isSelected,
                              onChanged: (value) {
                                isSelected
                                    ? selectedItems.remove(item)
                                    : selectedItems.add(item);
                                setState(() {});
                                menuSetState(() {});
                                widget.onChanged(selectedItems);
                              },
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                item.displayName,
                                style: context.tt.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            value: selectedItems.isEmpty ? null : selectedItems.last,
            onChanged: (value) {},
            selectedItemBuilder: (context) {
              return widget.items.map(
                (item) {
                  return Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      (selectedItems.map((item) => item.displayName))
                          .toList()
                          .join(', '),
                      style: const TextStyle(fontSize: 14),
                      maxLines: null,
                    ),
                  );
                },
              ).toList();
            },
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: context.cs.primary),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
