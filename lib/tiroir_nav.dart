import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp1_flutter/connexion.dart';
import 'package:tp1_flutter/creation_tache.dart';

import 'accueil.dart';
import 'lib_http.dart';

class LeTiroir extends StatefulWidget {
  final String username;
  const LeTiroir({super.key, required this.username});

  @override
  State<LeTiroir> createState() => LeTiroirState();
}
FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _googleSignIn = GoogleSignIn();
class LeTiroirState extends State<LeTiroir> {
  
  bool isDisconnecting = false;
  
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
                  Text(widget.username, // Le texte à afficher
                    style: const TextStyle(
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
            if(!isDisconnecting){
              //Navigator.pushNamed(   context, '/accueil', arguments: this.widget.username);
              Navigator.push(context,MaterialPageRoute(builder: (context) => Accueil(username: this.widget.username)));
            }

            // Then close the drawer
          },
        ),
        // ecran sans paramtre.
        ListTile(
          dense: true,
          leading: const Icon(Icons.add),
          title: const Text("CreationTache"),
          onTap: () {
            if(!isDisconnecting){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CreationTache(username: this.widget.username,),)
              );
             // Navigator.pushNamed(context, '/creationtache', arguments: this.widget.username);
            }
            // Then close the drawer
          },
        ),
        ListTile(
          dense: true,
          leading: const Icon(Icons.logout),
          title: isDisconnecting
              ? Row(
                children: [
                  const Text('Déconnexion...'),
                  const SizedBox(width: 4,),
                  Image.asset('assets/images/tenor.gif', height: 20, width: 20,),
                ],
              )
              : const Text("Déconnexion"),
          onTap: () {
            if(!isDisconnecting){
              firebaseSignOut();
            }
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
    setState(() {
      isDisconnecting = true;  
    });
    try{
      await signout();  
    }finally{
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('username');
      prefs.remove('password');
      //Navigator.pushReplacementNamed(context, '/connexion');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Connexion())
      );
      setState(() {
        isDisconnecting = false;
      });
     // Navigator.of(context).pushReplacement(newRoute)
    }



    
  }

  Future<void> firebaseSignOut() async {
    setState(() {
      isDisconnecting = true;
    });
    try{
      await _auth.signOut();
      await _googleSignIn.signOut();
    }catch(e){
      print("Error during Google sign-in: $e");
      return null;
    }finally{
      setState(() {
        isDisconnecting = false;
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('username');
      prefs.remove('password');
      //Navigator.pushReplacementNamed(context, '/connexion');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Connexion())
      );
      // Navigator.of(context).pushReplacement(newRoute)
    }

  }
}

