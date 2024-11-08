import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/transfer.dart';
import 'app_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';


final TextEditingController username_controller = TextEditingController();
final TextEditingController password_controller = TextEditingController();
bool is_Enabled = true;
bool is_loading = false;

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
    S.load(const Locale('en'));
    fastConnexion();
    is_Enabled = true;
    is_loading = false;
  }

  @override
  Widget build(BuildContext context) {

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

      home: Scaffold(
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
                Text(S.of(context)!.connection),
                TextField(
                  controller: username_controller,
                  keyboardType: TextInputType.name,
                  maxLength: 16,
                  decoration:  InputDecoration(
                      hintText: S.of(context)!.username,
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
                        child: Text(S.of(context)!.inscription),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/inscription'); },
                      ),
                    ),
                    const SizedBox(width: 40,),
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
                    )
                  ],
                )

              ],
            ),
          )
      ),
    )
    );
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
        Navigator.pushReplacementNamed(context, '/accueil', arguments: name);
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
        Navigator.pushReplacementNamed(context, '/accueil', arguments: name);
        afficherMessage('${S.of(context)!.welcome} ${response.username} 🎉', context, 3);
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