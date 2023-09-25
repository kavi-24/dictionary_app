import 'package:dictionary_app/common/colours.dart';
import 'package:dictionary_app/pages/bookmarks.dart';
import 'package:dictionary_app/pages/loading.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  List<Widget> screens = [
    Loading(),
    Bookmarks(),
    Settings(),
  ];

  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
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
            }
        ),
        body: SafeArea(
          child: Center(
            child: Text(
              "Settings"
            ),
          ),
        ),
      ),
    );
  }
}
