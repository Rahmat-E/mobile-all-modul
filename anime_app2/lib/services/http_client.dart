import 'package:http/http.dart' as http;
import '../core/constants.dart';

class HttpClient {
  static Future<http.Response> get(String url) {
    return http.get(
      Uri.parse(url),
      headers: {
        "X-MAL-CLIENT-ID": AppConstants.clientId,
      },
    );
  }
}
