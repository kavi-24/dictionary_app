import 'package:dictionary_app/common/colours.dart';
import 'package:dictionary_app/services/database.dart';
// import 'package:dictionary_app/services/database.dart';
import 'package:flutter/material.dart';

class WordsTile extends StatefulWidget {
  const WordsTile({super.key, required this.text, this.width});
  final String text;
  final int? width;

  @override
  State<WordsTile> createState() => _WordsTileState();
}

class _WordsTileState extends State<WordsTile> {

  List<Map<String, dynamic>> dbData = [];

  @override
  void initState() {
    readDB();
    super.initState();
  }

  void readDB() async {
    await DatabaseHelper().readData().then((value) {
      setState(() {
        dbData = value;
      });
    });
  }

  bool getIfBookmarked(String text) {
    bool retVal = false;
    for (int i = 0; i < dbData.length; i++) {
      if (dbData[i]["word"] == text) {
        retVal = true;
        break;
      }
    }
    // print(retVal);
    return retVal;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: (MediaQuery.of(context).size.width) / 2,
      padding: const EdgeInsets.all(8).copyWith(left: 10, right: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: widget.width != null ? widget.width!.toDouble() : null,
            child: Text(
              widget.text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontFamily: "RobotoMono",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              getIfBookmarked(widget.text) ? Icons.bookmark : Icons.bookmark_border,
              color: !getIfBookmarked(widget.text) ? Colors.grey.shade400 : colours[3],
            ),
          ),
        ],
      ),
    );
  }
}
