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
bool is_Enabled = true;
bool is_loading = false;

FirebaseFirestore _db = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _googleSignIn = GoogleSignIn();

class ConnexionPage extends StatelessWidget {
  const ConnexionPage({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // Spanish, no country code
      ],
      home: Connexion(),
    );
  }

}


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
    is_Enabled = true;
    is_loading = false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context)!.connection),
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
                TextField(
                  controller: username_controller,
                  keyboardType: TextInputType.name,
                  maxLength: 16,
                  decoration:  InputDecoration(
                      hintText: S.of(context).username,
                      hintStyle: TextStyle(color: Colors.black38)
                  ),
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
                          if(is_Enabled){
                            FocusScope.of(context).unfocus();
                            connexion(username_controller.text, password_controller.text, context); //HTTP REQUEST
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
                            :  Text(S.of(context)!.connection),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(is_Enabled){
                            FocusScope.of(context).unfocus();
                            User? user = await signinWithGoogle();
                            print(user);
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

  Future<User?> signinWithGoogle() async {
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
      return userCredential.user;
    }catch(e){
      print("Error during Google sign-in: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  void connexion(String username, String password, BuildContext context) async{
    setState_button(false, true);
    SignInRequest req = SignInRequest();
    req.username = username;
    req.password = password;

    if(username == "" || password == ""){
      afficherMessage(S.of(context)!.emptyfields, context, 3);
      Future.delayed(const Duration(seconds: 2), (){
        setState(() {
          setState_button(true, false);  // Re-enable the button after 2 seconds
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
              setState_button(true, false);});
          }
          if(e.type == DioExceptionType.connectionError){
            erreurServeur("connectionError", context);
            Future.delayed(const Duration(seconds: 2), (){
              setState_button(true, false);});
          }
        }
        else{
          erreurServeur("UnkownError", context);
          Future.delayed(const Duration(seconds: 2), (){
            setState(() {
              setState_button(true, false);  // Re-enable the button after 2 seconds
            });});
        }
      }finally{
        String name = response.username;
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('username', response.username);
        prefs.setString('password', password);
       // Navigator.pushReplacementNamed(context, '/accueil', arguments: name);
        Navigator.push(context,MaterialPageRoute(builder: (context) => AccueilPage(username: username)));
        afficherMessage('Bienvenue ${response.username} 🎉', context, 3);
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
        Navigator.push(context,MaterialPageRoute(builder: (context) => AccueilPage(username: username)));
        afficherMessage('${S.of(context).welcome} ${response.username} 🎉', context, 3);
        });
    }
  }

  void setState_button(bool _is_Enabled, bool _is_loading){
    setState(() {
      is_Enabled = _is_Enabled;
      is_loading = _is_loading;
    });
  }



}