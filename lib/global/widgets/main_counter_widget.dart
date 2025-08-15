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
  late final TextEditingController controller;
  late int counter;
  // late final controller = TextEditingController(
  //     text: widget.initialCount?.toString() ?? widget.minCount?.toString());
  // late int counter = widget.initialCount ?? widget.minCount ?? 0;

  @override
  void initState() {
    super.initState();
    counter = widget.initialCount ?? widget.minCount ?? 0;
    controller = TextEditingController(text: counter.toString());

    controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    final value = int.tryParse(text);
    if (value != null) {
      var newValue = value;

      if (widget.minCount != null && newValue < widget.minCount!) {
        newValue = widget.minCount!;
      }
      if (widget.maxCount != null && newValue > widget.maxCount!) {
        newValue = widget.maxCount!;
      }

      if (newValue != counter) {
        setState(() => counter = newValue);
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
    if (widget.minCount != null && counter <= widget.minCount!) return;
    setState(() => counter--);
    controller.text = counter.toString();
    widget.onChanged(counter);

    // if (counter != (widget.minCount ?? 0)) {
    //   setState(() {
    //     counter--;
    //   });
    // }
    // controller.text = counter.toString();
    // widget.onChanged(counter);
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
      // validator: (val) => val == null || val == '0' ? "required".tr() : null,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (val) =>
          val == null || val.isEmpty || int.tryParse(val) == null
              ? "required".tr()
              : null,
    );
  }
}
