import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp1_flutter/app_service.dart';
import 'accueil.dart';
import 'tiroir_nav.dart';
import 'transfer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:intl/intl.dart';


FirebaseFirestore _db = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;


class CreationTache extends StatefulWidget {
  final String username;
  final List<HomeItemPhotoResponse> taches;
  const CreationTache({super.key, required this.username, required this.taches});
  @override
  State<CreationTache> createState() => _CreationTacheState();
}
bool errorannee = false;
bool errormois = false;
bool errorjour = false;
bool errornom = false;

class _CreationTacheState extends State<CreationTache> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController tache_nom_controller = TextEditingController();
  final TextEditingController annee_controller = TextEditingController();
  final TextEditingController mois_controller = TextEditingController();
  final TextEditingController jour_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).createTask),
          backgroundColor: Colors.deepPurple,
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(S.of(context).createTask, style: TextStyle(fontSize: 24)),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: tache_nom_controller,
                        keyboardType: TextInputType.name,
                        maxLength: 16,
                        decoration: InputDecoration(
                            hintText: S.of(context).taskName,
                            hintStyle: TextStyle(color: Colors.black38)
                        ),
                        validator: (value) {
                          if (errornom) {
                            return S.of(context).emptyfields;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: annee_controller,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  hintText: '0000',
                                  hintStyle: TextStyle(color: Colors.black38)
                              ),

                              validator: (value) {
                                if (errorannee) {
                                  return 'Erreur';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Expanded(
                            child: Text('-', textAlign: TextAlign.center,),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: mois_controller,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  hintText: '00',
                                  hintStyle: TextStyle(color: Colors.black38)
                              ),
                              validator: (value) {
                                if (errormois) {
                                  return 'Erreur';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Expanded(
                            child: Text('-', textAlign: TextAlign.center,),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: jour_controller,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  hintText: '00',
                                  hintStyle: TextStyle(color: Colors.black38)
                              ),
                              validator: (value) {
                                if (errorjour) {
                                  return 'Erreur';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(onPressed: (){
                        CreerTache(tache_nom_controller.text, annee_controller.text, mois_controller.text, jour_controller.text, this.widget.username);
                      }, child: Text(S.of(context).createTask))


                    ],
                  )
              ),

            ),
          ),
        ),
        drawer: LeTiroir(username: this.widget.username,),
        floatingActionButton: FloatingActionButton(
          //backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
          tooltip: 'Increment',
          onPressed: (){
           // Navigator.pushNamed(context, '/accueil', arguments: username);
            Navigator.push(context,MaterialPageRoute(builder: (context) => Accueil( username: widget.username)));
          },
          child: const Icon(Icons.home, color: Colors.white, size: 28),
        ),
      );

  }

  void CreerTache(String name, String annee, String mois, String jour, String username) async{


      if(ErreurChamps(name, annee, mois, jour)){
        afficherMessage(S.of(context).emptyfields, context, 3);
        _formKey.currentState!.validate();
      } else {
        String date = '$annee-$mois-$jour';
        User? user = _auth.currentUser;
        CollectionReference tasks = _db.collection('users').doc(user?.uid).collection('Tasks');

        await tasks.add({
          'dateCreation' : DateFormat('yyyy-MM-dd').format(DateTime.now()),
          'deadline' : date,
          'imageName' : '',
          'name' : name,
          'percentageDone' : 0,
          'percentageTimeSpent' : 0,
          'photoUrl' : '',
          'isDeleted' : false,
          'userId' : user?.uid
        });

        Navigator.push(context,MaterialPageRoute(builder: (context) => Accueil(username: username)));
      }

  }

  bool ErreurChamps(String name, String annee, String mois, String jour){
    errorannee = false; errormois = false; errorjour = false; errornom = false;
    String date = '$annee-$mois-$jour';
    DateTime inputDate = DateTime.parse(date);
    DateTime today = DateTime.now();
    DateTime todayWithoutTime = DateTime(today.year, today.month, today.day);

    if(annee == ''){
        errorannee = true;
        return true;
      }else if(mois == ''){
        errormois = true;
        return true;
      }else if(jour == ''){
        errorjour = true;
        return true;
      } else if(name.trim() == '') {
        errornom = true;
        return true;
      }else if (inputDate.isBefore(todayWithoutTime)) {
      afficherMessage('date can\'t be in the past', context, 3);
        return true;
    }else if(nomRepetitive(name.trim())){
      return true;
    }else{
      return false;
    }



    return false;
  }

  bool nomRepetitive(String name){
    bool reponse = false;
    widget.taches.forEach((var t){
      if(t.name == name){
        afficherMessage("The name of the task exist already", context, 3);
        reponse = true;
      }
    });

    return reponse;
  }

}
