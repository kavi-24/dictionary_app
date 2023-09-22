import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HorizontalSlider extends StatelessWidget {
  const HorizontalSlider({super.key, required this.words});
  final List<String> words;

  @override
  Widget build(BuildContext context) {
    // make sure that the height of the scroll is 150 px
    // and the height is auto adjusted for the text area

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: words.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 200,
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(8).copyWith(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: AutoSizeText(
                    words[index],
                    minFontSize: 20,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // return Column(
    //   children: [
    //     Container(
    //       padding: EdgeInsets.all(16.0),
    //       child: TextField(
    //         readOnly: true, // Make the TextField non-editable
    //         decoration: InputDecoration(
    //           labelText: 'Non-Editable Text',
    //           border: OutlineInputBorder(),
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //       child: ListView.builder(
    //         scrollDirection: Axis.horizontal,
    //         itemCount: words.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return Container(
    //             width: 150,
    //             margin: EdgeInsets.only(right: 10),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   words[index],
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontStyle: FontStyle.italic,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //   ],
    // );

    // return SizedBox(
    //   height: 100,
    //   child: Column(
    //     children: [
    //       Expanded(
    //         child: ListView.builder(
    //           scrollDirection: Axis.horizontal,
    //           itemCount: words.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             return SizedBox(
    //               width: 200,
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     padding: const EdgeInsets.all(8)
    //                         .copyWith(left: 10, right: 10),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     child: AutoSizeText(
    //                       words[index],
    //                       style: const TextStyle(
    //                         fontSize: 20,
    //                         fontStyle: FontStyle.italic,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
