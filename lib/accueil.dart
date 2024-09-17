import 'package:flutter/material.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/transfer.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => AccueilState();
}

class AccueilState extends State<Accueil> {

  List<HomeItemResponse> taches= [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListTaches();
  }

  Future<List<HomeItemResponse>> getListTaches() async{

    taches = await getHomeItemResponse();
    setState(() {});
    return taches;
  }

  Widget buildBody(){
    if(taches.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Aucune tâche disponible'),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, '/creationtache');
            },
            child: const Text('Ajouter une tâche'))
          ],
        ),
      );
    }else{
      return ListView.builder(
          itemBuilder: (BuildContext context, int index ){
            if(index < taches.length){
              final tache = taches[index];
              return ListTile(
                title: Text(tache.name),
                onTap: (){
                  Navigator.pushNamed(context, '/consultation_tache');
                },
              );
            }
            return null;
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Accueil'),
          backgroundColor: Colors.deepPurple,
        ),
        body: buildBody(),

      floatingActionButton: FloatingActionButton(
        //backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: (){
          Navigator.pushNamed(context, '/creationtache');
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}