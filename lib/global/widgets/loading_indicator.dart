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
    this.isInBtn = false,
  });

  final Color? color;
  final double? width;
  final double? height;
  final double size;
  final bool isInBtn;

  @override
  Widget build(BuildContext context) {
    final size = isInBtn ? 20.0 : this.size;
    final color =
        isInBtn ? context.cs.secondary : this.color ?? context.cs.primary;
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: SpinKitFadingCircle(size: size, color: color),
    );
  }
}
