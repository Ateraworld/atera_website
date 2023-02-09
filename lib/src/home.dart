import "package:atera_website/src/icons/atera_icons.dart";
import "package:flutter/material.dart";
import "package:responsive_builder/responsive_builder.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollTransformView(
        children: [
          ScrollTransformItem(builder: (context) {
            return Image.asset("assets/images/banner.png");
          }),
        ],
      ),
    );
  }
}
