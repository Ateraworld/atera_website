import "package:flutter/material.dart";

class ChildSizeNotifier extends StatelessWidget {
  ChildSizeNotifier({
    super.key,
    required this.builder,
    this.child,
  });
  final ValueNotifier<Size> notifier = ValueNotifier(Size.zero);
  final Widget Function(BuildContext context, Size size, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        var rBox = context.findRenderObject();
        if (rBox != null) {
          notifier.value = (rBox as RenderBox).size;
        }
      },
    );
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: builder,
      child: child,
    );
  }
}
