import 'package:flutter/material.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/tiroir_nav.dart';
import 'package:tp1_flutter/transfer.dart';


class CreationTache extends StatefulWidget {
  const CreationTache({super.key});


  @override
  State<CreationTache> createState() => _CreationTacheState();
}

final _formKey = GlobalKey<FormState>();
final TextEditingController tache_nom_controller = TextEditingController();
final TextEditingController annee_controller = TextEditingController();
final TextEditingController mois_controller = TextEditingController();
final TextEditingController jour_controller = TextEditingController();


bool errorannee = false;
bool errormois = false;
bool errorjour = false;
bool errornom = false;

class _CreationTacheState extends State<CreationTache> {


  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creation de tâches'),
        backgroundColor: Colors.deepPurple,
      ),

      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Create your task', style: TextStyle(fontSize: 24)),
                SizedBox(height: 16),
                TextFormField(
                controller: tache_nom_controller,
                keyboardType: TextInputType.name,
                maxLength: 16,
                decoration: const InputDecoration(
                    hintText: 'Task name',
                    hintStyle: TextStyle(color: Colors.black38)
                ),
                  validator: (value) {
                    if (errornom) {
                      return 'champs vide';
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
                          hintText: 'Year',
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
                          hintText: 'Month',
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
                          hintText: 'Day',
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
                  CreerTache(tache_nom_controller.text, annee_controller.text, mois_controller.text, jour_controller.text, username);
                }, child: const Text('Create Task'))


              ],
            )
          ),

        ),
      ),
      drawer: LeTiroir(username: username,),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: (){
          Navigator.pushNamed(context, '/accueil', arguments: username);
        },
        child: const Icon(Icons.home, color: Colors.white, size: 28),
      ),
    );
  }

  void CreerTache(String name, String annee, String mois, String jour, String username) async{

      if(ErreurChamps(name, annee, mois, jour)){
        _formKey.currentState!.validate();
      }else {

        String date = '$annee-$mois-$jour';
        AddTaskRequest req = new AddTaskRequest();

        req.name = name;
        req.deadline = date;

        await AddTask(req);
        Navigator.pushNamed(
            context, '/acceuil', arguments: username
        );
      }

  }

  bool ErreurChamps(String name, String annee, String mois, String jour){
    errorannee = false; errormois = false; errorjour = false; errornom = false;
    if(annee == ''){
        errorannee = true;
        return true;
      }else if(mois == ''){
        errormois = true;
        return true;
      }else if(jour == ''){
        errorjour = true;
        return true;
      } else if(name == '') {
        errornom = true;
        return true;
      }
      else {
        return false;
      }
  }

}
