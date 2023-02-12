import "package:atera_website/src/common/layout.dart";
import "package:atera_website/src/widgets/fade_page_route.dart";
import "package:atera_website/src/widgets/fullscreen_image.dart";
import "package:atera_website/src/widgets/responsive.dart";
import "package:atera_website/src/widgets/responsive_text.dart";
import "package:atera_website/src/widgets/tappable.dart";
import "package:flutter/material.dart";

class MemberAvatar extends StatefulWidget {
  const MemberAvatar({
    super.key,
    required this.name,
    required this.imageUrl,
    this.textSizeFactor = 4,
    this.avatarSizeFactor = 64,
    this.photoInfo = "",
  });
  final double textSizeFactor;

  final double avatarSizeFactor;
  final String imageUrl;
  final String name;

  final String photoInfo;

  @override
  State<MemberAvatar> createState() => _MemberAvatarState();
}

class _MemberAvatarState extends State<MemberAvatar> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  double _scale = 1;
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(widget.imageUrl), context);
    return Column(
      children: [
        ResponsiveText(widget.name, sizeFactor: sizeFactorFromCategory(TextCategory.header)),
        const Responsive(sizeFactor: 6),
        MouseRegion(
          onEnter: (event) => setState(() => _scale = 1.075),
          onExit: (event) => setState(() => _scale = 1),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn,
            scale: _scale,
            child: Tappable(
              heroTag: widget.imageUrl,
              borderRadius: BorderRadius.circular(150),
              size: Size(
                dimensionFromSizeFactor(context, widget.avatarSizeFactor, min: 50, max: 240),
                dimensionFromSizeFactor(context, widget.avatarSizeFactor, min: 50, max: 240),
              ),
              onTap: () {
                Navigator.of(context).push(
                  FadePageRoute(
                    FullscreenImage(
                      description: widget.photoInfo,
                      imageUrl: widget.imageUrl,
                      // heroTag: widget.imageUrl,
                    ),
                  ),
                );
              },
              child: ClipOval(
                child: Image.asset(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const Responsive(sizeFactor: 4),
        Opacity(
          opacity: 0.6,
          child: widget.photoInfo != ""
              ? Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: dimensionFromSizeFactor(context, widget.textSizeFactor / 4),
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      size: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.caption)),
                    ),
                    ResponsiveText(widget.photoInfo, sizeFactor: sizeFactorFromCategory(TextCategory.caption)),
                  ],
                )
              : null,
        ),
      ],
    );
  }
}
