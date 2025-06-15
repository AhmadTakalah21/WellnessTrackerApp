import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.labelText,
    this.textInputType,
    this.hintText,
    this.inputFormatters,
    this.initialText,
    this.errorText,
    this.padding,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.floatingLabelColor,
    this.hintStyle,
    this.borderRadius,
    this.borderColor,
    this.outlineInputBorder,
    this.fillColor,
    this.filled,
    this.onClearTap,
    this.showCloseIcon,
    this.title,
    this.prefixIcon,
    this.hintColor,
  });

  final String? hintText;
  final String? initialText;
  final String? title;
  final ValueSetter<String>? onChanged;
  final ValueSetter<String>? onSubmitted;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final EdgeInsets? padding;
  final String? labelText;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final Color? floatingLabelColor;
  final Color? borderColor;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final Color? hintColor;
  final BorderRadius? borderRadius;
  final InputBorder? outlineInputBorder;
  final bool? filled;
  final VoidCallback? onClearTap;
  final bool? showCloseIcon;

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  late Color? floatingLabelColor = widget.floatingLabelColor;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    final suffixIcon = widget.suffixIcon;
    final prefixIcon = widget.prefixIcon;
    final showCloseIcon = widget.showCloseIcon ?? true;
    final title = widget.title;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.greyShade3,
            ),
          ),
        if (title != null) const SizedBox(height: 10),
        TextFormField(
          controller: _controller,
          obscureText: widget.obscureText,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: (text) {
            widget.onChanged?.call(text);
            setState(() {});
          },
          onFieldSubmitted: widget.onSubmitted,
          focusNode: widget.focusNode,
          keyboardType: widget.textInputType ?? TextInputType.name,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            contentPadding: widget.padding ?? AppConstants.padding6,
            labelText: widget.labelText,
            floatingLabelStyle: TextStyle(
              color:
                  widget.errorText == null
                      ? floatingLabelColor ?? AppColors.blue
                      : AppColors.red,
            ),
            labelStyle: TextStyle(
              color: widget.errorText == null ? AppColors.grey : AppColors.red,
              fontSize: 14,
            ),
            hintText: widget.hintText,
            hintStyle:
                widget.hintStyle ??
                TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 1.19,
                  color: widget.hintColor,
                ),
            errorStyle: const TextStyle(fontSize: 16, color: AppColors.red),
            errorText: widget.errorText,
            border:
                widget.outlineInputBorder ??
                OutlineInputBorder(
                  borderRadius:
                      widget.borderRadius ?? AppConstants.borderRadius5,
                  borderSide: BorderSide(
                    color:
                        widget.borderColor ??
                        AppColors.grey.withValues(alpha: 0.5),
                  ),
                ),
            focusedBorder:
                widget.outlineInputBorder ??
                OutlineInputBorder(
                  borderRadius:
                      widget.borderRadius ?? AppConstants.borderRadius5,
                  borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.blue,
                  ),
                ),
            enabledBorder:
                widget.outlineInputBorder ??
                OutlineInputBorder(
                  borderRadius:
                      widget.borderRadius ?? AppConstants.borderRadius5,
                  borderSide: BorderSide(
                    color:
                        widget.borderColor ??
                        AppColors.grey.withValues(alpha: 0.5),
                  ),
                ),
            errorBorder:
                widget.outlineInputBorder ??
                OutlineInputBorder(
                  borderRadius:
                      widget.borderRadius ?? AppConstants.borderRadius5,
                  borderSide: const BorderSide(color: AppColors.red),
                ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (suffixIcon != null) suffixIcon,
                if (_controller.text.isNotEmpty && showCloseIcon)
                  InkWell(
                    onTap: () {
                      _controller.clear();
                      widget.onChanged?.call("");
                      widget.onClearTap?.call();
                      setState(() {});
                    },
                    child: const Icon(Icons.close, color: AppColors.grey),
                  ),
                if (!widget.readOnly &&
                    _controller.text.isNotEmpty &&
                    showCloseIcon)
                  const SizedBox(width: 10),
              ],
            ),
            prefixIcon: prefixIcon,
            fillColor: widget.fillColor,
            filled: widget.filled,
          ),
        ),
      ],
    );
  }
}
