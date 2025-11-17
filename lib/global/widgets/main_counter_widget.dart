import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

class MainCounterWidget extends StatefulWidget {
  const MainCounterWidget({
    super.key,
    required this.label,
    required this.icon,
    this.minCount = 0,
    required this.onChanged,
    this.maxCount,
    this.initialCount,
    this.isRequired = true,
    this.inputFormatters,
  });
  final void Function(int value) onChanged;
  final int? initialCount;
  final int minCount;
  final int? maxCount;
  final String label;
  final IconData icon;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<MainCounterWidget> createState() => _MainCounterWidgetState();
}

class _MainCounterWidgetState extends State<MainCounterWidget> {
  late final TextEditingController controller;
  late int counter;

  @override
  void initState() {
    super.initState();
    counter = widget.initialCount ?? widget.minCount;
    controller = TextEditingController(text: widget.initialCount?.toString());

    controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    final value = int.tryParse(text);
    if (value != null) {
      print(value);
      var newValue = value;

      if (newValue < widget.minCount) {
        newValue = widget.minCount;
      }
      if (widget.maxCount != null && newValue > widget.maxCount!) {
        newValue = widget.maxCount!;
      }
      print("newValue is : $newValue");

      if (newValue != counter) {
        setState(() => counter = newValue);
        controller.text = counter.toString();
        widget.onChanged(counter);
      }
    }
  }

  void onIncreaseTap() {
    if (widget.maxCount != null && counter == widget.maxCount!) return;
    setState(() => counter++);
    controller.text = counter.toString();
    widget.onChanged(counter);
  }

  void onDecreaseTap() {
    if (counter <= widget.minCount) return;
    setState(() => counter--);
    controller.text = counter.toString();
    widget.onChanged(counter);
  }

  String? requiredValueValidator(String? val) {
    if (val == null || val.isEmpty || int.tryParse(val) == null) {
      return "required".tr();
    } else if (int.parse(val) < widget.minCount ||
        (widget.maxCount != null && int.parse(val) > widget.maxCount!)) {
      return "invalid_value".tr();
    } else {
      return null;
    }
  }

  String? optionalValueValidator(String? val) {
    if (val != null && val.isNotEmpty || int.tryParse(val!) != null) {
      if (int.parse(val) < widget.minCount ||
          (widget.maxCount != null && int.parse(val) > widget.maxCount!)) {
        return "invalid_value".tr();
      }
      return null;
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainTextField2(
      controller: controller,
      label: widget.label,
      icon: widget.icon,
      suffix: Column(
        children: [
          InkWell(
            onTap: onIncreaseTap,
            child: Icon(
              Icons.arrow_drop_up,
              color: context.cs.secondary,
            ),
          ),
          InkWell(
            onTap: onDecreaseTap,
            child: Icon(
              Icons.arrow_drop_down,
              color: context.cs.secondary,
            ),
          ),
        ],
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        ...?widget.inputFormatters,
        FilteringTextInputFormatter.digitsOnly
      ],
      validator:
          widget.isRequired ? requiredValueValidator : optionalValueValidator,
      // validator: (val) {
      //   if (val == null || val.isEmpty || int.tryParse(val) == null) {
      //     return "required".tr();
      //   } else if (int.parse(val) < widget.minCount ||
      //       (widget.maxCount != null && int.parse(val) > widget.maxCount!)) {
      //     return "invalid_value".tr();
      //   } else {
      //     return null;
      //   }
      // },
    );
  }
}
