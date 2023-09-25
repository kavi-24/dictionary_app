import 'package:dictionary_app/common/colours.dart';
import 'package:dictionary_app/pages/loading.dart';
import 'package:dictionary_app/pages/settings.dart';
import 'package:dictionary_app/services/database.dart';
import 'package:dictionary_app/widgets/four_squares_icon.dart';
import 'package:flutter/material.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  List<Map<String, dynamic>> dbData = [];
  int selectedIndex = 1;

  List<Widget> screens = [
    Loading(),
    Bookmarks(),
    Settings(),
  ];

  void getData() async {
    List<Map<String, dynamic>> data = await DatabaseHelper().readData();
    setState(() {
      dbData = data;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            elevation: 20,
            iconSize: 30,
            currentIndex: selectedIndex,
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
            }),
        body: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: Center(
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
                              behavior: HitTestBehavior.translucent,
                              // Needed for invisible things to be tapped.
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
                              // behavior: HitTestBehavior
                              //     .translucent, // Needed for invisible things to be tapped.
                              // onTap: () {
                              //   setState(() {
                              //     isGrid = !isGrid;
                              //   });
                              // },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ), // Configure hit area.
                                // child: isGrid
                                //     ? const Icon(
                                //   CustomIcons.format_list_bulleted,
                                //   color: Colors.white,
                                //   size: 18.5,
                                // )
                                //     : const FourSquaresIcon(),
                                child: const FourSquaresIcon(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: dbData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dbData[index]["word"],
                                style: TextStyle(
                                  fontSize: 27,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    dbData[index]["type"],
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${"/" + dbData[index]["pronunciation"]}/",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                dbData[index]["meanings"].toString().substring(
                                      1,
                                      dbData[index]["meanings"]
                                              .toString()
                                              .length -
                                          1,
                                    ),
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                dbData[index]["examples"].toString().substring(
                                      1,
                                      dbData[index]["examples"]
                                              .toString()
                                              .length -
                                          1,
                                    ),
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
