import 'package:flutter/material.dart';
import 'package:tp1_flutter/transfer.dart';

import 'lib_http.dart';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Inscription'),
        backgroundColor: Colors.deepPurple,
      ),

      body: Center(

          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Column(
                children: [
                  const Text('inscription'),
                  TextField(
                    controller: username_controller,
                    keyboardType: TextInputType.name,
                    maxLength: 16,
                    decoration: const InputDecoration(
                        hintText: 'username',
                        hintStyle: TextStyle(color: Colors.black38)
                    ),
                  ),
                  TextFormField(
                    controller: password_controller,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                        hintText: 'password',
                        hintStyle: TextStyle(color: Colors.black38)
                    ),
                    validator: (value) {
                      if (passwordError) {
                        return 'Mauvais!!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: confirm_password_controller,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                        hintText: 'confirm your password',
                        hintStyle: TextStyle(color: Colors.black38)
                    ),
                    validator: (value) {
                      if (passwordError) {
                        return 'Mauvais!!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: const Text('Connexion'),
                        onPressed: () async{
                          Navigator.pushNamed(context, '/connexion');
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Inscription'),
                        onPressed: () {
                          //Navigator.pushNamed(context, '/connexion');
                          inscription(username_controller.text, password_controller.text, confirm_password_controller.text, context); //HTTP REQUEST

                        },
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

  void inscription(String username, String password,String confirmpassword, BuildContext context) async{
    SignUpRequest req = SignUpRequest();
    req.username = username;
    req.password = password;



    if(req.password != confirmpassword){

      passwordError = true;

      _formKey.currentState!.validate();

      setState(() {

      });
    } else {
      var response = await signup(req);

      String name = response.username;
      Navigator.pushNamed(context, '/accueil', arguments: response.username);
     /* ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('username: $name'))); */
    }


  }
}