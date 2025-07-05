import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wellnesstrackerapp/global/theme/theme_x.dart';

class MainTextField2 extends StatefulWidget {
  const MainTextField2({
    super.key,
    this.controller,
    required this.label,
    required this.icon,
    this.hint,
    this.validator,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.isPassword = false,
    this.onChanged,
    this.initialText,
    this.keyboardType, this.inputFormatters,
  });

  final TextEditingController? controller;
  final String? initialText;
  final String label;
  final IconData icon;
  final bool isPassword;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<MainTextField2> createState() => _MainTextField2State();
}

class _MainTextField2State extends State<MainTextField2> {
  late bool isVisible = widget.isPassword;

  void setVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label.tr(), style: context.tt.titleLarge),
        SizedBox(height: 10),
        TextFormField(
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          initialValue: widget.initialText,
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: isVisible,
          style: context.tt.bodyMedium,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: context.cs.primary),
            labelText: widget.label,
            labelStyle: TextStyle(color: Colors.grey[500]),
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            floatingLabelBehavior: widget.floatingLabelBehavior,
            filled: true,
            fillColor: context.cs.surfaceVariant,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.cs.primary, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: context.cs.primary, width: 2),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: setVisible,
                    icon: Icon(
                      isVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: context.cs.primary,
                    ),
                  )
                : null,
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
