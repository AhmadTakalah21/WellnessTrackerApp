import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wellnesstrackerapp/global/theme/theme_x.dart';

class MainTextField2 extends StatefulWidget {
  const MainTextField2({
    super.key,
    this.controller,
    this.label,
    required this.icon,
    this.hint,
    this.validator,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.isPassword = false,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.initialText,
    this.keyboardType,
    this.inputFormatters,
    this.isWithTitle = true,
    this.suffix,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final String? initialText;
  final String? label;
  final bool isWithTitle;
  final IconData icon;
  final bool isPassword;
  final bool readOnly;
  final int? maxLines;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;

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
    final labelText = widget.label?.tr();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null && widget.isWithTitle) ...[
          Text(labelText!, style: context.tt.titleLarge),
          const SizedBox(height: 10),
        ],
        TextFormField(
          onTapOutside: (_) {
            //FocusScope.of(context).unfocus();
            // Future.microtask(() {
            //   FocusManager.instance.primaryFocus?.unfocus();
            // });
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   FocusManager.instance.primaryFocus?.unfocus();
            // });
          },
          maxLines: widget.maxLines,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          initialValue: widget.initialText,
          controller: widget.controller,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          obscureText: isVisible,
          readOnly: widget.readOnly,
          style: context.tt.bodyMedium,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: context.cs.primary),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.grey[500]),
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            floatingLabelBehavior: widget.floatingLabelBehavior,
            filled: true,
            fillColor: context.cs.surfaceContainerHighest,
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
                : widget.suffix,
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
