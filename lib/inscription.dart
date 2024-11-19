import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'accueil.dart';
import 'connexion.dart';
import 'transfer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'app_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'lib_http.dart';

class InscriptionPageLess extends StatelessWidget {

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

      home: InscriptionPage(),
    );
  }

}

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {

  final TextEditingController username_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();
  final TextEditingController confirm_password_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool is_Enabled = true;
  bool is_loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    is_Enabled = true;
    is_loading = false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).inscription),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(

            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: Column(
                  children: [
                    Text(S.of(context).inscription),
                    TextField(
                      controller: username_controller,
                      keyboardType: TextInputType.name,
                      maxLength: 16,
                      decoration: InputDecoration(
                          hintText: S.of(context).username,
                          hintStyle: TextStyle(color: Colors.black38)
                      ),
                    ),
                    TextFormField(
                      controller: password_controller,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: S.of(context).password,
                          hintStyle: const TextStyle(color: Colors.black38)
                      ),
                      validator: (value) {
                        if (passwordError) {return S.of(context).SamePassword;}
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: confirm_password_controller,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: S.of(context).confirmpassword,
                          hintStyle: const TextStyle(color: Colors.black38)
                      ),
                      validator: (value) {
                        if (passwordError) {return 'Mot de passe non-identiques';}
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            child: Text(S.of(context).connection),
                            onPressed: () async {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const Connexion())
                              );},
                          ),
                        ),
                        const SizedBox(width: 40,),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () async {
                              if(is_Enabled){
                                FocusScope.of(context).unfocus();
                                inscription(username_controller.text, password_controller.text); //HTTP REQUEST
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: is_Enabled? 2 : 0,
                            ),
                            child: is_loading
                                ? const SizedBox(
                              height: 20, width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                                : Text(S.of(context).inscription),
                          ),
                        )
                      ],
                    )

                  ],
                ),
              ),
            )
        ),
      );
  }

  bool passwordError = false;
/*
  void inscription(String username, String password,String confirmpassword, BuildContext context) async {
    setState_button(false,true);
    SignUpRequest req = SignUpRequest();
    req.username = username;
    req.password = password;
    if (!validation(username, password, confirmpassword)) {

      var response;
      try{
        response = await signup(req);
      }catch(e){
        if(e is DioException){
          if(e.response?.data != null){
            erreurServeur(e.response!.data.toString(), context);
            Future.delayed(const Duration(seconds: 3), (){
              setState_button(true,false);});
          }
          if(e.type == DioExceptionType.connectionError){
            erreurServeur("connectionError", context);
            Future.delayed(const Duration(seconds: 2), (){
                setState_button(true,false);;});
          }
        }else{
          erreurServeur("UnkownError", context);
        }
      }finally{
        Navigator.push(context,MaterialPageRoute(builder: (context) => AccueilPage(username: response.username)));
        afficherMessage('${S.of(context).welcome} ${response.username} 🎉', context, 3);
      }
    }else{
      Future.delayed(const Duration(seconds: 2), (){
      setState_button(true,false);});
    }
  }
*/

  Future<void> inscription(String username, String password) async {
    String email = username + '@tp1flutter.com';

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance.collection('users').doc(
          userCredential.user!.uid).set({
        'username': username,
        'email': email,
      });
    } catch (e) {
      print('Erreur d\'inscription: $e');
    }
  }

  bool validation(String username, String password,String confirmpassword){
    passwordError = false;
    _formKey.currentState!.validate();
    setState(() {});

    if(username == "" || password == "" || confirmpassword == ""){
      afficherMessage(S.of(context).emptyfields, context, 3);
      return true;
    }

    if(password != confirmpassword){
      passwordError = true;
      _formKey.currentState!.validate();
      setState(() {});
      afficherMessage(S.of(context).SamePassword, context, 3);
      return true;
    }
    return false;
  }

  void setState_button(bool _is_Enabled, bool _is_Loading){

    setState(() {
      is_Enabled = _is_Enabled;
      is_loading = _is_Loading;
    });
  }
}