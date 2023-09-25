import 'package:clipboard/clipboard.dart';
import 'package:dictionary_app/common/colours.dart';
import 'package:dictionary_app/pages/bookmarks.dart';
import 'package:dictionary_app/pages/loading.dart';
import 'package:dictionary_app/pages/settings.dart';
import 'package:dictionary_app/widgets/list_sentence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Meaning extends StatefulWidget {
  const Meaning({
    super.key,
    // required this.word,
    required this.map,
    // required this.source,
  });
  // final String word;
  final Map map;
  // final String source;

  @override
  State<Meaning> createState() => _MeaningState();
}

class _MeaningState extends State<Meaning> {
  FlutterTts flutterTts = FlutterTts();
  int selectedIndex = 0;
  List<Widget> screens = [
    Loading(),
    Bookmarks(),
    Settings(),
  ];

  void speak() async {
    var result = await flutterTts.speak(widget.map["word"]);
    if (result == 1) {
      // print("Success");
    } else {
      // print("Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        iconSize: 30,
        selectedItemColor: colours[3],
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_added_outlined,
            ),
            label: "Bookmarks",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: "Settings",
          ),
        ],
        onTap: (index) {
          if (index != selectedIndex) {
            setState(() {
              selectedIndex = index;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => screens[index],
              ),
            );
          }
        },
      ),
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Loading(),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ), // Configure hit area.
                          child: Icon(
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
                        widget.map["word"],
                        style: const TextStyle(
                          letterSpacing: 1.2,
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Text(
                            widget.map["pronunciation"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    widget.map["type"],
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
                          onTap: () {
                            FlutterClipboard.copy(widget.map["word"]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                // action: SnackBarAction(
                                //   label: 'Action',
                                //   onPressed: () {
                                //     // Code to execute.
                                //   },
                                // ),
                                content: const Center(
                                  child: Text(
                                    'Word copied to clipboard',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                duration: const Duration(milliseconds: 1500),
                                padding: const EdgeInsets.all(20),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            );
                          },
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
                          onTap: () async {
                            speak();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            // const SizedBox(height: 20),
            Flexible(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Meaning(s)",
                              style: TextStyle(
                                color: colours[2],
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconContainer(
                              icon: Icons.copy_rounded,
                              color: Colors.black,
                              onTap: () {
                                FlutterClipboard.copy(
                                    ListSentence(words: widget.map["meanings"])
                                        .formatWords());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    // action: SnackBarAction(
                                    //   label: 'Action',
                                    //   onPressed: () {
                                    //     // Code to execute.
                                    //   },
                                    // ),
                                    content: const Center(
                                      child: Text(
                                        'Meaning(s) copied to clipboard',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    padding: const EdgeInsets.all(20),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        // HorizontalSlider(words: getMeanings()),
                        ListSentence(words: widget.map["meanings"]),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Example(s)",
                              style: TextStyle(
                                color: colours[2],
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconContainer(
                              icon: Icons.copy_rounded,
                              color: Colors.black,
                              onTap: () {
                                FlutterClipboard.copy(
                                    ListSentence(words: widget.map["examples"])
                                        .formatWords());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    // action: SnackBarAction(
                                    //   label: 'Action',
                                    //   onPressed: () {
                                    //     // Code to execute.
                                    //   },
                                    // ),
                                    content: const Center(
                                      child: Text(
                                        'Example(s) copied to clipboard',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    padding: const EdgeInsets.all(20),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        // HorizontalSlider(words: getUses()),
                        ListSentence(words: widget.map["examples"]),
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

  // Widget sourceCollInter(BuildContext context) {
  //   return
  // }
}

/*
List<String> getMeanings() {
    List<String> meanings = [];
    // String meaningStr = "";
    try {
      meanings.add(widget.meaning["shortdef"][0].toString());
      // meaningStr += "${meaning["shortdef"][0]}|";
    } catch (e) {
      // print(e);
    }
    List sseq = widget.meaning["def"][0]["sseq"];
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
    // for (String i in meanings) {
    //   print(i);
    // }

    //remove duplicates
    meanings = meanings.toSet().toList();

    return meanings;
  }

  List<String> getExamples() {
    List<String> uses = [];
    // String usesStr = "";
    List sseq = widget.meaning["def"][0]["sseq"];
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
    return uses;
  }

  String getWord() {
    return widget.meaning["meta"]["id"];
  }

  String getSyllable() {
    return widget.meaning["hwi"]["hw"] ?? "";
  }

  String getPronunciation() {
    try {
      return widget.meaning["hwi"]["prs"][0]["mw"] ?? "";
    } catch (e) {
      return "";
    }
  }

  String getFl() {
    return widget.meaning["fl"];
  }
*/

class IconContainer extends StatelessWidget {
  const IconContainer(
      {super.key, required this.icon, required this.onTap, this.color});
  final IconData icon;
  final Function() onTap;
  final Color? color;

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
          color: color ?? Colors.white,
        ),
      ),
    );
  }
}
