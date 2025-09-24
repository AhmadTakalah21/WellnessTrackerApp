import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/models/user_view_on_permission_model.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class DashboardCardWidget extends StatefulWidget {
  const DashboardCardWidget({
    super.key,
    required this.module,
    required this.onTap,
  });
  final UserViewOnPermissionModel module;
  final VoidCallback onTap;

  @override
  State<DashboardCardWidget> createState() => DashboardCardWidgetState();
}

class DashboardCardWidgetState extends State<DashboardCardWidget> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final m = widget.module;
    final cardColor = Theme.of(context).cardColor;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: widget.onTap,
      onHighlightChanged: (v) => setState(() => _pressed = v),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? .96 : 1,
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              if (!_pressed)
                const BoxShadow(
                  blurRadius: 12,
                  color: Colors.black12,
                  offset: Offset(0, 6),
                ),
            ],
            border: Border.all(color: m.color.withOpacity(.18), width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      m.color.withOpacity(.16),
                      m.color.withOpacity(.04)
                    ],
                  ),
                ),
                child: Padding(
                  padding: AppConstants.padding16,
                  child: Icon(m.icon, size: 32, color: m.color),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: AppConstants.paddingH4,
                child: Text(
                  m.title.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
