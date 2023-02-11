import "package:atera_website/src/common/layout.dart";
import "package:atera_website/src/icons/atera_icons.dart";
import "package:atera_website/src/widgets/info_carousel.dart";
import "package:atera_website/src/widgets/member_avatar.dart";
import "package:atera_website/src/widgets/responsive.dart";
import "package:atera_website/src/widgets/responsive_text.dart";
import "package:atera_website/src/widgets/sectional_page.dart";
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum TextCategory { title, header, body, label, caption }

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  late double _titleHeight = 0;
  double _sizeFactorFromCategory(TextCategory category) {
    switch (category) {
      case TextCategory.title:
        return 14;
      case TextCategory.header:
        return 8;
      case TextCategory.body:
        return 5;
      case TextCategory.label:
        return 4;
      case TextCategory.caption:
        return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _titleHeight = dimensionFromSizeFactor(context, 120);
    return SectionalPage(
      fabChild: const Icon(Icons.keyboard_arrow_up_rounded),
      fabSize: dimensionFromSizeFactor(context, 12, min: 64, max: 120),
      sectionSeparator: Divider(height: dimensionFromSizeFactor(context, 16), indent: 32, endIndent: 32),
      fabPadding: EdgeInsets.all(dimensionFromSizeFactor(context, 6)),
      scrollController: _scrollController,
      titleStackAlignWidgets: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResponsiveText(
                "ATERA",
                sizeFactor: _sizeFactorFromCategory(TextCategory.title),
                style: const TextStyle(fontFamily: "Montserrat"),
              ),
              const Responsive(
                sizeFactor: 5,
                child: SizedBox(height: 128),
              ),
              ResponsiveText(
                "Scopri nuove avventure",
                sizeFactor: _sizeFactorFromCategory(TextCategory.body),
                style: const TextStyle(fontFamily: "Montserrat"),
              ),
              const Responsive(
                sizeFactor: 2,
                child: SizedBox(height: 64),
              ),
              ResponsiveText(
                "Poniti degli obiettivi",
                sizeFactor: _sizeFactorFromCategory(TextCategory.body),
                style: const TextStyle(fontFamily: "Montserrat"),
              ),
              const Responsive(
                sizeFactor: 2,
                child: SizedBox(height: 64),
              ),
              ResponsiveText(
                "Ottieni sconti e benefici grazie alle tue passioni",
                sizeFactor: _sizeFactorFromCategory(TextCategory.body),
                style: const TextStyle(fontFamily: "Montserrat"),
              ),
            ],
          ),
        )
      ],
      titleHeight: _titleHeight,
      titleBackground: ShaderMask(
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
        child: SizedBox(
          width: screenSize.width,
          height: _titleHeight,
          child: Image.asset(
            "assets/images/brenta_long.webp",
            fit: BoxFit.cover,
          ),
        ),
      ),
      leading: Icon(
        AteraIcons.logo,
        size: dimensionFromSizeFactor(context, 20),
      ),
      sections: [
        Section(
          menuBarWidget: ResponsiveText(
            "Idea",
            sizeFactor: _sizeFactorFromCategory(TextCategory.body),
            max: 36,
            min: 20,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          child: _buildIdeaSection(),
        ),
        Section(
          menuBarWidget: ResponsiveText(
            "Progetto",
            sizeFactor: _sizeFactorFromCategory(TextCategory.body),
            max: 36,
            min: 20,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          child: _buildProjectSection(),
        ),
        Section(
          menuBarWidget: ResponsiveText(
            "Roadmap",
            sizeFactor: _sizeFactorFromCategory(TextCategory.body),
            max: 36,
            min: 20,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          child: _buildRoadmap(),
        ),
        Section(
          menuBarWidget: ResponsiveText(
            "Team",
            sizeFactor: _sizeFactorFromCategory(TextCategory.body),
            max: 36,
            min: 20,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          child: _buildTeamSection(),
        )
      ],
    );
  }

  Widget _buildProjectSection() {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).colorScheme.background,
      width: screenSize.width,
      child: Padding(
        padding: EdgeInsets.all(dimensionFromSizeFactor(context, 1) * 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ResponsiveText(
              "Il nostro progetto",
              sizeFactor: _sizeFactorFromCategory(TextCategory.header),
              style: TextStyle(
                fontFamily: "Montserrat",
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.w800,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIdeaSection() {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).colorScheme.background,
      width: screenSize.width,
      child: Padding(
        padding: EdgeInsets.all(dimensionFromSizeFactor(context, 10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ResponsiveText(
              "La nostra idea",
              sizeFactor: _sizeFactorFromCategory(TextCategory.header),
              style: const TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w800),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: dimensionFromSizeFactor(context, 4)),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Atera",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: dimensionFromSizeFactor(context, _sizeFactorFromCategory(TextCategory.label)),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    TextSpan(
                      text:
                          " nasce dall'unione dei due mondi che ci appassionano: la natura e l'informatica.\nAbbiamo ideato un'applicazione che potesse portare dei benefici a tutti coloro che fanno parte del mondo delle attività outdoor.\n",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: dimensionFromSizeFactor(context, _sizeFactorFromCategory(TextCategory.label))),
                    ),
                  ],
                ),
              ),
            ),
            InfoCarousel(
              descriptionSizeFactor: _sizeFactorFromCategory(TextCategory.label),
              titleSizeFactor: _sizeFactorFromCategory(TextCategory.body),
              title: ResponsiveText(
                "Per gli utenti",
                sizeFactor: _sizeFactorFromCategory(TextCategory.header),
                textAlign: TextAlign.center,
              ),
              info: [
                Info(
                  "assets/images/discover.png",
                  "Scopri nuove avventure",
                  "Trova la tua prossima avventura grazie a sistemi di ricerca basati su categorie e valutazioni",
                ),
                Info(
                  "assets/images/achievement.png",
                  "Poniti degli obiettivi",
                  "Con il sistema di attestazione di Atera, mantieni i record di tutte le attività completate: sali di livello e scala le classifiche",
                ),
                Info(
                  "assets/images/secure_info.png",
                  "Informazioni concise, sicure, utili",
                  "Su Atera trovi solo le informazioni necessarie per effettuare le tue attività preferite",
                ),
                Info(
                  "assets/images/coupons.png",
                  "Ottieni benefici grazie alle tue passioni",
                  "Riscatta buoni sconto e benefici semplicemente facendo quello che ami",
                ),
              ],
            ),
            const Divider(height: 40, thickness: 1, endIndent: 64, indent: 64),
            InfoCarousel(
              descriptionSizeFactor: _sizeFactorFromCategory(TextCategory.label),
              titleSizeFactor: _sizeFactorFromCategory(TextCategory.body),
              title: ResponsiveText(
                "Per i brand",
                sizeFactor: _sizeFactorFromCategory(TextCategory.header),
                textAlign: TextAlign.center,
              ),
              mirrored: true,
              info: [
                Info(
                  "assets/images/app_page.png",
                  "Una pagina dedicata",
                  "Atera permette la creazione di pagine dedicate all'interno dell'applicazione, incrementando la visibilità degli esercizi commerciali",
                ),
                Info(
                  "assets/images/target.png",
                  "Pubblico estremamente mirato",
                  "Proprio grazie alla sua struttura e idea, Atera raggruppa una community genuinamente interessata al mondo delle attività outdoor",
                ),
                Info(
                  "assets/images/revenue.png",
                  "Incrementa la tua customer base",
                  "Fornendo sconti e benefici agli utenti di Atera, incrementi la visibilità dell'esercizio commerciale e attrai una clientela interessata ai tuoi prodotti",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTeamSection() {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).colorScheme.background,
      width: screenSize.width,
      child: Padding(
        padding: EdgeInsets.all(dimensionFromSizeFactor(context, 10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ResponsiveText(
              sizeFactor: _sizeFactorFromCategory(TextCategory.header),
              "Chi siamo",
              style: const TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w800),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: dimensionFromSizeFactor(context, 4),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Siamo studenti di informatica, ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: dimensionFromSizeFactor(context, _sizeFactorFromCategory(TextCategory.label))),
                    ),
                    TextSpan(
                      text: "Matteo",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: dimensionFromSizeFactor(context, _sizeFactorFromCategory(TextCategory.label)),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    TextSpan(
                      text: " ed ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: dimensionFromSizeFactor(context, _sizeFactorFromCategory(TextCategory.label))),
                    ),
                    TextSpan(
                      text: "Enrico",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: dimensionFromSizeFactor(context, _sizeFactorFromCategory(TextCategory.label)),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    TextSpan(
                      text: " all'Università di Trento, ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: dimensionFromSizeFactor(context, _sizeFactorFromCategory(TextCategory.label))),
                    ),
                    TextSpan(
                      text: "Thomas",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: dimensionFromSizeFactor(context, _sizeFactorFromCategory(TextCategory.label)),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    TextSpan(
                      text: " all'Università di Udine.\n",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: dimensionFromSizeFactor(context, _sizeFactorFromCategory(TextCategory.label))),
                    ),
                    TextSpan(
                      text:
                          "Da sempre appassionati di attività outdoor, montagna e tutto ciò che riguarda la natura in generale, abbiamo deciso di creare un qualcosa che possa veramente apportare dei benefici alla comunità di questo mondo e allo stesso tempo che potesse divertirci.\n",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: dimensionFromSizeFactor(context, _sizeFactorFromCategory(TextCategory.label))),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: dimensionFromSizeFactor(context, 1) * 4,
                horizontal: dimensionFromSizeFactor(context, 1) * 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MemberAvatar(
                    avatarSizeFactor: 16,
                    textSizeFactor: _sizeFactorFromCategory(TextCategory.body),
                    name: "Matteo",
                    imageUrl: "assets/images/trat.webp",
                    photoInfo: "Ferrata O. Marangoni, Mori",
                  ),
                  MemberAvatar(
                    avatarSizeFactor: 16,
                    textSizeFactor: _sizeFactorFromCategory(TextCategory.body),
                    name: "Enrico",
                    imageUrl: "assets/images/eri.webp",
                    photoInfo: "Ferrata Hoachwool, Naturno",
                  ),
                  MemberAvatar(
                    avatarSizeFactor: 16,
                    textSizeFactor: _sizeFactorFromCategory(TextCategory.body),
                    name: "Thomas",
                    imageUrl: "assets/images/brenta.webp",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 128),
          ],
        ),
      ),
    );
  }

  Widget _buildRoadmap() {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).colorScheme.background,
      width: screenSize.width,
      child: Padding(
        padding: EdgeInsets.all(dimensionFromSizeFactor(context, 10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveText(
              sizeFactor: _sizeFactorFromCategory(TextCategory.header),
              "Il nostro piano",
              style: const TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w800),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: dimensionFromSizeFactor(context, 4),
              ),
              child: null,
            ),
            const SizedBox(height: 256),
          ],
        ),
      ),
    );
  }
}
