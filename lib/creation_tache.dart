import 'package:flutter/material.dart';
import 'package:tp1_flutter/app_service.dart';
import 'accueil.dart';
import 'tiroir_nav.dart';
import 'transfer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'lib_http.dart';


class CreationTachePage extends StatelessWidget {
  final String username;
  const CreationTachePage({super.key, required this.username});
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
      home: CreationTache(username: username),
    );
  }
}

class CreationTache extends StatefulWidget {
  final String username;
  const CreationTache({super.key, required this.username});
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
    //final String username = ModalRoute.of(context)!.settings.arguments as String;
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
            Navigator.push(context,MaterialPageRoute(builder: (context) => AccueilPage( username: widget.username)));
          },
          child: const Icon(Icons.home, color: Colors.white, size: 28),
        ),
      );

  }

  void CreerTache(String name, String annee, String mois, String jour, String username) async{

      if(ErreurChamps(name, annee, mois, jour)){
        afficherMessage(S.of(context).emptyfields, context, 3);
        _formKey.currentState!.validate();
      }else {

        String date = '$annee-$mois-$jour';
        AddTaskRequest req = new AddTaskRequest();

        req.name = name;
        req.deadline = date;

        await AddTask(req);
       // Navigator.pushNamed(context, '/accueil', arguments: username);
        Navigator.push(context,MaterialPageRoute(builder: (context) => AccueilPage(username: username)));
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
