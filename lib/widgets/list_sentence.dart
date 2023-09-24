import 'package:flutter/material.dart';

class ListSentence extends StatelessWidget {
  const ListSentence({super.key, required this.words});
  final List<String> words;

  String formatWords() {
    String result = "";
    for (var i = 0; i < words.length; i++) {
      result += (i != words.length - 1)
          ? "-\t\t\t\t${words[i]}\n\n"
          : "-\t\t\t\t${words[i]}";
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Text(
        formatWords(),
        style: const TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
