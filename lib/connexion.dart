import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/transfer.dart';


class Connexion extends StatelessWidget {
  const Connexion({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final TextEditingController username_controller = TextEditingController();
    final TextEditingController password_controller = TextEditingController();
    return Scaffold(

      appBar: AppBar(
        title: const Text('Connexion'),
        backgroundColor: Colors.deepPurple,
      ),

      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              children: [
                const Text('Connexion'),
                TextField(
                  controller: username_controller,
                  keyboardType: TextInputType.name,
                  maxLength: 16,
                  decoration: const InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.black38)
                  ),
                ),
                TextField(
                  controller: password_controller,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.black38)
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: const Text('Inscription'),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/inscription');                  },
                    ),
                    ElevatedButton(
                      child: const Text('Connexion'),
                      onPressed: () async {
                        connexion(username_controller.text, password_controller.text, context); //HTTP REQUEST
                      },
                    )
                  ],
                )

              ],
            ),
          )
      ),
    );
  }

  void connexion(String username, String password, BuildContext context) async{
    SignInRequest req = SignInRequest();
    req.username = username;
    req.password = password;

    if(username == "" || password == ""){
      afficherMessage("Aucun des champs ne peut être vide ☹", context, 2);
    }else {
      var response;
      try{
        response =  await signin(req);
      }catch(e){
        if(e is DioException){
          if(e.response?.data != null){
            erreurServeur(e.response!.data.toString(), context);
          }
        }else{
          erreurServeur("UnkownError", context);
        }
      }finally{
        String name = response.username;
        Navigator.pushReplacementNamed(context, '/accueil', arguments: name);
        afficherMessage('Bienvenue ${response.username} 🎉', context, 8);
      }
    }
  }



}