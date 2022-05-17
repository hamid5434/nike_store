import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoadingService extends StatelessWidget {
  final String url;
  final BorderRadius? borderRadius;

  const ImageLoadingService(
      {Key? key,required this.url,this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
                  const ColorFilter.mode(Colors.red, BlendMode.colorBurn),
            ),
          ),
        ),
        placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2,)),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
