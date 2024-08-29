import 'package:flutter/material.dart';


class Inscription extends StatelessWidget {
  const Inscription({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Inscription'),
         backgroundColor: Colors.deepPurple,
        ),

      body: Center(

        child: Column(
          children: [
            const Text('Ceci est la page d\'inscription'),
            ElevatedButton(
              child: const Text('Connexion'),
              onPressed: () {Navigator.pushNamed(context, '/connexion');},
            )
          ],
        )
      ),
      );
  }
}