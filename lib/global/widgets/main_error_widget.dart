import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';

class MainErrorWidget extends StatelessWidget {
  const MainErrorWidget({
    super.key,
    required this.error,
    this.onTryAgainTap,
    this.height = 0,
    this.isRefresh = false,
  });

  final String error;
  final VoidCallback? onTryAgainTap;
  final bool isRefresh;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height),
          Text(
            error,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          if (onTryAgainTap != null)
            ...[
              SizedBox(height: 5),
              InkWell(
              onTap: onTryAgainTap,
              child: Text(
                isRefresh ? "refresh".tr() : "try_again".tr(),
                style: TextStyle(
                  color: context.cs.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )]
        ],
      ),
    );
  }
}
