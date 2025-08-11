import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class MainFloatingButton extends StatelessWidget {
  const MainFloatingButton({
    super.key,
    required this.onTap,
    this.padding,
    this.icon,
    this.heroTag,
  });

  final VoidCallback onTap;
  final EdgeInsets? padding;
  final IconData? icon;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? AppConstants.padding8,
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: onTap,
        shape: const RoundedRectangleBorder(
          borderRadius: AppConstants.borderRadiusCircle,
        ),
        backgroundColor: context.cs.primary,
        child: Icon(icon ?? Icons.add, color: context.cs.secondary, size: 25),
      ),
    );
  }
}
