import "package:atera_website/src/common/layout.dart";
import "package:atera_website/src/widgets/responsive.dart";
import "package:atera_website/src/widgets/responsive_text.dart";
import "package:flutter/material.dart";

class MemberAvatar extends StatefulWidget {
  const MemberAvatar({
    super.key,
    required this.name,
    required this.imageUrl,
    this.textSizeFactor = 4,
    this.avatarSizeFactor = 16,
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
          onEnter: (event) => setState(() => _scale = 1.05),
          onExit: (event) => setState(() => _scale = 1),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn,
            scale: _scale,
            child: ClipOval(
              child: Responsive(
                sizeFactor: dimensionFromSizeFactor(context, widget.avatarSizeFactor, min: 55, max: 150),
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
