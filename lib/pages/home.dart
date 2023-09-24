import 'package:clipboard/clipboard.dart';
import 'package:dictionary_app/common/colours.dart';
import 'package:dictionary_app/common/custom_icons_icons.dart';
import 'package:dictionary_app/pages/meaning.dart';
import 'package:dictionary_app/services/get_meaning.dart';
import 'package:dictionary_app/services/get_words.dart';
import 'package:dictionary_app/services/words_that_start_with.dart';
import 'package:dictionary_app/widgets/four_squares_icon.dart';
import 'package:dictionary_app/widgets/words_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  const Home({super.key, required this.words});
  final List<String> words;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  FocusNode searchBarFocusNode = FocusNode();
  bool hasFocus = false;
  bool isGrid = false;
  List<String> wordsClone = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchBarFocus);
    setState(() {
      wordsClone = widget.words;
    });
  }

  void _onSearchBarFocus() async {
    setState(() {
      hasFocus = searchBarFocusNode.hasFocus;
    });
  }

  Future<bool> _onWillPopScope() async {
    // check if the search bar has focus
    if (searchBarFocusNode.hasFocus) {
      // if it does, unfocus it
      setState(() {
        searchBarFocusNode.unfocus();
        _searchController.clear();
        hasFocus = false;
      });
      // and return false so that the app doesn't close
      return false;
    }
    // if it doesn't, ask the user if they want to exit the app
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Are you sure?"),
            content: const Text("Do you want to exit the app?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Yes"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<List> getMeaing_(String query) async {
    GetMeaning getMeaning = GetMeaning();
    Map map = {};
    try {
      map = await getMeaning.getMeaningDictAPIColl(query);
      // FlutterClipboard.copy(map.toString());
      return [map, "coll"];
    } catch (e) {
      try {
        map = await getMeaning.getMeaningDictAPIInter(query);
        // FlutterClipboard.copy(map.toString());
        return [map, "inter"];
      } catch (e) {
        try {
          map = await getMeaning.getMeaningAPIDict(query);
          // FlutterClipboard.copy(map.toString());
          return [map, "api"];
        } catch (e) {
          return [];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      /*
       [KeyEvent] ViewRootImpl KeyEvent { action=ACTION_DOWN, keyCode=KEYCODE_BACK, scanCode=0, metaState=0, flags=0x8, repeatCount=0, eventTime=281065108, downTime=281065108, deviceId=-1, source=0x101, displayId=0 }
      */
      onWillPop: _onWillPopScope,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: colours[3],
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
            //Handle button tap
          },
        ),
        body: SafeArea(
          child: Column(
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
                            setState(() {
                              isGrid = !isGrid;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ), // Configure hit area.
                            child: isGrid
                                ? const Icon(
                                    CustomIcons.format_list_bulleted,
                                    color: Colors.white,
                                    size: 18.5,
                                  )
                                : const FourSquaresIcon(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Icon(
                              CustomIcons.search,
                              color: colours[0],
                              size: 21,
                            ),
                          ),
                          IntrinsicWidth(
                            child: TextField(
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    hasFocus = false;
                                  });
                                } else {
                                  _onSearchBarFocus();
                                }
                              },
                              controller: _searchController,
                              focusNode: searchBarFocusNode,
                              cursorColor: colours[0],
                              decoration: InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: colours[6].withOpacity(0.5),
                                  fontSize: 18,
                                ),
                              ),
                              style: TextStyle(
                                color: colours[0],
                              ),
                            ),
                          ),
                          _searchController.text.isEmpty
                              ? IconButton(
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    CustomIcons.keyboard_voice,
                                    color: colours[0],
                                  ),
                                )
                              : IconButton(
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: colours[0],
                                  ),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.grey.shade100,
                  child: !hasFocus
                      ? isGrid
                          ? LiquidPullToRefresh(
                              color: colours[3],
                              springAnimationDurationInMilliseconds: 500,
                              onRefresh: () async {
                                List<String> words =
                                    await GetWords().getWords();
                                setState(() {
                                  wordsClone = words;
                                });
                              },
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2.3,
                                ),
                                itemCount: wordsClone.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      List l =
                                          await getMeaing_(wordsClone[index]);
                                      if (l.isNotEmpty) {
                                        Map meaningMap = l[0];
                                        String source = l[1];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Meaning(
                                              // word: wordsClone[index],
                                              map: meaningMap,
                                              // source: source,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: WordsTile(
                                        text: wordsClone[index],
                                        width: 100,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : LiquidPullToRefresh(
                              onRefresh: () async {
                                List<String> words =
                                    await GetWords().getWords();
                                setState(() {
                                  wordsClone = words;
                                });
                              },
                              color: colours[3],
                              springAnimationDurationInMilliseconds: 500,
                              child: ListView.builder(
                                itemCount: wordsClone.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () async {
                                    List l =
                                        await getMeaing_(wordsClone[index]);
                                    if (l.isNotEmpty) {
                                      Map meaningMap = l[0];
                                      String source = l[1];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Meaning(
                                            // word: wordsClone[index],
                                            map: meaningMap,
                                            // source: source,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: WordsTile(
                                      text: wordsClone[index],
                                    ),
                                  ),
                                ),
                              ),
                            )
                      : FutureBuilder(
                          future: WordsThatStartWith()
                              .getWords(_searchController.text),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () async {
                                    List l =
                                        await getMeaing_(snapshot.data![index]);
                                    if (l.isNotEmpty) {
                                      Map meaningMap = l[0];
                                      String source = l[1];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Meaning(
                                            // word: snapshot.data![index],
                                            map: meaningMap,
                                            // source: source,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: WordsTile(
                                      text: snapshot.data![index],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: SpinKitRipple(
                                  size: 100,
                                  color: colours[3],
                                ),
                              );
                            }
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
