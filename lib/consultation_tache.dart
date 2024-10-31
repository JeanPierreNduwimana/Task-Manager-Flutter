import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp1_flutter/tiroir_nav.dart';
import 'package:tp1_flutter/transfer.dart';

import 'lib_http.dart';


class ConsultationTache extends StatefulWidget {

  final String id;
  final String username;
  const ConsultationTache ({super.key, required this.id, required this.username});

  @override
  State<ConsultationTache> createState() => _ConsultationState();
}

class _ConsultationState extends State<ConsultationTache> {
  TaskDetailPhotoResponse tache = new TaskDetailPhotoResponse();
  double _sliderValue = 0;
  String imagePath = "";
  XFile? pickedImage;
  Image image = new Image.asset(
    'assets/images/add_photo.png',
    semanticLabel:  'Image de la tache');

  void getImage() async{

    ImagePicker picker = ImagePicker();
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    imagePath = pickedImage!.path;

    if(imagePath != ""){
      image = Image.file(File(imagePath),fit: BoxFit.cover,);
    }
    setState(() {});
  }

  Future<void> sendImage(String imagePath, int taskId) async{
    FormData formData = FormData.fromMap({
      "file" : await MultipartFile.fromFile(imagePath, filename: pickedImage!.name),
      "taskID": taskId
    });
    await uploadImage(formData);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DetailsTache(this.widget.id);
  }

  Future<TaskDetailPhotoResponse> DetailsTache(String id) async{

    tache = await getdetailsTache(id);
    if(tache.photoId != 0) {
      image = downloadImage(tache.photoId);
    }
    _sliderValue = double.parse(tache.percentageDone.toString());
    setState(() {});
    return tache;
  }

  Future<void> MiseAJourProgression(String id,String valeur) async {
     var response = await updateProgress(id, valeur);
     if(response == '200'){
       DetailsTache(id);
     }

  }

  Widget buildBody(){
    return Center (
        child: Column(
          children: [

            const SizedBox(height: 30,),
            SizedBox(
              child: Column(
                children: [
                  Text(tache.name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),),
                  Text( formattageDate(tache.deadline)),
                ],
              ),
            ),
            const SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 16.0),
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black38, // Border color
                      width: 1.0,// Border width
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child:  Expanded(
                    child: Column(
                      children: [
                        Text('${tache.percentageTimeSpent} %',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        Text('Temps utilisé'),
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox(),),
                Container(
                  margin: EdgeInsets.only(right: 16.0),
                  padding: EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black38, // Border color
                      width: 1.0,// Border width
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Expanded(
                    child: Column(
                      children: [
                        Text('${tache.percentageDone} %',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        const Text('Progression'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                getImage();
              },
              child:  Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  border: Border.all(
                    color: Colors.black12, // Border color
                    width: 1.0,// Border width
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: image,
              ),
            ),
            const SizedBox(height: 40,),
            Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                divisions: 5,
                label: _sliderValue.round().toString(),
                onChanged: (double num){
                  setState(() {
                    _sliderValue = num;
                  });

                }),
            const SizedBox(height: 40,),
            ElevatedButton(onPressed:() async {btnMiseAJour();}, child: const Text('Mettre à jour ma progression')),
            ElevatedButton( onPressed:() async{btnSupprimer();}, child: const Text('Supprimer')),
          ],
        ),
      );
  }

  void btnMiseAJour() async {
    try{
      if(imagePath != ""){
        try{
          await sendImage(imagePath, tache.id);} catch(e){
          afficherMessage("Le serveur n'a pas aimé cette image, essayer avec une autre et ca marchera, promis 😉", context,10);
        }
        await MiseAJourProgression(tache.id.toString(), _sliderValue.round().toString());
      }else{
        MiseAJourProgression(tache.id.toString(), _sliderValue.round().toString());
      }
    }finally{
      afficherMessage("La tache est mise à jour 👌", context,5);
    }
  }

  void btnSupprimer() async {
    try{
      await removeTask(tache);
    }finally {
      Navigator.pushNamed(context, '/accueil', arguments: this.widget.username);
      afficherMessage("La tache ${tache.name} est supprimé 🔪", context,5);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultation Tache'),
        backgroundColor: Colors.deepPurple,
      ),
      body: buildBody(),
      drawer: LeTiroir(username: this.widget.username),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: (){
          Navigator.pushNamed(context, '/accueil', arguments: this.widget.username);
        },
        child: const Icon(Icons.home, color: Colors.white, size: 28),
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





