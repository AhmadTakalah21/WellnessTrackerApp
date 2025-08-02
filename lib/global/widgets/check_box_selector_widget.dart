import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

class CheckBoxSelectorWidget<T extends DropDownItemModel>
    extends StatefulWidget {
  const CheckBoxSelectorWidget({
    super.key,
    required this.items,
    required this.onSelected,
    this.selected,
    this.title,
    this.isAlignVertically = false,
  });

  final List<T> items;
  final T? selected;
  final void Function(T item) onSelected;
  final String? title;
  final bool isAlignVertically;

  @override
  State<CheckBoxSelectorWidget<T>> createState() =>
      _CheckBoxSelectorWidgetState<T>();
}

class _CheckBoxSelectorWidgetState<T extends DropDownItemModel>
    extends State<CheckBoxSelectorWidget<T>> {
  late T? selected = widget.selected;

  bool isItemSelected(DropDownItemModel item) => selected?.id == item.id;

  void onSelectTap(T item) {
    setState(() {
      selected = item;
    });
    widget.onSelected(item);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(title, style: context.tt.titleLarge),
          const SizedBox(height: 10),
        ],
        Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 16,
          runSpacing: 5,
          children: [
            for (final item in widget.items)
              InkWell(
                onTap: () => onSelectTap(item),
                child: Padding(
                  padding: AppConstants.paddingV10,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.isAlignVertically) const SizedBox(width: 30),
                      SizedBox(
                        width: 10,
                        height: 10,
                        child: Checkbox(
                          value: isItemSelected(item),
                          onChanged: (_) => onSelectTap(item),
                          activeColor: context.cs.primary,
                          checkColor: context.cs.surface,
                          side: BorderSide(color: context.cs.primary, width: 2),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(item.displayName),
                      if (widget.isAlignVertically) const Spacer(),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
