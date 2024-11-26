import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp1_flutter/accueil.dart';
import 'tiroir_nav.dart';
import 'transfer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_service.dart';
import 'generated/l10n.dart';
import 'lib_http.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
class ConsultationTachePage extends StatelessWidget {

  final String id;
  final String username;
  const ConsultationTachePage ({super.key, required this.id, required this.username});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // Spanish, no country code
      ],
      home: ConsultationTache(id: id,username: username,),
    );
  }
}

class ConsultationTache extends StatefulWidget {

  final String id;
  final String username;
  const ConsultationTache ({super.key, required this.id, required this.username});

  @override
  State<ConsultationTache> createState() => _ConsultationState();
}

class _ConsultationState extends State<ConsultationTache>  with WidgetsBindingObserver{

  TaskDetailPhotoResponse tache = new TaskDetailPhotoResponse();
  double _sliderValue = 0;
  String imagePath = "";
  XFile? pickedImage;
  Image image = Image.asset(
    'assets/images/add_photo.png',
    semanticLabel:  'Image de la tache');
  bool isLoading = false;
  bool localImageAvailable = false;
  bool isuploading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); //Ajout d'un oberver
    DetailsTache(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:  Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).addTask),
          backgroundColor: Colors.deepPurple,
        ),
        body: buildBody(),
        drawer: LeTiroir(username: widget.username),
        floatingActionButton: !isLoading
            ? FloatingActionButton(
              tooltip: 'Increment',
              onPressed: (){
                WidgetsBinding.instance.removeObserver(this); //On arreter l'observer
                //Navigator.pushNamed(context, '/accueil', arguments: widget.username);
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => Accueil(username: widget.username,)));
              },
                child: const Icon(Icons.home, color: Colors.white, size: 28),
              ) : const SizedBox(),
      ),
    );


  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      if(!isuploading){
        DetailsTache(widget.id);
      }
    }
    if(state == AppLifecycleState.paused){
      tache = TaskDetailPhotoResponse();
    }
  }

  void getImage() async{
    isuploading = true;
    ImagePicker picker = ImagePicker();
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    imagePath = pickedImage!.path;

    if(imagePath != ""){
      image = Image.file(File(imagePath),fit: BoxFit.cover,);
      localImageAvailable = true;
    }
    setState(() {});
    isuploading = false;

  }

  Future<TaskDetailPhotoResponse> DetailsTache(String id) async{
    setState(() {
      localImageAvailable = false;
      isLoading = true;
    });

    try{
      DocumentSnapshot taskSnapshot = await userDoc().get();
      if(taskSnapshot.exists){
        var taskData = taskSnapshot.data() as Map<String, dynamic>;
        tache.id = taskSnapshot.id;
        tache.deadline = taskData['deadline'];
        tache.name = taskData['name'];
        tache.percentageDone = taskData['percentageDone'];
        tache.percentageTimeSpent = taskData['percentageTimeSpent'];
        tache.photoUrl = taskData['photoUrl'];
        tache.dateCreation = taskData['dateCreation'];
      }
     // tache = await getdetailsTache(id);
    }finally{
      _sliderValue = double.parse(tache.percentageDone.toString());
      setState(() {
        isLoading = false;
      });
      return tache;
    }


  }

  Future<void> MiseAJourProgression(String? ImageName,String? imageUrl, int valeur) async {

    if(imageUrl != null && ImageName != null){
      await userDoc().update({
        'imageName' : ImageName,
        'photoUrl' : imageUrl,
        'percentageDone' : valeur,
      });

      if(tache.imageName != ''){
        //J'efface l'ancienne photo
        try{
          Reference currentImageRef = FirebaseStorage.instance.ref().child('images/${tache.imageName}');
          await currentImageRef.delete();
        }catch(e){}
      }

    }else{
      await userDoc().update({
        'percentageDone' : valeur,
      });
    }



  }

  DocumentReference userDoc() {
    User? user = _auth.currentUser;
    return _db.collection('users').doc(user?.uid).collection('Tasks').doc(widget.id);
  }

  Widget buildBody(){
    return isLoading
      ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/tenor.gif', height: 80, width: 80,),
            Text(S.of(context).loading),
          ],
        ),
      )
      : SingleChildScrollView(
        child: Center (
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
                        Text(S.of(context).timeUsed),
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
                        Text(S.of(context).progression),
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
                child: (!localImageAvailable && tache.photoUrl != '')
                ? Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/tenor.gif',)
                      )
                  ),
                  child: Image.network(
                      tache.photoUrl,
                      height: 80, width: 80, fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
                        if(loadingProgress == null){
                          return child;
                        }
                        return const SizedBox();
                      }
                  ),
                )
                : image
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
            ElevatedButton(onPressed:() async {btnMiseAJour();}, child: Text(S.of(context).updateProgression)),
            ElevatedButton( onPressed:() async{btnSupprimer();}, child: Text(S.of(context).delete)),
          ],
        ),
            ),
      );
  }

  void btnMiseAJour() async {
    try{
      if(imagePath != ""){
        try{
          //await sendImage(imagePath, 2);
          String ImageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
          var storageReference = FirebaseStorage.instance.ref().child('images/$ImageName');
          late File _image = File(imagePath);
          UploadTask uploadTask = storageReference.putFile(_image);
          TaskSnapshot taskSnapshot = await uploadTask;
          String downloadURL = await taskSnapshot.ref.getDownloadURL();
          await MiseAJourProgression(ImageName,downloadURL,_sliderValue.round());
        } catch(e){
          afficherMessage(S.of(context).errorUploadImage, context,10);
          return;
        }
      }else{
        MiseAJourProgression( null,null,_sliderValue.round());
      }
    }catch(e) {
      afficherMessage(S.of(context).errorUploadImage, context,10);
      return;
    }finally{
      DetailsTache(widget.id); //rechargement de la tâche
    }
    afficherMessage(S.of(context).taskUpdatedMessage, context,3);
  }


  void btnSupprimer() async {
    try{
      await removeTask(tache);
    }finally {
      WidgetsBinding.instance.removeObserver(this); //On arreter l'observer
      //Navigator.pushNamed(context, '/accueil', arguments: this.widget.username);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Accueil(username: widget.username,)));
      afficherMessage(S.of(context).deletedTaskMessage(tache.name), context,3);
    }
  }
}





