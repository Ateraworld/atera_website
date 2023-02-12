import "package:atera_website/src/common/layout.dart";
import "package:atera_website/src/widgets/child_size_notifier.dart";
import "package:collection/collection.dart";
import "package:flutter/material.dart";

class SectionalPage extends StatefulWidget {
  const SectionalPage({
    super.key,
    required this.sections,
    required this.titleHeight,
    required this.scrollController,
    this.leading,
    this.footer,
    this.scrollCurve = Curves.fastOutSlowIn,
    this.scrollDuration,
    this.fabSize = 64,
    this.sectionSeparator,
    this.fabPadding = EdgeInsets.zero,
    this.fabChild,
    this.titleStackAlignWidgets,
    this.titleBackground,
  });
  final Widget? footer;
  final Widget? sectionSeparator;
  final Widget? fabChild;
  final double fabSize;

  final EdgeInsets fabPadding;
  final Duration? scrollDuration;
  final Curve scrollCurve;
  final ScrollController scrollController;
  final Widget? titleBackground;
  final double titleHeight;
  final Widget? leading;
  final List<Section> sections;
  final List<Align>? titleStackAlignWidgets;

  @override
  State<SectionalPage> createState() => _SectionalPageState();
}

class _SectionalPageState extends State<SectionalPage> {
  late final List<Size> _sectionsHeight = List.filled(widget.sections.length, Size.zero);
  double _footerHeight = 0;
  double _getOffset(int index) =>
      _sectionsHeight.take(index).map((e) => e.height).sum + widget.titleHeight + (index >= _sectionsHeight.length - 1 ? _footerHeight : 0);

  Widget _buildMenuBar() {
    return Padding(
      padding: EdgeInsets.all(dimensionFromSizeFactor(context, 6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.leading != null) widget.leading!,
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.sections.length,
                (index) => TextButton(
                  onPressed: () {
                    widget.scrollController.animateTo(
                      _getOffset(index),
                      duration: widget.scrollDuration ?? const Duration(milliseconds: 750),
                      curve: widget.scrollCurve,
                    );
                  },
                  child: widget.sections.elementAt(index).menuBarWidget,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBanner() {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      height: widget.titleHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(alignment: Alignment.topCenter, child: widget.titleBackground),
          Align(alignment: Alignment.topCenter, child: _buildMenuBar()),
          if (widget.titleStackAlignWidgets != null) ...widget.titleStackAlignWidgets!
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: widget.fabPadding,
        child: SizedBox(
          width: widget.fabSize,
          height: widget.fabSize,
          child: FloatingActionButton(
            onPressed: () {
              widget.scrollController.animateTo(
                0,
                duration: widget.scrollDuration ?? const Duration(milliseconds: 1000),
                curve: widget.scrollCurve,
              );
            },
            child: widget.fabChild,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBanner(),
            ...List.generate(
              widget.sections.length,
              (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: dimensionFromSizeFactor(context, 8)),
                  child: ChildSizeNotifier(
                    builder: (context, size, child) {
                      _sectionsHeight[index] = size;
                      if (index < widget.sections.length - 1 && widget.sectionSeparator != null) {
                        return Column(
                          children: [widget.sections.elementAt(index), widget.sectionSeparator!],
                        );
                      } else {
                        return widget.sections.elementAt(index);
                      }
                    },
                  ),
                );
              },
            ),
            if (widget.footer != null)
              ChildSizeNotifier(
                builder: (context, size, child) {
                  _footerHeight = size.height;
                  return child!;
                },
                child: widget.footer,
              ),
          ],
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.child,
    required this.menuBarWidget,
    this.onFocused,
  });
  final VoidCallback? onFocused;
  final Widget menuBarWidget;
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
