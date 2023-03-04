import "package:flutter/gestures.dart";
import "package:flutter/material.dart";

class TokenizedText extends StatefulWidget {
  const TokenizedText({
    super.key,
    required this.rawString,
    this.onTokenTap,
    this.textAlign = TextAlign.start,
    this.styleBuilder,
    this.sanitizeUnicode = false,
    this.defaultStyle,
  });
  final bool sanitizeUnicode;
  final TextStyle? Function(String type, String payload)? styleBuilder;
  final TextAlign textAlign;
  final TextStyle? defaultStyle;
  final Function(String text, String type, String payload)? onTokenTap;
  final String rawString;

  @override
  State<TokenizedText> createState() => _TokenizedTextState();
}

class _TokenizedTextState extends State<TokenizedText> {
  var tokensRegex = RegExp(
    r"\$\{\[(?<text>.+?(?=]))\](?<type>[a-zA-z]+)\((?<payload>.*?(?=\)))\)\}",
  );
  String content = "";
  final List<Object> _tokens = List.empty(growable: true);
  String _sanitize(String s) {
    return s.replaceAllMapped(
      RegExp(r"\\u([0-9a-fA-F]{4})"),
      (Match m) => String.fromCharCode(int.parse(m.group(1)!, radix: 16)),
    );
  }

  @override
  void initState() {
    super.initState();
    content = widget.sanitizeUnicode ? _sanitize(widget.rawString) : widget.rawString;
    _tokens.clear();
    _tokens.addAll(_tokenizeRawString());
  }

  List<Object> _tokenizeRawString() {
    var res = List<Object>.empty(growable: true);
    var input = content;
    var match = tokensRegex.firstMatch(input);
    if (match == null) {
      return List.filled(1, content);
    }
    var suffix = "";
    while (match != null) {
      var prefix = input.substring(0, match.start);
      suffix = input.substring(match.end, input.length);
      res.add(prefix);
      res.add(match);
      input = suffix;
      match = tokensRegex.firstMatch(input);
    }
    if (suffix.isNotEmpty) {
      res.add(suffix);
    }
    return res;
  }

  TextStyle? _buildSpanStyle(String? type, String? payload) {
    if (type != null && payload != null && widget.styleBuilder != null) {
      try {
        var res = widget.styleBuilder!.call(type, payload);
        if (res != null) return res;
      } catch (_) {}
    }
    var style = widget.defaultStyle ?? Theme.of(context).textTheme.bodyMedium;
    if (type == "ph" || type == "lk") {
      return style?.copyWith(color: Theme.of(context).colorScheme.secondary);
    } else if (type == "act") {
      return style?.copyWith(color: Theme.of(context).colorScheme.secondary, decoration: TextDecoration.underline);
    } else if (type == "b") {
      return style?.copyWith(fontWeight: FontWeight.w800);
    }
    if (type == "i") {
      return style?.copyWith(fontStyle: FontStyle.italic);
    }
    return style;
  }

  List<TextSpan> _buildTokensWidgets() {
    return List.generate(_tokens.length, (index) {
      var current = _tokens.elementAt(index);
      if (current is String) {
        return TextSpan(text: current, style: _buildSpanStyle(null, null));
      } else if (current is RegExpMatch) {
        var text = current.namedGroup("text")!;
        var type = current.namedGroup("type")!;
        var payload = current.namedGroup("payload")!;
        return TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              widget.onTokenTap?.call(text, type, payload);
            },
          text: text,
          style: _buildSpanStyle(type, payload),
        );
      }
      return const TextSpan(text: "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: _buildTokensWidgets()),
      textAlign: widget.textAlign,
    );
  }
}
