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
                ElevatedButton(
                  child: const Text('Accueil'),
                  onPressed: () async {
                    //Navigator.pushNamed(context, '/accueil');
                    /*try {
                      var response = await Dio().get('http://localhost:8080/api/id/signup');
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('La response est: $response')));
                      print( 'La response est: $response');

                      //User user = new User();

                    } catch(e) {
                      print(e);
                    }*/

                    SignUpRequest req = SignUpRequest();
                    req.username = username_controller.text;
                    req.password = password_controller.text;

                    var response = await signup(req);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('La response est: $response')));
                    print( 'La response est: $response');
                    },
                )
              ],
            ),
          )
      ),
    );
  }


}