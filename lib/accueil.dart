import 'package:dio/dio.dart';
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

bool is_LoadingList = false;
bool connection_error = false;
bool isLodingPhoto = false;

class AccueilState extends State<Accueil> {

  List<HomeItemPhotoResponse> taches= [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListTaches();
  }

  Future<List<HomeItemPhotoResponse>> getListTaches() async{
    setStateLoadingList(true);
    try{
      taches = await getHomeItemResponse();
    }catch(e){
      if(e is DioException){
        if(e.type == DioExceptionType.connectionError){
          connection_error = true;
          erreurServeur("connectionError", context);
          Future.delayed(const Duration(seconds: 2), (){
            setStateLoadingList(false);});
        }
      }
    }finally{
      setStateLoadingList(false);
      return taches;
    }

  }

  Widget buildBody(String username){
    if(taches.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            connection_error? const Text('Erreur de connection') : is_LoadingList? const Text('Chargement de la liste des taches') : const Text('Aucune tâche disponible'),
            ElevatedButton(onPressed: (){
              if(connection_error){
                connection_error = false;
                getListTaches();
              }else{
                Navigator.pushNamed(context, '/creationtache', arguments: username);
              }
            },
            child: connection_error? const Text('Recharger')
              : (is_LoadingList)? const SizedBox(
              height: 20, width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ) : const Text('Ajouter une tâche'))
          ],
        ),
      );
    }else{
      return ListView.builder(
          itemBuilder: (BuildContext context, int index ){
            if(index < taches.length){
              final tache = taches[index];
              return GestureDetector(
                  child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            //padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tache.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                          ],
                        ),
                      ),
                      /*(tache.photoId != 0)
                          ? Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: downloadImage(tache.photoId))
                          : const SizedBox(), */

                      (tache.photoId != 0)
                      ? Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/tenor.gif',)
                          )
                        ),
                        child: Image.network(
                          ImageUrl(tache.photoId),
                          height: 80, width: 80, fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
                            if(loadingProgress == null){
                              return child;
                            }
                            return Center(
                                child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                            ));
                          }
                        ),
                      ) : const SizedBox()
                    ],
                  ), ),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ConsultationTache(id: tache.id.toString(), username: username)),
                    );
                  },
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
        tooltip: 'Increment',
        onPressed: (){
          Navigator.pushNamed(context, '/creationtache', arguments: username);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  void setStateLoadingList(bool _isLoadingList){
    setState(() {
      is_LoadingList = _isLoadingList;
    });
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

