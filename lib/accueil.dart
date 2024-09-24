import 'package:flutter/material.dart';
import 'package:tp1_flutter/consultation_tache.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/tiroir_nav.dart';
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

  Widget buildBody(String username){
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
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                //padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey, width: 1)),
                
                child: ListTile(
                  title: Text(tache.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  subtitle: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Icon(Icons.hourglass_bottom, size: 16,),
                          Text('${tache.percentageTimeSpent} %'),
                          const SizedBox(width:20),
                          const Icon(Icons.flag, size: 16),
                          Text('${formattageDate(tache.deadline)} %')
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check, size: 16,),
                          Text('${tache.percentageDone} %')
                        ],
                      )
                    ],
                  ),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ConsultationTache(id: tache.id.toString(), username: username)),
                    );
                  },
                  
                ),
              );
            }
            return null;
          },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Accueil'),
          backgroundColor: Colors.deepPurple,
        ),
        body: buildBody(username),
      drawer: LeTiroir(username: username),

      floatingActionButton: FloatingActionButton(
        //backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: (){
          Navigator.pushNamed(context, '/creationtache', arguments: username);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}

String formattageDate( String isoDate){


  if(isoDate == ''){
    return '';
  }

  // Convertir la chaîne en objet DateTime
  DateTime dateTime = DateTime.parse(isoDate);

  // Formater la date en 'YYYY-MM-DD'
  String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

  // retourne la date formatée
  return formattedDate;
}