import 'package:http/http.dart' as http;

class WordsThatStartWith {
  Future<List<String>> getWords(String query) async {
    String url = "https://api.datamuse.com/words?sp=$query*&max=10";
    http.Response response = await http.get(Uri.parse(url));
    /*
    [{"word":"swung","score":362},{"word":"swum","score":252},{"word":"swung dash","score":32},{"word":"swu","score":6},{"word":"swung at","score":5},{"word":"swung the lead","score":2}]
    */
    List<String> words = [];
    final regex = RegExp(r'"word":"(.*?)",');
    final matches = regex.allMatches(response.body);
    for (final match in matches) {
      words.add(match.group(1)!); // Extract the word and add it to the list
    }
    // List<String> words = ["eicosanoid","eichmann","eicosanoids","eiche","eichhornia","eic","eich","eicosapentaenoic","eicher","eichler"];
    return words;
  }
}
