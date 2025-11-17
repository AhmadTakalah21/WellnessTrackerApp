import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';

class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.labelText,
    this.initialCountryCode,
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
    this.titleSize,
    this.titleStyle,
    this.validator,
  });

  final String? hintText;
  final String? initialText;
  final String? initialCountryCode;
  final String? title;
  final TextStyle? titleStyle;
  final double? titleSize;
  final ValueSetter<PhoneNumber?>? onChanged;
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
  final String? Function(String?)? validator;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
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

    final primaryColor = context.cs.primary;
    final baseBorder = OutlineInputBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
      borderSide: BorderSide(color: primaryColor, width: 1.5),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title,
            style: widget.titleStyle ??
                TextStyle(
                  fontSize: widget.titleSize ?? 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 8),
        ],
        IntlPhoneField(
          textAlign: TextAlign.start,
          controller: _controller,
          obscureText: widget.obscureText,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          initialValue: widget.initialText,
          onChanged: (value) {
            widget.onChanged?.call(value);
            setState(() {});
          },
          onSubmitted: widget.onSubmitted,
          focusNode: widget.focusNode,
          keyboardType: widget.textInputType ?? TextInputType.name,
          inputFormatters: widget.inputFormatters,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
            contentPadding: widget.padding ??
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            labelText: widget.labelText,
            floatingLabelStyle: TextStyle(
              color: widget.errorText == null
                  ? floatingLabelColor ?? primaryColor
                  : AppColors.red,
              fontWeight: FontWeight.w600,
            ),
            labelStyle: TextStyle(
              color: widget.errorText == null
                  ? Colors.grey.shade700
                  : AppColors.red,
              fontSize: 14,
            ),
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                TextStyle(
                  fontSize: 14,
                  color: widget.hintColor ?? Colors.grey.shade500,
                ),
            errorStyle: const TextStyle(fontSize: 13, color: AppColors.red),
            errorText: widget.errorText,
            border: baseBorder,
            focusedBorder: baseBorder,
            enabledBorder: baseBorder,
            errorBorder: baseBorder.copyWith(
              borderSide: const BorderSide(color: AppColors.red),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (suffixIcon != null) suffixIcon,
                if (_controller.text.isNotEmpty && showCloseIcon)
                  InkWell(
                    onTap: () {
                      _controller.clear();
                      widget.onChanged?.call(null);
                      widget.onClearTap?.call();
                      setState(() {});
                    },
                    child: const Icon(Icons.close, color: Colors.grey),
                  ),
                if (!widget.readOnly &&
                    _controller.text.isNotEmpty &&
                    showCloseIcon)
                  const SizedBox(width: 10),
              ],
            ),
            fillColor: widget.fillColor ?? Colors.white,
            filled: widget.filled ?? true,
          ),
          invalidNumberMessage: "invalid_phone".tr(),
          initialCountryCode: widget.initialCountryCode ?? "US",
          showCountryFlag: false,
          flagsButtonMargin: const EdgeInsets.symmetric(horizontal: 12),
          dropdownIcon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: context.cs.primary,
          ),
          dropdownIconPosition: IconPosition.trailing,
          pickerDialogStyle:
              PickerDialogStyle(backgroundColor: context.cs.surface),
          cursorColor: context.cs.primary,
        ),
        // FormField(
        //   validator: widget.validator,
        //   builder: (field) {
        //     final hasError = field.hasError;
        //     final color = hasError ? context.cs.error : primaryColor;
        //     final width = hasError ? 1.0 : 2.0;
        //     final baseBorder = OutlineInputBorder(
        //       borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
        //       borderSide: BorderSide(color: color, width: width),
        //     );
        //     return Column(
        //       mainAxisSize: MainAxisSize.min,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         if (hasError)
        //           Padding(
        //             padding: const EdgeInsets.only(top: 8.0, left: 4.0),
        //             child: Text(
        //               field.errorText ?? '',
        //               style: TextStyle(color: Colors.red, fontSize: 12),
        //             ),
        //           ),
        //       ],
        //     );
        //   },
        // ),
      ],
    );
  }
}
