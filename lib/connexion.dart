import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp1_flutter/accueil.dart';
import 'package:tp1_flutter/inscription.dart';
import 'transfer.dart';
import 'app_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'lib_http.dart';


final TextEditingController username_controller = TextEditingController();
final TextEditingController password_controller = TextEditingController();
bool is_EnabledEmailConnection = true;
bool is_Enabled_GoogleConnexion = true;
bool is_loadingEmailConnexion = false;
bool is_loading_GoogleConnexion = false;

FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _googleSignIn = GoogleSignIn();

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  bool fastConnexionActive = false;
  String title = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    fastConnexion();
    is_EnabledEmailConnection = true;
    is_loadingEmailConnexion = false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).connection),
          backgroundColor: Colors.deepPurple,
        ),
      body: fastConnexionActive
      ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/vipredirect.gif'),
            const SizedBox(height: 4,),
            Text(S.of(context)!.vipredirect, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
          ],
        ),
      )
      : Center(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              children: [
                Text(S.of(context).connection),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: username_controller,
                        keyboardType: TextInputType.name,
                        maxLength: 16,
                        decoration:  InputDecoration(
                            hintText: S.of(context).username,
                            hintStyle: TextStyle(color: Colors.black38)
                        ),
                      ), 
                    ),
                    Expanded(child: Container(
                        //padding: EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 20, left: 8),
                        child: const Text('@tp3flutter.com', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)))
                  ],
                ),
                TextField(
                  controller: password_controller,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: S.of(context)!.password,
                      hintStyle: TextStyle(color: Colors.black38)
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        child: Text(S.of(context).inscription),
                        onPressed: () async {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (
                                  context) => const InscriptionPage())
                          );
                        }
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(is_EnabledEmailConnection){
                            FocusScope.of(context).unfocus();
                            //connexion(username_controller.text, password_controller.text, context); //HTTP REQUEST
                            firebaseconnexion(username_controller.text, password_controller.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: is_EnabledEmailConnection? 2 : 0,
                        ),

                        child: is_loadingEmailConnexion
                            ? const SizedBox(
                          height: 20, width: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                            )
                            :  Text(S.of(context)!.connection),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(is_Enabled_GoogleConnexion){
                            FocusScope.of(context).unfocus();
                            await signinWithGoogle();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: is_Enabled_GoogleConnexion? 2 : 0,
                        ),
                        child: is_loading_GoogleConnexion
                            ? const SizedBox(
                          height: 20, width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                            :  Text('Google'),
                      ),
                    ),

                  ],
                )

              ],
            ),
          )
      ),
    );
  }

  Future<void> signinWithGoogle() async {
    setState_EnablingButton(false);
    setState_LoadingButton(false, true);
    try{
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if(googleUser == null){
        return null;
      }
      //Details de l'authentification du compte Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential for Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase using the Google credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);


      Navigator.push(context,MaterialPageRoute(builder: (context) => Accueil(username: userCredential.user?.email ?? "no Email" )));
      setState_EnablingButton(true);
      setState_LoadingButton(false, false);
    }catch(e){
      print("Error during Google sign-in: $e");
      return null;
    }
  }


  void connexion(String username, String password, BuildContext context) async{
    setState_EnablingButton(false);
    setState_LoadingButton(true, false);
    SignInRequest req = SignInRequest();
    req.username = username;
    req.password = password;

    if(username == "" || password == ""){
      afficherMessage(S.of(context)!.emptyfields, context, 3);
      Future.delayed(const Duration(seconds: 2), (){
        setState(() {
          setState_EnablingButton(true);// Re-enable the button after 2 seconds
          setState_LoadingButton(false, false);
        });});
    }else {
      var response;
      try{
        response =  await signin(req);
      }catch(e){
        if(e is DioException){
          if(e.response?.data != null){
            erreurServeur(e.response!.data.toString(), context);
            Future.delayed(const Duration(seconds: 3), (){
            setState_EnablingButton(true);
            setState_LoadingButton(false,false);});
          }
          if(e.type == DioExceptionType.connectionError){
            erreurServeur("connectionError", context);
            Future.delayed(const Duration(seconds: 2), (){
              setState_EnablingButton(true);
              setState_LoadingButton(false,false);});
          }
        }
        else{
          erreurServeur("UnkownError", context);
          Future.delayed(const Duration(seconds: 2), (){
            setState(() {
              setState_EnablingButton(true); // Re-enable the button after 2 seconds
              setState_LoadingButton(false,false);
            });});
        }
      }finally{
        String name = response.username;
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('username', response.username);
        prefs.setString('password', password);
       // Navigator.pushReplacementNamed(context, '/accueil', arguments: name);
        Navigator.push(context,MaterialPageRoute(builder: (context) => Accueil(username: username)));
        afficherMessage('Bienvenue ${response.username} 🎉', context, 3);
      }
    }
  }

  Future<void> firebaseconnexion(String username, String loginPassword) async {

    setState_EnablingButton(false);
    setState_LoadingButton(true, false);

    if(username == "" || loginPassword == ""){
      afficherMessage(S.of(context)!.emptyfields, context, 3);
      Future.delayed(const Duration(seconds: 2), (){
        setState(() {
          setState_EnablingButton(true);// Re-enable the button after 2 seconds
          setState_LoadingButton(false, false);
        });});
    }else{
      String loginEmail = username + "@tp3flutter.com";
      try{
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: loginEmail,
          password: loginPassword,
        );
        Navigator.push(context,MaterialPageRoute(builder: (context) => Accueil(username: userCredential.user?.email ?? "no Email" )));
      } on FirebaseAuthException catch (e){
        if(e.code == "invalid-credential"){
          erreurServeur("InternalAuthenticationServiceException", context);
          Future.delayed(const Duration(seconds: 2), (){
            setState(() {
              setState_EnablingButton(true);// Re-enable the button after 2 seconds
              setState_LoadingButton(false, false);
            });});
        }else if(e.code == "network-request-failed"){
          erreurServeur("connectionError", context);
          Future.delayed(const Duration(seconds: 2), (){
            setState(() {
              setState_EnablingButton(true);// Re-enable the button after 2 seconds
              setState_LoadingButton(false, false);
            });});
        }else{
          afficherMessage("Error during signup", context, 2);
          Future.delayed(const Duration(seconds: 2), (){
            setState(() {
              setState_EnablingButton(true);// Re-enable the button after 2 seconds
              setState_LoadingButton(false, false);
            });});
        }
      }finally{
        setState_EnablingButton(true);
        setState_LoadingButton(false,false);
      }
    }



  }

  void fastConnexion() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    if (username != null && password != null) {
      setState(() {
        fastConnexionActive = true;
      });

      SignInRequest req = SignInRequest();
      req.username = username;
      req.password = password;
      var response = await signin(req);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('username', response.username);
      prefs.setString('password', password);
      String name = response.username;
      fastConnexionActive = false;
      Future.delayed(const Duration(seconds: 4), (){
       // Navigator.pushReplacementNamed(context, '/accueil', arguments: name);
        Navigator.push(context,MaterialPageRoute(builder: (context) => Accueil(username: username)));
        afficherMessage('${S.of(context).welcome} ${response.username} 🎉', context, 3);
        });
    }
  }

  void setState_EnablingButton(bool _is_Enabled){
    setState(() {
      is_EnabledEmailConnection = _is_Enabled;
      is_Enabled_GoogleConnexion = _is_Enabled;
    });
  }

  void setState_LoadingButton(bool _emailConnexion, bool _googleConnexoin ){
    setState(() {
      is_loadingEmailConnexion = _emailConnexion;
      is_loading_GoogleConnexion = _googleConnexoin;
    });
  }



}