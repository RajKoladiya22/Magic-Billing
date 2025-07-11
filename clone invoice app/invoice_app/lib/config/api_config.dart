class ApiConfig {

 static String baseUrl = "https://billing.magicallysoft.com/api/v1/";
  static Map<String, String> headers = {
    'x-api-key': 'Qr@gZ@da7[jGQ/GRj@D9KSCX#U2Yz',
    'Content-Type': 'application/json',
  };

}

/*import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://your-api.com/api/';
  

  // Example: GET request
  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse(baseUrl + endpoint);
    return await http.get(url, headers: headers);
  }

  // Example: POST request
  static Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse(baseUrl + endpoint);
    return await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
  }
}
 */