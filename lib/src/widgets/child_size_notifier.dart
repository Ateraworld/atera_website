import "package:flutter/material.dart";

class ChildSizeNotifier extends StatefulWidget {
  const ChildSizeNotifier({
    super.key,
    required this.builder,
    this.child,
    this.notifyMaxSize = false,
  });
  final bool notifyMaxSize;
  final Widget Function(BuildContext context, Size size, Widget? child) builder;
  final Widget? child;

  @override
  State<ChildSizeNotifier> createState() => _ChildSizeNotifierState();
}

class _ChildSizeNotifierState extends State<ChildSizeNotifier> {
  final ValueNotifier<Size> notifier = ValueNotifier(Size.zero);
  double _maxHeight = 0;
  double _maxWidth = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        var rBox = context.findRenderObject();
        if (rBox != null) {
          try {
            var current = (rBox as RenderBox).size;
            Size size;
            if (widget.notifyMaxSize) {
              size = Size(current.width > _maxWidth ? current.width : _maxWidth, current.height > _maxHeight ? current.height : _maxHeight);
              _maxHeight = size.height;
              _maxWidth = size.width;
            } else {
              size = current;
            }
            notifier.value = size;
          } catch (_) {}
        } else {
          debugPrint("renderbox is null");
        }
      },
    );
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: widget.builder,
      child: widget.child,
    );
  }
}
