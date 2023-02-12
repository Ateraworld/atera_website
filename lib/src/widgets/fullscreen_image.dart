import "package:atera_website/src/common/layout.dart";
import "package:atera_website/src/widgets/responsive_text.dart";
import "package:flutter/material.dart";

class FullscreenImage extends StatelessWidget {
  const FullscreenImage({
    super.key,
    required this.imageUrl,
    this.description,
  });
  final String? description;
  final String imageUrl;

  Widget _buidImage(BuildContext context) {
    if (description != null) {
      return Padding(
        padding: EdgeInsets.all(dimensionFromSizeFactor(context, 28)),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: FittedBox(
                fit: BoxFit.contain,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(dimensionFromSizeFactor(context, 32, min: 32, max: 80)),
                  child: Image.asset(imageUrl, fit: BoxFit.contain),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Opacity(
                  opacity: 0.75,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    spacing: dimensionFromSizeFactor(context, 8),
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        size: dimensionFromSizeFactor(context, 12),
                      ),
                      ResponsiveText(
                        description!,
                        textAlign: TextAlign.center,
                        sizeFactor: sizeFactorFromCategory(TextCategory.label),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(dimensionFromSizeFactor(context, 32, min: 32, max: 80)),
      child: Image.asset(imageUrl, fit: BoxFit.contain),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(dimensionFromSizeFactor(context, 6)),
        child: SizedBox(
          width: dimensionFromSizeFactor(context, 12, min: 64, max: 120),
          height: dimensionFromSizeFactor(context, 12, min: 64, max: 120),
          child: FloatingActionButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(Icons.close_rounded),
          ),
        ),
      ),
      body: _buidImage(context),
    );
  }
}
