import 'package:flutter/material.dart';

class TileSlideAnimation extends StatefulWidget {
  const TileSlideAnimation({
    super.key,
    required this.index,
    required this.child,
    this.deley = 200,
    this.animationDuration = const Duration(milliseconds: 600),
    this.beginOffset = const Offset(0.3, 0),
  });

  final int index;
  final Widget child;
  final int deley;
  final Duration animationDuration;
  final Offset beginOffset;

  @override
  State<TileSlideAnimation> createState() => _TileSlideAnimationState();
}

class _TileSlideAnimationState extends State<TileSlideAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: widget.animationDuration,
  );
  late final Animation<double> _fade =
      CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);
  late final Animation<Offset> _slide = Tween<Offset>(
    begin: widget.beginOffset,
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _c, curve: Curves.easeOutCubic));

  void _startAnimation() {
    Future.delayed(Duration(milliseconds: widget.deley * widget.index), () {
      if (mounted) _c.forward();
    });
  }

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
