import "dart:convert";

import "package:http/http.dart" as http;

class PrivacyPolicy {
  static const String _policyUrl = "https://raw.githubusercontent.com/Ateraworld/.github/main/privacy_ita.txt";

  static String? _policy;

  static Future<String> fetch({bool forceUpdate = false}) async {
    if (!forceUpdate && _policy != null) return _policy!;
    http.Client client = http.Client();
    var req = await client.get(Uri.parse(_policyUrl));
    var bytes = req.bodyBytes;
    _policy = utf8.decode(bytes);
    return _policy!;
  }
}
