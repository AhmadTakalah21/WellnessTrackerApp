import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/features/intro/view/into_view.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

class IntroPageItem extends StatefulWidget {
  const IntroPageItem({super.key, required this.item});

  final IntroPageModel item;

  @override
  State<IntroPageItem> createState() => _IntroPageItemState();
}

class _IntroPageItemState extends State<IntroPageItem> {
  int currentPosterIndex = 0;
  void onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() => currentPosterIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: ClipRRect(
        //     borderRadius: AppConstants.borderRadius10,
        //     child: Image.asset(widget.item.image),
        //   ),
        // ),
        ClipRRect(
          borderRadius: AppConstants.borderRadius10,
          child: CarouselSlider(
            items: widget.item.images
                .map((image) => Padding(
                  padding: AppConstants.paddingH4,
                  child: ClipRRect(
                      borderRadius: AppConstants.borderRadius10,
                      child: Image.asset(image)),
                ))
                .toList(),
            options: CarouselOptions(
              height : 300,
              autoPlayAnimationDuration: Duration(milliseconds: 400),
              autoPlay: true,
              autoPlayCurve: Curves.easeInOut,
              initialPage: currentPosterIndex,
              onPageChanged: onPageChanged,
            ),
          ),
        ),
        Spacer(),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.item.title,
                textAlign: TextAlign.center,
                style: context.tt.headlineSmall,
              ),
              SizedBox(height: 30),
              Text(
                widget.item.subTitle,
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
