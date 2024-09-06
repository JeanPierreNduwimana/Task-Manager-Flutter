import 'package:flutter/material.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/transfer.dart';


class Accueil extends StatelessWidget {
  const Accueil({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //List<HomeitemResponse> taches = await getListTaches();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        backgroundColor: Colors.deepPurple,
      ),
/* body: Center(
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
      ),*/


    body: FutureBuilder<List<HomeItemResponse>>(
      future: getListTaches(),
      builder: (BuildContext context, AsyncSnapshot<List<HomeItemResponse>> snapshot){
        if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Aucune tâche disponible'));
        } else {
          List<HomeItemResponse> taches = snapshot.data!;
          return ListView.builder(
              itemBuilder: (BuildContext context, int index ){
                if(index < taches.length){
                  final tache = taches[index];
                  return ListTile(
                    title: Text(tache.name),
                  );
                }
                return null;
              }
          );
        }

    }
    ),

    );
  }
  
  Future<List<HomeItemResponse>> getListTaches() async{
    return await getHomeItemResponse();
  }

}

//chat gpt code //

/*
import 'package:flutter/material.dart';
import 'package:tp1_flutter/transfer.dart';
import 'lib_http.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<HomeitemResponse>>(
        future: _fetchTaches(),
        builder: (BuildContext context, AsyncSnapshot<List<HomeitemResponse>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune tâche disponible'));
          } else {
            List<HomeitemResponse> taches = snapshot.data!;
            return ListView.builder(
              itemCount: taches.length,
              itemBuilder: (BuildContext context, int index) {
                final tache = taches[index];
                return ListTile(
                  title: Text(tache.name),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<HomeitemResponse>> _fetchTaches() async {
    return await getHomeItemResponse(); // Assurez-vous que cette méthode est correctement définie dans votre lib_http.dart
  }
}*/
