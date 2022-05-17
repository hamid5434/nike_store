import 'package:flutter/material.dart';
import 'package:nike_store/models/baner/Baner.dart';
import 'package:nike_store/widgets/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final List<BannerEntity> banners;
  final controller = PageController(viewportFraction: 1, keepPage: false);

  BannerSlider({Key? key, required this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: banners.length,
            controller: controller,
            itemBuilder: (context, index) {
              return _Slide(
                banner: banners[index],
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: banners.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                    spacing: 4,
                    radius: 4.0,
                    dotWidth: 18,
                    dotHeight: 4,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey.shade400,
                    activeDotColor: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final BannerEntity banner;

  const _Slide({Key? key, required this.banner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ImageLoadingService(
        url: banner.image!,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
