import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class MainAddFloatingButton extends StatelessWidget {
  const MainAddFloatingButton({
    super.key,
    required this.onAddTap,
    this.padding,
    this.icon,
    this.heroTag,
  });

  final VoidCallback onAddTap;
  final EdgeInsets? padding;
  final IconData? icon;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? AppConstants.padding8,
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: onAddTap,
        shape: const RoundedRectangleBorder(
          borderRadius: AppConstants.borderRadiusCircle,
        ),
        backgroundColor: context.cs.primary,
        child: Icon(icon ?? Icons.add, color: context.cs.onSurface, size: 25),
      ),
    );
  }
}
