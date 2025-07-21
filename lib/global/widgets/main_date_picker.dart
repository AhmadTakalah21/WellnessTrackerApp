import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/extensions/date_x.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
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
    this.validator,
    this.firstDate,
  });

  final String label;
  final String hintText;
  final bool isStart;
  final bool isEnd;
  final void Function(DateTime? date) onDateSelected;
  final DateTime? firstDate;
  final String? initialDate;
  final EdgeInsets? padding;
  final String? Function(DateTime?)? validator;

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

  Future<void> onPickDate(FormFieldState<DateTime?> field) async {
    final date = await showDatePicker(
      context: context,
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
      widget.onDateSelected(date);
      field.didChange(date);
    }
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

    return FormField<DateTime?>(
      validator: widget.validator,
      initialValue: selectedDate,
      builder: (field) {
        final hasError = field.hasError;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.tr(), style: context.tt.titleLarge),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => onPickDate(field),
              child: Container(
                padding: AppConstants.padding0,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: hasError ? 1 : 2,
                    color: hasError ? context.cs.error : context.cs.primary,
                  ),
                  borderRadius: AppConstants.borderRadius10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => onPickDate(field),
                      icon: Icon(
                        Icons.date_range,
                        color: context.cs.primary,
                      ),
                    ),
                    if (selectedDate?.formatYYYYMMDD != null)
                      Text("${label.tr()}: "),
                    Text(selectedDate?.formatYYYYMMDD ?? hintText.tr())
                  ],
                ),
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                child: Text(
                  field.errorText ?? '',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
