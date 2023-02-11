import "dart:async";
import "dart:math";

import "package:atera_website/src/common/layout.dart";
import "package:atera_website/src/widgets/responsive_text.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";

class InfoCarousel extends StatefulWidget {
  const InfoCarousel({
    super.key,
    required this.info,
    this.title,
    this.mirrored = false,
    this.titleSizeFactor = 6,
    this.descriptionSizeFactor = 4,
  });
  final Widget? title;
  final double titleSizeFactor;
  final double descriptionSizeFactor;
  final bool mirrored;
  final List<Info> info;

  @override
  State<InfoCarousel> createState() => _InfoCarouselState();
}

class _InfoCarouselState extends State<InfoCarousel> {
  final CarouselController _controller = CarouselController();
  int _index = 0;
  double _opacity = 1;
  @override
  void initState() {
    super.initState();
    //_animateNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = [
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _index <= 0
                  ? null
                  : () {
                      setState(() => _opacity = 0);
                      _controller
                          .previousPage(duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn)
                          .then((value) => setState(() => _opacity = 1));
                    },
              child: Icon(
                Icons.arrow_left_rounded,
                size: dimensionFromSizeFactor(context, 16),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensionFromSizeFactor(context, 4)),
                child: ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (rect) {
                    return LinearGradient(
                      tileMode: TileMode.clamp,
                      stops: const [0, 0.075, 0.5, 0.925, 1],
                      colors: [
                        Theme.of(context).colorScheme.background,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.transparent,
                        Theme.of(context).colorScheme.background,
                      ],
                    ).createShader(rect);
                  },
                  child: Column(
                    children: [
                      if (widget.title != null) widget.title!,
                      CarouselSlider.builder(
                        carouselController: _controller,
                        itemCount: widget.info.length,
                        itemBuilder: (context, index, page) {
                          return Image.asset(
                            widget.info.elementAt(index).imageAssetUrl,
                            fit: BoxFit.contain,
                          );
                        },
                        options: CarouselOptions(
                          height: dimensionFromSizeFactor(context, 46, max: 320),
                          viewportFraction: 1,
                          padEnds: true,
                          onPageChanged: _onPageChanged,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 10),
                          pauseAutoPlayOnManualNavigate: true,
                          pauseAutoPlayOnTouch: true,
                          enableInfiniteScroll: false,
                          pageSnapping: true,
                        ),
                      ),
                      AnimatedSmoothIndicator(
                        activeIndex: _index,
                        curve: Curves.fastOutSlowIn,
                        effect: WormEffect(
                          activeDotColor: Theme.of(context).colorScheme.secondary,
                          dotHeight: dimensionFromSizeFactor(context, widget.descriptionSizeFactor / 2),
                          dotWidth: dimensionFromSizeFactor(context, widget.descriptionSizeFactor / 2),
                          spacing: dimensionFromSizeFactor(context, widget.descriptionSizeFactor),
                        ),
                        count: widget.info.length,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: _index >= widget.info.length - 1
                  ? null
                  : () {
                      setState(() => _opacity = 0);
                      _controller
                          .nextPage(duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn)
                          .then((value) => setState(() => _opacity = 1));
                    },
              child: Icon(
                Icons.arrow_right_rounded,
                size: dimensionFromSizeFactor(context, 16),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              ResponsiveText(
                widget.info.elementAt(_index).title,
                sizeFactor: widget.titleSizeFactor,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                child: ResponsiveText(
                  widget.info.elementAt(_index).description,
                  sizeFactor: widget.descriptionSizeFactor,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dimensionFromSizeFactor(context, 4)),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        children: List.from(widget.mirrored ? widgets.reversed : widgets),
      ),
    );
  }

  void _onPageChanged(int index, CarouselPageChangedReason reason) => setState(() => _index = index);
}

class Info {
  Info(this.imageAssetUrl, this.title, this.description);
  String imageAssetUrl;
  String title;
  String description;
}
