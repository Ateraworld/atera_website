import "package:atera_website/src/common/layout.dart";
import "package:atera_website/src/widgets/responsive.dart";
import "package:atera_website/src/widgets/responsive_text.dart";
import "package:flutter/material.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";

class Roadmap extends StatefulWidget {
  const Roadmap({
    super.key,
    required this.steps,
    this.autoPlay = true,
    this.minHeight,
  });
  final double? minHeight;
  final bool autoPlay;
  final List<RoadmapStep> steps;

  @override
  State<Roadmap> createState() => _RoadmapState();
}

class _RoadmapState extends State<Roadmap> {
  int _currentStep = 0;
  bool _canPlay = true;
  @override
  void initState() {
    _roadmapIndexChange();
    super.initState();
  }

  void _roadmapIndexChange() {
    if (!mounted) return;
    if (widget.autoPlay) {
      Future.delayed(const Duration(milliseconds: 4000), () {
        if (_canPlay) {
          if (_currentStep == widget.steps.length - 1) {
            setState(() => _currentStep = 0);
          } else {
            setState(() => _currentStep += 1);
          }
        }
        _roadmapIndexChange();
      });
    }
  }

  IconData _iconByState(RoadmapStepState state) {
    switch (state) {
      case RoadmapStepState.completed:
        return Icons.check_rounded;
      case RoadmapStepState.doing:
        return Icons.access_time_rounded;
      case RoadmapStepState.planned:
        return Icons.today_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var current = widget.steps.elementAt(_currentStep);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: widget.minHeight ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Wrap(
              spacing: (screenSize.width) / (widget.steps.length * 1.75),
              children: List.generate(
                widget.steps.length,
                (index) => Icon(
                  _iconByState(widget.steps.elementAt(index).state),
                  size: dimensionFromSizeFactor(context, 10),
                ),
              ),
            ),
          ),
          const Responsive(sizeFactor: 2),
          Center(
            child: AnimatedSmoothIndicator(
              onDotClicked: (index) {
                setState(() {
                  _canPlay = false;
                  _currentStep = index;
                });
                Future.delayed(const Duration(seconds: 8), () {
                  if (!mounted) return;
                  setState(() => _canPlay = true);
                });
              },
              activeIndex: _currentStep,
              count: widget.steps.length,
              effect: WormEffect(
                spacing: (screenSize.width) / (widget.steps.length * 1.75),
                dotColor: Theme.of(context).colorScheme.surface,
                activeDotColor: Theme.of(context).colorScheme.secondary,
                radius: 128,
                dotHeight: dimensionFromSizeFactor(context, 10),
                dotWidth: dimensionFromSizeFactor(context, 10),
              ),
            ),
          ),
          const Responsive(sizeFactor: 10),
          ResponsiveText(
            current.title,
            sizeFactor: sizeFactorFromCategory(TextCategory.header),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w800),
          ),
          const Responsive(sizeFactor: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dimensionFromSizeFactor(context, 16)),
            child: ResponsiveText(
              current.description,
              sizeFactor: sizeFactorFromCategory(TextCategory.label),
              textAlign: TextAlign.justify,
            ),
          ),
          if (current.substeps != null)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: dimensionFromSizeFactor(context, 16), vertical: dimensionFromSizeFactor(context, 8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(current.substeps!.length, (index) {
                  var subStep = current.substeps!.elementAt(index);
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: dimensionFromSizeFactor(context, 4)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: dimensionFromSizeFactor(context, 4),
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                              _iconByState(subStep.state),
                              size: dimensionFromSizeFactor(context, 6),
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            ResponsiveText(
                              subStep.title,
                              sizeFactor: sizeFactorFromCategory(TextCategory.body),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: dimensionFromSizeFactor(context, 10)),
                          child: ResponsiveText(
                            subStep.description,
                            sizeFactor: sizeFactorFromCategory(TextCategory.label),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          if (current.imageUrl != null) Image.asset(current.imageUrl!)
        ],
      ),
    );
  }
}

enum RoadmapStepState { completed, doing, planned }

class RoadmapStep {
  RoadmapStep(
    this.title,
    this.description, {
    this.substeps,
    this.imageUrl,
    this.state = RoadmapStepState.planned,
  });
  final RoadmapStepState state;
  final List<RoadmapStep>? substeps;
  final String title;
  final String description;
  final String? imageUrl;
}
