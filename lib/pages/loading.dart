import 'package:dictionary_app/common/colours.dart';
import 'package:dictionary_app/pages/home.dart';
import 'package:dictionary_app/services/get_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: colours[3],
      body: Center(
        child: FutureBuilder(
          future: GetWords().getWords(),
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Home(
                words: snapshot.data!,
              );
              // Navigator.pushReplacement(
              //     context, MaterialPageRoute(builder: (context) => const Home()));
            } else {
              return SpinKitFoldingCube(
                color: colours[3],
                size: 50.0,
              );
            }
          },
        ),
      ),
    );
  }
}
