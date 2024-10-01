import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp1_flutter/creation_tache.dart';

import 'accueil.dart';
import 'lib_http.dart';

class LeTiroir extends StatefulWidget {
  final String username;
  const LeTiroir({super.key, required this.username});

  @override
  State<LeTiroir> createState() => LeTiroirState();
}

class LeTiroirState extends State<LeTiroir> {
  @override
  Widget build(BuildContext context) {
    var listView = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          child: Stack(
            alignment: Alignment.center, // Centre le contenu du Stack
            children: [
              Image.asset('assets/images/background_image.jpg'), // L'image
              Column(
                children: [
                  Text(this.widget.username, // Le texte à afficher
                    style: TextStyle(
                      color: Colors.black, // Couleur du texte
                      fontSize: 24, // Taille de la police
                      fontWeight: FontWeight.bold, // Épaisseur de la police
                    ),
                  ),
                  Text('est connecté(e)')
                ],
              )
              
            ],
          ),
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.home),
          title: const Text("Accueil"),
          onTap: () {
            Navigator.pushNamed(
              context, '/accueil', arguments: this.widget.username
            );
            // Then close the drawer
          },
        ),
        // ecran sans paramtre.
        ListTile(
          dense: true,
          leading: const Icon(Icons.add),
          title: const Text("CreationTache"),
          onTap: () {
            Navigator.pushNamed(context, '/creationtache', arguments: this.widget.username);
            // Then close the drawer
          },
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.logout),
          title: const Text("Déconnexion"),
          onTap: () {
            deconnexion();
            // Then close the drawer
          },
        ),
      ],
    );

    return Drawer(
      child: Container(
        color: const Color(0xFFFFFFFF),
        child: listView,
      ),
    );
  }

  void deconnexion() async{
    await signout();
    //Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, '/connexion');
  }
}

