import "package:atera_website/src/home.dart";
import "package:atera_website/src/theme/theme.dart";
import "package:atera_website/src/widgets/error_builder.dart";
import "package:atera_website/src/widgets/privacy_policy_page.dart";
import "package:flutter/material.dart";
import "package:flutter_web_plugins/flutter_web_plugins.dart";

void main() {
  ErrorWidget.builder = errorBuilder;
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Atera",
      theme: mainTheme(),
      home: const HomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == "/${PrivacyPolicyPage.route}") {
          return MaterialPageRoute<void>(
            builder: (context) => const PrivacyPolicyPage(),
            settings: settings,
          );
        }
        return null;
      },
      routes: {
        PrivacyPolicyPage.route: (context) => const PrivacyPolicyPage(),
      },
    );
  }
}
