import "package:atera_website/src/common/privacy_policy.dart";
import "package:atera_website/src/widgets/tokenized_text.dart";
import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});
  static const String route = "privacy";

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy dell'app")),
      body: FutureBuilder<String>(
        future: PrivacyPolicy.fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: TokenizedText(
                    onTokenTap: (text, type, payload) async {
                      if (type == "lk") {
                        final url = Uri.parse(payload);
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      }
                      if (type == "m") {
                        Uri mail = Uri.parse("mailto:$payload?subject=Privacy");
                        await launchUrl(mail, mode: LaunchMode.platformDefault);
                      }
                    },
                    styleBuilder: (type, payload) {
                      if (type == "i") {
                        return Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: double.parse(payload),
                              fontStyle: FontStyle.italic,
                              color: Theme.of(context).colorScheme.tertiary,
                            );
                      }
                      if (type == "b") {
                        return Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: double.parse(payload), fontWeight: FontWeight.bold);
                      }
                      if (type == "m") {
                        return Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary);
                      }
                      if (type == "g") {
                        return Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: double.parse(payload), color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5));
                      }
                      return null;
                    },
                    rawString: snapshot.data!,
                    sanitizeUnicode: true,
                    defaultStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
