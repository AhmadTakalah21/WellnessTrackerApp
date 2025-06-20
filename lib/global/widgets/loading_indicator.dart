import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.color,
    this.width,
    this.height,
    this.size = 40,
  });

  final Color? color;
  final double? width;
  final double? height;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: SpinKitFadingCircle(
        size: size,
        color: color ?? context.cs.primary,
      ),
    );
  }
}
