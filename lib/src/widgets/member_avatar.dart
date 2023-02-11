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
    this.avatarSizeFactor = 12,
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
  double _scale = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResponsiveText(widget.name, sizeFactor: widget.textSizeFactor),
        const Responsive(child: SizedBox(height: 20)),
        MouseRegion(
          onEnter: (event) => setState(() => _scale = 1.075),
          onExit: (event) => setState(() => _scale = 1),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn,
            scale: _scale,
            child: CircleAvatar(
              radius: dimensionFromSizeFactor(context, widget.avatarSizeFactor),
              backgroundImage: Image.asset(widget.imageUrl).image,
            ),
          ),
        ),
        const Responsive(child: SizedBox(height: 12)),
        Opacity(
          opacity: 0.6,
          child: widget.photoInfo != ""
              ? Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: dimensionFromSizeFactor(context, widget.textSizeFactor / 4),
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      size: dimensionFromSizeFactor(context, widget.textSizeFactor / 2),
                    ),
                    ResponsiveText(widget.photoInfo, sizeFactor: widget.textSizeFactor / 2),
                  ],
                )
              : null,
        ),
      ],
    );
  }
}
