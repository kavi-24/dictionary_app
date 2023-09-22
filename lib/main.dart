import 'package:dictionary_app/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dictionary App",
      /* A delegate is an object that’s responsible for providing a valid
      instance of a localization class when requested by the framework.
      The framework calls the delegate’s load method when the app is
      started, and again when the user changes the system language.
      The delegate’s load method returns a Future, which completes when
      the initialization is finished. */
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en"),
        Locale("es"),
      ],
      home: Loading(),
    );
  }
}
