import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/extensions/date_x.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class MainDatePicker extends StatefulWidget {
  const MainDatePicker({
    super.key,
    required this.label,
    required this.onDateSelected,
  });

  final String label;
  final void Function() onDateSelected;

  @override
  State<MainDatePicker> createState() => _MainDatePickerState();
}

class _MainDatePickerState extends State<MainDatePicker> {
  DateTime? selectedDate;
  Future<void> onPickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    setState(() {
      selectedDate = date;
    });
    widget.onDateSelected();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label.tr(), style: context.tt.titleLarge),
        SizedBox(height: 10),
        InkWell(
          onTap: onPickDate,
          child: Container(
            padding: AppConstants.padding0,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: context.cs.primary),
              borderRadius: AppConstants.borderRadius10,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: onPickDate,
                  icon: Icon(Icons.date_range),
                ),
                Text(selectedDate?.formatYYYYMMDD ?? "pick_date".tr())
              ],
            ),
          ),
        ),
      ],
    );
  }
}
