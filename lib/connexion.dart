import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/transfer.dart';


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
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        child: const Text('Inscription'),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/inscription');                  },
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
                            : const Text('Connexion'),
                      ),
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
    setState_button(false, true);
    SignInRequest req = SignInRequest();
    req.username = username;
    req.password = password;

    if(username == "" || password == ""){
      afficherMessage("Aucun des champs ne peut être vide ☹", context, 3);
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
            Future.delayed(const Duration(seconds: 5), (){
              setState(() {
                is_Enabled = true;  // Re-enable the button after 2 seconds
              });});
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
        Navigator.pushReplacementNamed(context, '/accueil', arguments: name);
        afficherMessage('Bienvenue ${response.username} 🎉', context, 3);
      }
    }
  }

  void setState_button(bool _is_Enabled, bool _is_loading){
    setState(() {
      is_Enabled = _is_Enabled;
      is_loading = _is_loading;
    });
  }



}