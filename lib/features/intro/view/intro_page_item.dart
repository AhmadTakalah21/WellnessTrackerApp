import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class IntroPageItem extends StatelessWidget {
  const IntroPageItem({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: AppConstants.borderRadius10,
              child: Image.asset(image),
            ),
          ),
        ),
        Expanded(child: const SizedBox()),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.tt.headlineSmall,
              ),
              SizedBox(height: 30),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: context.tt.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
