import 'package:http/http.dart' as http;

class GetWords {
  Future<List<String>> getWords() async {
    String url = "https://random-word-api.herokuapp.com/word?number=50";
    http.Response response = await http.get(Uri.parse(url));
    List<String> words = response.body
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll("\"", "")
        .split(",");
    // List<String> words = ["supershow","vanadiate","valerian","stylizations","thermotactic","tyrannize","telepathy","bribable","lentic","distortional","soya","misgivings","bibliophily","baptists","bolides","harmin","zoometric","cheerleading","blurrier","opacify","doblon","gerontocrat","clingfish","transposon","alloantibody","brevetting","genitives","duplicating","foundationless","handwriting","calendrical","acknowledging","exscinded","taco","heatstroke","basilects","terrains","centered","gunnies","doronicum","diasporic","peduncles","ringhals","dwelt","fleshy","chrysoberyl","stripling","flack","misadded","thermometer"
    // ];
    return words;
  }
}
