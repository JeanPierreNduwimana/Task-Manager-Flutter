import 'package:flutter/material.dart';


class Connexion extends StatelessWidget {
  const Connexion({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Connexion'),
        backgroundColor: Colors.deepPurple,
      ),

      body: Center(
          child: Column(
            children: [
              const Text('Ceci est la page de Connexion'),
              ElevatedButton(
                child: const Text('Acceuil'),
                onPressed: () {Navigator.pushNamed(context, '/accueil');},
              )
            ],
          )
      ),
    );
  }
}