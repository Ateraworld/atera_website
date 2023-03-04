import "package:atera_website/src/common/layout.dart";
import "package:atera_website/src/icons/atera_icons.dart";
import "package:atera_website/src/widgets/info_carousel.dart";
import "package:atera_website/src/widgets/member_avatar.dart";
import "package:atera_website/src/widgets/privacy_policy_page.dart";
import "package:atera_website/src/widgets/responsive.dart";
import "package:atera_website/src/widgets/responsive_text.dart";
import "package:atera_website/src/widgets/roadmap.dart";
import "package:atera_website/src/widgets/scalable_icon_button.dart";
import "package:atera_website/src/widgets/sectional_page.dart";
import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";
import "package:video_player/video_player.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final VideoPlayerController _controller = VideoPlayerController.asset("assets/videos/architecture.mp4");

  final ScrollController _scrollController = ScrollController();
  late double _titleHeight = 0;
  bool _initiated = false;

  Future<void> _init() async {
    await _controller.initialize();
    Future.delayed(const Duration(seconds: 4), () {
      _controller.setLooping(true);
      _controller.setVolume(0);
      _controller.play();
    });
    setState(() => _initiated = true);
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage("assets/images/brenta_long.webp"), context);
    precacheImage(const AssetImage("assets/images/trat.webp"), context);
    precacheImage(const AssetImage("assets/images/eri.webp"), context);
    precacheImage(const AssetImage("assets/images/thom.webp"), context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _titleHeight = dimensionFromSizeFactor(context, 200);
    return _initiated
        ? SectionalPage(
            fabChild: const Icon(Icons.keyboard_arrow_up_rounded),
            fabSize: dimensionFromSizeFactor(context, 12, min: 64, max: 120),
            sectionSeparator: Divider(height: dimensionFromSizeFactor(context, 16), indent: 32, endIndent: 32),
            fabPadding: EdgeInsets.all(dimensionFromSizeFactor(context, 6)),
            scrollController: _scrollController,
            footer: SizedBox(
              child: Padding(
                padding: EdgeInsets.all(dimensionFromSizeFactor(context, 8)),
                child: Column(
                  children: [
                    Divider(
                      height: dimensionFromSizeFactor(context, 16),
                      indent: dimensionFromSizeFactor(context, 16),
                      endIndent: dimensionFromSizeFactor(context, 16),
                    ),
                    const Opacity(
                      opacity: 0.5,
                      child: ResponsiveText(
                        "Icons made by (Pixel perfect, Vitaly Gorbachev, inkubators, Freepik, Those icons, Graphics Plazza) from www.flaticon.com",
                        textAlign: TextAlign.center,
                        sizeFactor: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            titleStackAlignWidgets: [
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(dimensionFromSizeFactor(context, 16)),
                  child: Wrap(
                    spacing: dimensionFromSizeFactor(context, 10),
                    alignment: WrapAlignment.end,
                    children: [
                      ScalableIconButton(
                        onPressed: () async {
                          await launchUrl(Uri.parse("https://instagram.com/atera.world?igshid=ZDdkNTZiNTM="));
                        },
                        icon: AteraIcons.instagram,
                        size: dimensionFromSizeFactor(context, 10),
                      ),
                      ScalableIconButton(
                        onPressed: () async {
                          await launchUrl(Uri.parse("https://github.com/Ateraworld"));
                        },
                        icon: AteraIcons.github,
                        size: dimensionFromSizeFactor(context, 10),
                      ),
                      ScalableIconButton(
                        onPressed: () async {
                          Navigator.of(context).pushNamed("privacy");
                        },
                        icon: Icons.privacy_tip_rounded,
                        size: dimensionFromSizeFactor(context, 10),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ResponsiveText(
                      "ATERA",
                      textAlign: TextAlign.center,
                      sizeFactor: sizeFactorFromCategory(TextCategory.title),
                      style: const TextStyle(fontFamily: "Montserrat"),
                    ),
                    const Responsive(
                      sizeFactor: 5,
                      child: SizedBox(height: 128),
                    ),
                    ResponsiveText(
                      "Scopri nuove avventure",
                      textAlign: TextAlign.center,
                      sizeFactor: sizeFactorFromCategory(TextCategory.body),
                      style: const TextStyle(fontFamily: "Montserrat"),
                    ),
                    const Responsive(
                      sizeFactor: 2,
                      child: SizedBox(height: 64),
                    ),
                    ResponsiveText(
                      "Poniti degli obiettivi",
                      textAlign: TextAlign.center,
                      sizeFactor: sizeFactorFromCategory(TextCategory.body),
                      style: const TextStyle(fontFamily: "Montserrat"),
                    ),
                    const Responsive(
                      sizeFactor: 2,
                      child: SizedBox(height: 64),
                    ),
                    ResponsiveText(
                      "Ottieni sconti e benefici grazie alle tue passioni",
                      textAlign: TextAlign.center,
                      sizeFactor: sizeFactorFromCategory(TextCategory.body),
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
              size: dimensionFromSizeFactor(context, 32),
            ),
            sections: [
              Section(
                menuBarWidget: ResponsiveText(
                  "Idea",
                  sizeFactor: sizeFactorFromCategory(TextCategory.body),
                  max: 36,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                child: _buildIdeaSection(),
              ),
              Section(
                menuBarWidget: ResponsiveText(
                  "Progetto",
                  sizeFactor: sizeFactorFromCategory(TextCategory.body),
                  max: 36,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                child: _buildProjectSection(),
              ),
              Section(
                menuBarWidget: ResponsiveText(
                  "Piano",
                  sizeFactor: sizeFactorFromCategory(TextCategory.body),
                  max: 36,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                child: _buildRoadmap(),
              ),
              Section(
                menuBarWidget: ResponsiveText(
                  "Team",
                  sizeFactor: sizeFactorFromCategory(TextCategory.body),
                  max: 36,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                child: _buildTeamSection(),
              )
            ],
          )
        : Scaffold(backgroundColor: Theme.of(context).colorScheme.background, body: const Center(child: CircularProgressIndicator()));
  }

  Widget _buildProjectSection() {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).colorScheme.background,
      width: screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ResponsiveText(
            "Il nostro progetto",
            textAlign: TextAlign.end,
            sizeFactor: sizeFactorFromCategory(TextCategory.header),
            style: TextStyle(
              fontFamily: "Montserrat",
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: dimensionFromSizeFactor(context, 8)),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        "Essendo tre informatici, abbiamo deciso di sviluppare il progetto interamente con le nostre capacità.\nDalla backend alla frontend e design, ci siamo impegnati con il cuore per creare un prodotto che sia ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label))),
                  ),
                  TextSpan(
                    text: "bello",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label)),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  TextSpan(
                    text: ", ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label))),
                  ),
                  TextSpan(
                    text: "utile",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label)),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  TextSpan(
                    text: ", ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label))),
                  ),
                  TextSpan(
                    text: "intuitivo",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label)),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  TextSpan(
                    text:
                        " e che possa portare beneficio ad entrambe le entità che fanno parte del nostro ecosistema. Atera si basa quindi sull'interazione tra gli utenti interessati al mondo delle attività outdoor e negozi e brand interessati a promuovere i loro prodotti in un ambiente estremamente mirato.\n\nGli enti turistici e le associazioni potranno godere anch'essi dei benefici di Atera. Fornendo dati di attività in specifiche zone infatti, la promozione del turismo è uno degli obiettivi che si pone Atera.\nInoltre, le associazioni responsabili del mantenimento delle infrastrutture, potranno avere un canale di comunicazione immediato tramite il quale poter incentivare un turismo più consapevole e informato.\n",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label))),
                  ),
                ],
              ),
            ),
          ),
          if (_controller.value.isInitialized)
            Center(
              child: SizedBox(
                height: dimensionFromSizeFactor(context, 128),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(8),
              child: Center(child: CircularProgressIndicator()),
            )
        ],
      ),
    );
  }

  Widget _buildIdeaSection() {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).colorScheme.background,
      width: screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ResponsiveText(
            "La nostra idea",
            sizeFactor: sizeFactorFromCategory(TextCategory.header),
            style: const TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w800),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: dimensionFromSizeFactor(context, 4)),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Atera",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label)),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  TextSpan(
                    text:
                        " nasce dall'unione dei due mondi che ci appassionano: la natura e l'informatica.\nAbbiamo ideato un'applicazione che potesse portare dei benefici a tutti coloro che fanno parte del mondo delle attività outdoor.\n",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label))),
                  ),
                ],
              ),
            ),
          ),
          InfoCarousel(
            descriptionSizeFactor: sizeFactorFromCategory(TextCategory.label),
            titleSizeFactor: sizeFactorFromCategory(TextCategory.label),
            title: ResponsiveText(
              "Per gli utenti",
              sizeFactor: sizeFactorFromCategory(TextCategory.body),
              textAlign: TextAlign.center,
            ),
            info: [
              Info(
                "assets/images/discover.svg",
                "Scopri nuove avventure",
                "Trova la tua prossima avventura grazie a sistemi di ricerca basati su categorie e valutazioni",
              ),
              Info(
                "assets/images/achievement.svg",
                "Poniti degli obiettivi",
                "Con il sistema di attestazione di Atera, mantieni i record di tutte le attività completate: sali di livello e scala le classifiche",
              ),
              Info(
                "assets/images/secure_info.svg",
                "Informazioni concise, sicure, utili",
                "Su Atera trovi solo le informazioni necessarie per effettuare le tue attività preferite",
              ),
              Info(
                "assets/images/coupons.svg",
                "Ottieni benefici grazie alle tue passioni",
                "Riscatta buoni sconto e benefici semplicemente facendo quello che ami",
              ),
            ],
          ),
          const Divider(height: 64, thickness: 1, endIndent: 64, indent: 64),
          InfoCarousel(
            mirrored: true,
            descriptionSizeFactor: sizeFactorFromCategory(TextCategory.label),
            titleSizeFactor: sizeFactorFromCategory(TextCategory.label),
            title: ResponsiveText(
              "Per gli enti turistici",
              sizeFactor: sizeFactorFromCategory(TextCategory.body),
              textAlign: TextAlign.center,
            ),
            info: [
              Info(
                "assets/images/turismo.svg",
                "Promozione del territorio e del turismo",
                "Il sistema di Atera è estremamente modulare: gli enti turistici e le amministrazioni locali fornendo sconti e benefici hanno la possibilità di promuovere il territorio a persone direttamente interessate",
              ),
              Info(
                "assets/images/comunicazione.svg",
                "Canale di comunicazione",
                "Le associazioni incaricate del mantenimento delle infrastrutture avranno la possibilità di comunicare stato, avvisi e più in generale informazioni utili per sensibilizzare e promuovere un turismo responsabile e bene informato",
              ),
            ],
          ),
          const Divider(height: 64, thickness: 1, endIndent: 64, indent: 64),
          InfoCarousel(
            descriptionSizeFactor: sizeFactorFromCategory(TextCategory.label),
            titleSizeFactor: sizeFactorFromCategory(TextCategory.label),
            title: ResponsiveText(
              "Per i brand",
              sizeFactor: sizeFactorFromCategory(TextCategory.body),
              textAlign: TextAlign.center,
            ),
            info: [
              Info(
                "assets/images/app_page.svg",
                "Una pagina dedicata",
                "Atera permette la creazione di pagine dedicate all'interno dell'applicazione, incrementando la visibilità degli esercizi commerciali",
              ),
              Info(
                "assets/images/target.svg",
                "Pubblico estremamente mirato",
                "Proprio grazie alla sua struttura e idea, Atera raggruppa una community genuinamente interessata al mondo delle attività outdoor",
              ),
              Info(
                "assets/images/revenue.svg",
                "Incrementa la tua customer base",
                "Fornendo sconti e benefici agli utenti di Atera, incrementi la visibilità dell'esercizio commerciale e attrai una clientela interessata ai tuoi prodotti",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).colorScheme.background,
      width: screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ResponsiveText(
            textAlign: TextAlign.center,
            sizeFactor: sizeFactorFromCategory(TextCategory.header),
            "Chi siamo",
            style: const TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w800),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: dimensionFromSizeFactor(context, 10),
            ),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Siamo studenti di informatica, ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label))),
                  ),
                  TextSpan(
                    text: "Matteo",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label)),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  TextSpan(
                    text: " ed ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label))),
                  ),
                  TextSpan(
                    text: "Enrico",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label)),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  TextSpan(
                    text: " all'Università di Trento, ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label))),
                  ),
                  TextSpan(
                    text: "Thomas",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label)),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  TextSpan(
                    text: " all'Università di Udine.\n",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label))),
                  ),
                  TextSpan(
                    text:
                        "Da sempre appassionati di attività outdoor, montagna e tutto ciò che riguarda la natura in generale, abbiamo deciso di creare un qualcosa che possa veramente apportare dei benefici alla comunità di questo mondo e allo stesso tempo che potesse divertirci.\n",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: dimensionFromSizeFactor(context, sizeFactorFromCategory(TextCategory.label))),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: dimensionFromSizeFactor(context, 8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MemberAvatar(
                  textSizeFactor: sizeFactorFromCategory(TextCategory.body),
                  name: "Matteo",
                  imageUrl: "assets/images/trat.webp",
                  photoInfo: "Ferrata O. Marangoni, Mori",
                ),
                MemberAvatar(
                  textSizeFactor: sizeFactorFromCategory(TextCategory.body),
                  name: "Enrico",
                  imageUrl: "assets/images/eri.webp",
                  photoInfo: "Ferrata Hoachwool, Naturno",
                ),
                MemberAvatar(
                  textSizeFactor: sizeFactorFromCategory(TextCategory.body),
                  name: "Thomas",
                  imageUrl: "assets/images/thom.webp",
                  photoInfo: "Sappada, Monte Siera",
                ),
              ],
            ),
          ),
          const Responsive(sizeFactor: 32)
        ],
      ),
    );
  }

  Widget _buildRoadmap() {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).colorScheme.background,
      width: screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveText(
            sizeFactor: sizeFactorFromCategory(TextCategory.header),
            "Il nostro piano",
            style: const TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w800),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: dimensionFromSizeFactor(context, 4),
            ),
            child: null,
          ),
          const Responsive(sizeFactor: 8),
          Roadmap(
            //minHeight: dimensionFromSizeFactor(context, 210),
            autoPlay: false,
            steps: [
              RoadmapStep(
                "Idea",
                "In questa fase abbiamo ideato tutto l'ecosistema, mettendo particolare enfasi su cosa volessimo che diventasse e che benefici avrebbe dovuto apportare al mondo delle attività outdoor.",
                state: RoadmapStepState.completed,
                substeps: [
                  RoadmapStep(
                    "Target",
                    "Identificazione del nostro target, a chi dovesse essere rivolta la nostra piattforma",
                    state: RoadmapStepState.completed,
                  ),
                  RoadmapStep(
                    "Interazioni",
                    "Come le varie entità che compongono la piattaforma interagiscono, definizione dei benefici comuni e del come Atera potesse farsi spazio nel mercato",
                    state: RoadmapStepState.completed,
                  ),
                  RoadmapStep(
                    "Fattibilità",
                    "Studio di fattibilità tecnica dell'ecosistema. Identificazione delle tecnologie necessarie e stima del tempo di sviluppo",
                    state: RoadmapStepState.completed,
                  ),
                ],
              ),
              RoadmapStep(
                "Realizzazione",
                "Realizzazione dell'applicazione e delle tecnologie necessarie per il suo funzionamento. Vogliamo creare e distribuire un'applicazione che sia utile, facile da usare e esteticamente accattivante. Come sanno tutti gli informatici, questa fase rappresenta la più impegnativa e lunga, ma allo stesso tempo una delle più divertenti.",
                state: RoadmapStepState.doing,
                substeps: [
                  RoadmapStep(
                    "Prodotto minimo",
                    "La creazione di un prodotto minimo che abbia le funzionalità base che Atera si pone di avere, come il sistema di attestazione delle attività, la ricerca intelligente per zona, categoria e caratteristiche e il riscatto di buoni sconto da pagine dedicate",
                    state: RoadmapStepState.completed,
                  ),
                  RoadmapStep(
                    "Versione beta chiusa",
                    "Questa versione ci permette di mostrare un prodotto perssochè finito, con funzionalità aggiuntive quali la distribuzione dei coupon sottoforma di QR codes, l'integrazione di una sezione dedicata ai commercianti che permetta loro di verificare l'attendibilità dei coupon sconto. In questa fase pianifichiamo di far testare la nostra piattaforma a un numero chiuso di utenti in modo tale da apportare migliori tramite i feedback di utenti esterni",
                    state: RoadmapStepState.completed,
                  ),
                  RoadmapStep(
                    "Ricerca brands",
                    "In questa fase ricerchiamo i primi brands e negozi che siano interessati nell'aiutarci a far crescere il nostro prodotto",
                    state: RoadmapStepState.doing,
                  ),
                  RoadmapStep(
                    "Versione beta aperta",
                    "Integrati i primi negozi all'interno della nostra piattaforma, siamo pronti a lanciare il prodotto sul mercato in forma di beta aperta. In questa fase, Atera avrà già disponibili le prime attestazioni di attività, tramite il quale gli utenti avranno la possibilità di riscattare benefici e sconti presso i brands partner",
                    state: RoadmapStepState.doing,
                  ),
                ],
              ),
              RoadmapStep(
                "Espansione",
                "Atera punta in alto. In questa fase puntiamo ad un espansione su le più famose regioni dell'arco alpino e dolomitico, promuovendo l'ecosistema e l'abilitazione di nuove attestazioni in tutto il territorio. Inoltre puntiamo ad integrare altre categorie di attività all'interno dell'applicazione",
                state: RoadmapStepState.planned,
                substeps: [
                  RoadmapStep(
                    "Integrazione di attività sciistiche",
                    "Vogliamo permettere l'attestazione di attività in ambito sciistico con la possibilità di riscattare sconti sull'acquisto di skipass presso i più grandi comprensori delle Dolomiti",
                  ),
                  RoadmapStep(
                    "Collaborazioni con enti turistici",
                    "Gli enti turistici rappresentano un entità importante all'interno di Atera. Collaborando con questi ultimi, sarà possibile da un lato fornire informazioni sempre aggiornate e controllate riguardo le attività, dall'altro permettere la promozione del turismo in località mirate.",
                  ),
                  RoadmapStep(
                    "Espansione in altre località",
                    "Atera partirà dalla regione del Trentino. Tuttavia puntiamo ad espanderci presto a tutto l'arco alpino fino al centro Italia, coprendo un giorno tutte le attività disponibili sul territorio Italiano",
                  ),
                ],
              ),
              RoadmapStep(
                "Collaborazioni",
                "Mettendo in comunicazione i brands direttamente con gli utenti interessati, puntiamo a collaborazioni con i grandi brands italiani di attrezzatura outdoor, permettendo ai nostri utenti di usufruire di sconti grazie alle loro passioni e allo stesso tempo ai brands di aumentare l'efficacia delle loro campagne pubblicitarie tramite una community specifica e appassionata.",
                state: RoadmapStepState.planned,
                substeps: [
                  RoadmapStep("Achieve the world....", "Il meglio deve ancora venire!", state: RoadmapStepState.completed),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
