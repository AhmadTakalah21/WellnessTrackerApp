import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/widgets/image_place_holder_widget.dart';

class AppImageWidget extends StatelessWidget {
  const AppImageWidget({
    super.key,
    required this.url,
    this.borderRadius = BorderRadius.zero,
    this.fit,
    this.width,
    this.height,
    this.border,
    this.shadows,
    this.errorWidget,
    this.onImageLoaded,
  });

  final String url;
  final BorderRadiusGeometry borderRadius;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Border? border;
  final List<BoxShadow>? shadows;
  final Widget? errorWidget;
  final void Function(ImageProvider)? onImageLoaded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
        boxShadow: [...?shadows],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          imageBuilder: (context, imageProvider) {
            if (onImageLoaded != null) {
              onImageLoaded!(imageProvider);
            }
            return Image(image: imageProvider, fit: fit);
          },
          imageUrl: url,
          fit: fit,
          errorWidget: (context, url, error) {
            return errorWidget ??
                Center(
                  child: Text(
                    "No image",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width != null ? width! / 4 : 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
          },
          placeholder: (context, url) => const ImagePlaceHolderWidget(),
        ),
      ),
    );
  }
}
