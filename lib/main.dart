import "package:atera_website/src/home.dart";
import "package:atera_website/src/theme/theme.dart";
import "package:atera_website/src/widgets/error_builder.dart";
import "package:flutter/material.dart";

void main() {
  ErrorWidget.builder = errorBuilder;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Atera",
      theme: mainTheme(),
      home: const HomePage(),
    );
  }
}
