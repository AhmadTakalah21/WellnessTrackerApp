import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/widgets/detailstext1.dart';

class AnotherWaySignInButton extends StatelessWidget {
  const AnotherWaySignInButton({
    super.key,
    required this.image,
    required this.text,
    this.onPressed, // أضف هذا
  });

  final String image, text;
  final VoidCallback? onPressed; // أضف هذا

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed, // استخدمه هنا
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
              Text1(text1: text, size: 16),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
