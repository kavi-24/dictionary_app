// import 'package:dictionary_app/common/colours.dart';
// import 'package:dictionary_app/custom_icons_icons.dart';
// import 'package:dictionary_app/widgets/four_squares_icon.dart';
// import 'package:flutter/material.dart';

// class TitleContainer extends StatefulWidget {
//   const TitleContainer({super.key});

//   @override
//   State<TitleContainer> createState() => _TitleContainerState();
// }

// class _TitleContainerState extends State<TitleContainer> {

//   TextEditingController _searchController = new TextEditingController();
//   FocusNode searchBarFocusNode = new FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchBarFocus);
//   }

//   void _onSearchBarFocus() {
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       color: colours[3],
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                     color: Colors.white,
//                     width: 1.5,
//                   ),
//                 ),
//                 child: Text(
//                   "A",
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               Text(
//                 "DICTIONARY",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               FourSquaresIcon(),
//             ],
//           ),
//           SizedBox(height: 20),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Icon(
//                   // Icons.search_rounded,
//                   CustomIcons.search,
//                   size: 20,
//                   color: colours[0],
//                 ),
//                 IntrinsicWidth(
//                   child: TextField(
//                     // keyboardType: TextInputType.text,
//                     onChanged: (value) {
//                       _onSearchBarFocus();
//                     },
//                     controller: _searchController,
//                     focusNode: searchBarFocusNode,
//                     decoration: InputDecoration(
//                       hintText: "Search",
//                       border: InputBorder.none,
//                       hintStyle: TextStyle(
//                         color: colours[0],
//                       ),
//                     ),
//                     style: TextStyle(
//                       color: colours[0],
//                     ),
//                   ),
//                 ),
//                 Icon(
//                   CustomIcons.keyboard_voice,
//                   color: colours[0],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
