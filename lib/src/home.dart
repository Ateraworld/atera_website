import "dart:async";
import "dart:ui" as ui;
import "package:atera_website/src/icons/atera_icons.dart";
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  Completer<ui.Image> _completer = Completer();
  ui.Image? _banner;
  static const double _sectionHeight = 800;
  double _whoSectionOffset = 0;
  double _whatSectionOffset = 0;
  double _whySectionOffset = 0;

  @override
  void initState() {
    super.initState();
    Image image = Image.asset("assets/images/brenta_long.webp");
    _completer = Completer<ui.Image>();
    image.image.resolve(ImageConfiguration.empty).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        _banner = info.image;
        _completer.complete(info.image);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(64),
        child: FloatingActionButton(
          onPressed: () {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            );
          },
          child: const Icon(Icons.keyboard_arrow_up_rounded),
        ),
      ),
      body: FutureBuilder(
        future: _completer.future,
        builder: (context, snapshot) {
          var screenSize = MediaQuery.of(context).size;
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            _whoSectionOffset = screenSize.width * _banner!.height.toDouble() / _banner!.width.toDouble();
            _whatSectionOffset = _whoSectionOffset + _sectionHeight;
            _whySectionOffset = _whatSectionOffset + _sectionHeight;
            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: snapshot.data!.width.toDouble(),
                    height: screenSize.width * _banner!.height.toDouble() / _banner!.width.toDouble(),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: ShaderMask(
                            blendMode: BlendMode.dstATop,
                            shaderCallback: (rect) {
                              return LinearGradient(
                                end: Alignment.topCenter,
                                begin: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Theme.of(context).colorScheme.background,
                                ],
                              ).createShader(rect);
                            },
                            child: ClipRRect(
                              borderRadius: screenSize.width <= _banner!.width.toDouble() ? BorderRadius.zero : BorderRadius.circular(32),
                              child: Image.asset(
                                "assets/images/brenta_long.webp",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                screenSize.width <= _banner!.width.toDouble() ? 0 : (screenSize.width - _banner!.width.toDouble()) / 2,
                          ),
                          child: _buildMenuBar(),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ATERA",
                                style: TextStyle(fontFamily: "Montserrat", fontSize: screenSize.width / 20),
                              ),
                              SizedBox(height: screenSize.width / 16),
                              Text(
                                "Scopri nuove avventure",
                                style: TextStyle(fontFamily: "Montserrat", fontSize: screenSize.width / 80),
                              ),
                              SizedBox(height: screenSize.width / 64),
                              Text(
                                "Poniti degli obiettivi",
                                style: TextStyle(fontFamily: "Montserrat", fontSize: screenSize.width / 80),
                              ),
                              SizedBox(height: screenSize.width / 64),
                              Text(
                                "Ottieni sconti e benefici grazie alle tue passioni",
                                style: TextStyle(fontFamily: "Montserrat", fontSize: screenSize.width / 80),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).colorScheme.background,
                    height: _sectionHeight,
                    width: screenSize.width,
                    child: Padding(
                      padding: const EdgeInsets.all(64),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Chi",
                            style: TextStyle(fontFamily: "Montserrat", fontSize: 32, fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).colorScheme.onBackground,
                    height: _sectionHeight,
                    width: screenSize.width,
                    child: Padding(
                      padding: const EdgeInsets.all(64),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Cosa",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 32,
                              color: Theme.of(context).colorScheme.background,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).colorScheme.background,
                    height: _sectionHeight,
                    width: screenSize.width,
                    child: Padding(
                      padding: const EdgeInsets.all(64),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Perchè",
                            style: TextStyle(fontFamily: "Montserrat", fontSize: 32, fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildMenuBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            AteraIcons.logo,
            size: 100,
          ),
          Wrap(
            children: [
              TextButton(
                onPressed: () {
                  _scrollController.animateTo(
                    _whoSectionOffset,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                child: Text(
                  "Chi siamo",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextButton(
                onPressed: () {
                  _scrollController.animateTo(
                    _whatSectionOffset,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                child: Text(
                  "Cosa facciamo",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextButton(
                onPressed: () {
                  _scrollController.animateTo(
                    _whySectionOffset,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                child: Text(
                  "Perche lo facciamo",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
