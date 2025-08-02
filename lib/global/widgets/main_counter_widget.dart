import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

class MainCounterWidget extends StatefulWidget {
  const MainCounterWidget({
    super.key,
    required this.label,
    required this.icon,
    this.minCount,
    required this.onChanged,
    this.maxCount,
    this.initialCount,
  });
  final void Function(int value) onChanged;
  final int? initialCount;
  final int? minCount;
  final int? maxCount;
  final String label;
  final IconData icon;

  @override
  State<MainCounterWidget> createState() => _MainCounterWidgetState();
}

class _MainCounterWidgetState extends State<MainCounterWidget> {
  late final controller = TextEditingController(
      text: widget.initialCount?.toString() ?? widget.minCount?.toString());
  late int counter = widget.initialCount ?? widget.minCount ?? 0;

  void onIncreaseTap() {
    if (widget.maxCount != null && counter < widget.maxCount!) {
      setState(() {
        counter++;
      });
    }
    controller.text = counter.toString();
    widget.onChanged(counter);
  }

  void onDecreaseTap() {
    if (counter != (widget.minCount ?? 0)) {
      setState(() {
        counter--;
      });
    }
    controller.text = counter.toString();
    widget.onChanged(counter);
  }

  @override
  Widget build(BuildContext context) {
    return MainTextField2(
      //controller: widget.controller,
      controller: controller,
      label: widget.label,
      icon: widget.icon,
      suffix: Column(
        children: [
          InkWell(
            //onTap: widget.onIncreaseTap,
            onTap: onIncreaseTap,
            child: Icon(
              Icons.arrow_drop_up,
              color: context.cs.secondary,
            ),
          ),
          InkWell(
            //onTap: widget.onDecreaseTap,
            onTap: onDecreaseTap,
            child: Icon(
              Icons.arrow_drop_down,
              color: context.cs.secondary,
            ),
          ),
        ],
      ),
      readOnly: true,
      validator: (val) => val == null || val == '0' ? "required".tr() : null,
    );
  }
}
