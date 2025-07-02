import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/extensions/date_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class MainDatePicker extends StatefulWidget {
  const MainDatePicker({
    super.key,
    this.label = "date",
    required this.onDateSelected,
    this.padding,
    this.initialDate,
    this.hintText = "pick_date",
    this.isStart = false,
    this.isEnd = false,
  });

  final String label;
  final String hintText;
  final bool isStart;
  final bool isEnd;
  final void Function(DateTime? date) onDateSelected;
  final String? initialDate;
  final EdgeInsets? padding;

  @override
  State<MainDatePicker> createState() => _MainDatePickerState();
}

class _MainDatePickerState extends State<MainDatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      selectedDate = DateTime.tryParse(widget.initialDate!);
    }
  }

  Future<void> onPickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    setState(() {
      selectedDate = date;
    });
    widget.onDateSelected(date);
  }

  @override
  Widget build(BuildContext context) {
    final isStart = widget.isStart;
    final isEnd = widget.isEnd;
    final label = isStart
        ? "start_date"
        : isEnd
            ? "end_date"
            : widget.label;
    final hintText = isStart
        ? "pick_start_date"
        : isEnd
            ? "pick_end_date"
            : widget.hintText;
    return Padding(
      padding: widget.padding ?? AppConstants.paddingH10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onPickDate,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: AppColors.grey.withValues(alpha: 0.5),
                ),
                borderRadius: AppConstants.borderRadius10,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onPickDate,
                    icon: const Icon(Icons.date_range),
                  ),
                  if (selectedDate?.formatYYYYMMDD != null)
                    Text("${label.tr()}: "),
                  Text(selectedDate?.formatYYYYMMDD ?? hintText.tr())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
