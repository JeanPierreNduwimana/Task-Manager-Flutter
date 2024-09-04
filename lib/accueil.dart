import 'package:flutter/material.dart';
import 'package:tp1_flutter/lib_http.dart';


class Accueil extends StatelessWidget {
  const Accueil({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Accueil'),
        backgroundColor: Colors.deepPurple,
      ),

      body: Center(
          child: Column(
            children: [
              const Text('Ceci est la page d\' accueil'),
              ElevatedButton(
                child: const Text('Deconnecter'),
                onPressed: () async{
                  await deconnexion();
                  Navigator.pushNamed(context, '/inscription');
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Vous êtes déconnecté')));

                  },
              )
            ],
          )
      ),
    );
  }
}