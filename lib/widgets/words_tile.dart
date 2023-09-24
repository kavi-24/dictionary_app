import 'package:dictionary_app/common/colours.dart';
import 'package:flutter/material.dart';

class WordsTile extends StatelessWidget {
  const WordsTile({super.key, required this.text, this.width});
  final String text;
  final int? width;

  bool getIfBookmarked(String text) {
    return false;
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
            width: width != null ? width!.toDouble() : null,
            child: Text(
              text,
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
              getIfBookmarked(text) ? Icons.bookmark : Icons.bookmark_border,
              color: !getIfBookmarked(text) ? Colors.grey.shade400 : colours[3],
            ),
          ),
        ],
      ),
    );
  }
}
