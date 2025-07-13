import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';

class AnotherWaySignInButton extends StatelessWidget {
  const AnotherWaySignInButton({
    super.key,
    required this.image,
    required this.text,
    this.onPressed,
  });

  final String image, text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Image.asset(image, scale: 1.5),
              Spacer(),
              Text(
                text,
                style: context.tt.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
