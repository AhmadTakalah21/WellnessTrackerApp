import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class MainActionButton extends StatefulWidget {
  const MainActionButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textColor,
    this.duration,
    this.buttonColor,
    this.width,
    this.border,
    this.height,
    this.fontSize,
    this.shadow,
    this.fontWeight,
    this.borderRadius,
    this.padding,
    this.child,
    this.icon,
  });

  final VoidCallback onTap;
  final Duration? duration;
  final Color? buttonColor;
  final String text;
  final Color? textColor;
  final double? width;
  final double? height;
  final BoxBorder? border;
  final double? fontSize;
  final List<BoxShadow>? shadow;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Widget? child;
  final Icon? icon;

  @override
  State<MainActionButton> createState() => _MainActionButtonState();
}

class _MainActionButtonState extends State<MainActionButton> {
  @override
  Widget build(BuildContext context) {
    final icon = widget.icon;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: widget.padding ?? AppConstants.padding10,
        decoration: BoxDecoration(
          border: widget.border,
          color: widget.buttonColor ?? context.cs.primary,
          borderRadius: widget.borderRadius ?? AppConstants.borderRadius5,
          boxShadow: widget.shadow,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) icon,
              if (icon != null) const SizedBox(width: 5),
              widget.child ??
                  Text(
                    widget.text,
                    style: context.tt.titleMedium?.copyWith(
                      color: widget.textColor ?? AppColors.white,
                      fontSize: widget.fontSize ?? 18,
                      fontWeight: widget.fontWeight,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
