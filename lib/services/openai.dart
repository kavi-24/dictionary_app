import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAI {
  // get api from environment variable OPENAI_API_KEY
  final String apiKey = const String.fromEnvironment("OPENAI_API_KEY");
  final String endpoint =
      'https://api.openai.com/v1/engines/davinci/completions'; // Replace with the appropriate endpoint

  Future<String> getMeaning(String query) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final Map<String, dynamic> requestBody = {
      'prompt':
          'Print the type (noun, adj, verb), pronunciation, meaning(s) and example(s) of the following word: $query',
      // 'max_tokens': 50,
      'n': 1,
    };
    http.Response response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: json.encode(requestBody),
    );
    print(response.statusCode);
    print(response.body);
    // Map responseData = json.decode(response.body);
    // String generatedText = responseData['choices'][0]['text'];
    // print(generatedText);
    // return generatedText;
    return "";
  }
}

void main() async {
  OpenAI().getMeaning('hello');
}
