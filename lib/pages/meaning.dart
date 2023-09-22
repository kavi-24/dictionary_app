import 'package:dictionary_app/common/colours.dart';
import 'package:dictionary_app/widgets/horizontal_slider.dart';
import 'package:flutter/material.dart';

class Meaning extends StatelessWidget {
  const Meaning({super.key, required this.word, required this.meaning});
  final String word;
  final Map meaning;

  List<String> getMeanings() {
    List<String> meanings = [];
    // String meaningStr = "";
    try {
      meanings.add(meaning["shortdef"][0].toString());
      // meaningStr += "${meaning["shortdef"][0]}|";
    } catch (e) {
      print(e);
    }
    List sseq = meaning["def"][0]["sseq"];
    for (var i in sseq) {
      try {
        meanings.add(
          i[0][1]["dt"][0][1]
              .replaceAll(RegExp(r'\{.*?\}'), '')
              .replaceAll(RegExp(r'\s+'), ' ')
              .toString(),
        );
        // meaningStr += "${i[0][1]["dt"][0][1].replaceAll(RegExp(r'\{.*?\}'), '').replaceAll(RegExp(r'\s+'), ' ')}|";
      } catch (e) {
        continue;
      }
    }
    for (String i in meanings) {
      print(i);
    }

    //remove duplicates
    meanings = meanings.toSet().toList();

    return meanings;
  }

  List<String> getUses() {
    List<String> uses = [];
    // String usesStr = "";
    List sseq = meaning["def"][0]["sseq"];
    for (var i in sseq) {
      try {
        uses.add(
          i[0][1]["dt"][1][1][0]["t"]
              .replaceAll(RegExp(r'\{.*?\}'), '')
              .replaceAll(RegExp(r'\s+'), ' ')
              .toString(),
        );
        // usesStr += "${i[0][1]["dt"][1][1][0]["t"].replaceAll(RegExp(r'\{.*?\}'), '').replaceAll(RegExp(r'\s+'), ' ')}|";
      } catch (e) {
        continue;
      }
    }
    for (String i in uses) {
      print(i);
    }
    return uses;
  }

  void getSyllablePronounciation() {
    print(meaning["hwi"]["hw"]); // syllable
    print(meaning["hwi"]["prs"][0]["mw"]); // pronounciation
    // print(meaning["hwi"]["prs"][0]["sound"]["audio"]);
  }

  String getSyllable() {
    return meaning["hwi"]["hw"] ?? "";
  }

  String getPronounciation() {
    try {
      return meaning["hwi"]["prs"][0]["mw"] ?? "";
    } catch (e) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: colours[3],
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior
                            .translucent, // Needed for invisible things to be tapped.
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ), // Configure hit area.
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                            child: const Text(
                              "A",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        "DICTIONARY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Times New Roman",
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior
                            .translucent, // Needed for invisible things to be tapped.
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ), // Configure hit area.
                          child: const Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Column(
                    children: [
                      Text(
                        word,
                        style: const TextStyle(
                          letterSpacing: 1.2,
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      getPronounciation().isNotEmpty
                          ? Column(
                              children: [
                                Text(
                                  getPronounciation(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                  Text(
                    meaning["fl"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconContainer(
                          icon: Icons.copy_rounded,
                          onTap: () {},
                        ),
                        IconContainer(
                          icon: Icons.bookmark_add_outlined,
                          onTap: () {},
                        ),
                        IconContainer(
                          icon: Icons.share_outlined,
                          onTap: () {},
                        ),
                        IconContainer(
                          icon: Icons.volume_up_rounded,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Flexible(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meaning(s)",
                          style: TextStyle(
                            color: colours[2],
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        HorizontalSlider(words: getMeanings()),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Use(s)",
                          style: TextStyle(
                            color: colours[2],
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // HorizontalSlider(words: getUses()),
                      ],
                    ),
                  ),
                ],
              ),
            )
            /*
            access sound: https://media.merriam-webster.com/audio/prons/en/us/mp3/p/pajama02.mp3
            */
            // Flexible(
            //   child: ListView(
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.all(20),
            //         padding: const EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           color: Colors.white54,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Meaning(s)",
            //               style: TextStyle(
            //                 color: colours[2],
            //                 fontSize: 23,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //             Flexible(
            //               child: ListView.builder(
            //                 itemCount: getMeanings().length,
            //                 itemBuilder: (context, index) {
            //                   return ListTile(
            //                     title: Text(
            //                       getMeanings()[index],
            //                       style: const TextStyle(
            //                         fontStyle: FontStyle.italic,
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       Flexible(
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: Colors.grey.shade200,
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //           child: ListView.builder(
            //               itemCount: getMeanings().length,
            //               itemBuilder: (context, index) {
            //                 return ListTile(
            //                   title: Text(
            //                     getMeanings()[index],
            //                     style: const TextStyle(
            //                       fontSize: 20,
            //                       fontStyle: FontStyle.italic,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //                 );
            //               }),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, required this.icon, required this.onTap});
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
