import 'package:flutter/material.dart';
import 'package:tp1_flutter/accueil.dart';
import 'package:tp1_flutter/connexion.dart';
import 'package:tp1_flutter/creation_tache.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'inscription.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // Spanish, no country code
      ],

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: const Connexion(),
      routes: {
        '/inscription': (context) => const InscriptionPage(),
        '/connexion': (context) => const ConnexionPage(),
      },
    );
  }
}
