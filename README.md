# TP1_Flutter

configurer le http:

- dio:
    - flutter pub addcm dio
- json_annotation
    - flutter pub add json_annotation
- dio_cookie_manager
    - flutter pub add dio_cookie_manager
- build runner
    - dart pub add dev:build_runner
- json_serializable
    - flutter pub add json_serializable
- créer un fichier libhttp. voir au tp flutter pour exemple
- créer un fichier transfer.dart en ajoutant deux importations : import 'package:json_annotation/json_annotation.dart' & part 'transfer.g.dart';
    ex:
 ` @JsonSerializable()
class SignUpRequest {

  SignUpRequest();

  String username = '';
  String password = '';

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => _$SignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
  } `

- dart run build_runner build --delete-conflicting-outputs //code qui genere le fichier transfert.g.dart

https://www.youtube.com/watch?v=cukpZ2ORbsI //tutoriel prof
https://docs.flutter.dev/data-and-backend/serialization/json //site du code qui genere le fichier de transfer


https://www.macincloud.com/

https://www.macincloud.com/

Pour deployement: https://www.youtube.com/watch?v=jm_cKADnNqc

Pour les traductions: https://plugins.jetbrains.com/plugin/13666-flutter-intl


Ajouter shared_preferences à pubspec.yaml

dependencies:
flutter:
sdk: flutter
dio: ^5.6.0
shared_preferences: ^2.0.15

Installer Firebase (Docs): https://firebase.google.com/docs/flutter/setup?hl=fr&platform=ios

Installer Firebase instruction:

# Connection au Firebase:

firebase login

## Installez la CLI FlutterFire en exécutant la commande suivante à partir de n'importe quel répertoire:

dart pub global activate flutterfire_cli

## Dans le répertoire de votre projet Flutter, exécutez la commande suivante pour démarrer le workflow de configuration de l'application :

flutterfire configure

## Dans le répertoire de votre projet Flutter, exécutez la commande suivante pour installer le plug-in principal :

flutter pub add firebase_core

## Dans le répertoire de votre projet Flutter, exécutez la commande suivante pour démarrer le workflow de configuration de l'application :

flutterfire configure

## Dans votre fichier lib/main.dart, importez le plug-in principal Firebase et le fichier de configuration que vous avez généré précédemment :

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

## Toujours dans votre fichier lib/main.dart, initialisez Firebase à l'aide de l'objet DefaultFirebaseOptions exporté par le fichier de configuration:

WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
runApp(const MyApp());

## Recréez votre application Flutter:

flutter run

# Ajouter Firebase Authentication à votre application

## À partir de la racine de votre projet Flutter, exécutez la commande suivante pour installer le plug-in :

flutter pub add firebase_auth

## Une fois l'opération terminée, recompilez votre application Flutter:

flutter run

## Importez le plug-in dans votre code Dart:

import 'package:firebase_auth/firebase_auth.dart';

## Pour vous abonner à ces modifications, appelez la méthode authStateChanges() sur votre Instance FirebaseAuth:

FirebaseAuth.instance
.authStateChanges()
.listen((User? user) {
if (user == null) {
print('User is currently signed out!');
} else {
print('User is signed in!');
}
});

# Installation de Google SignIn
## commend pour l'ajouter
flutter pub add google_sign_in
## Puis
flutter pub get
## Generer le SHA-1 

Dans le terminal du android studio, aller sur le path du dossier android du projet, puis executer cette comande:
./gradlew signingReport
Exemple: PS C:\Users\1783527\Desktop\TP1_Flutter\android> ./gradlew signingReport

Ca generera le SHA-1, puis,
Allez sur firebase dans parametres du projet → selectionne l'application android → AJouter une empreinte.
Ajoutez le SHA-1 que vous avez généré.

# Créer une base de données Cloud Firestore
## exécutez la commande suivante pour installer le plug-in
flutter pub add cloud_firestore
## reconstruisez votre application Flutter
flutter run
## Initialisez une instance de Cloud Firestore :
FirebaseFirestore db = FirebaseFirestore.instance;
