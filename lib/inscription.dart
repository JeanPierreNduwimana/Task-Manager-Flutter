import 'package:flutter/material.dart';


class Inscription extends StatelessWidget {
  const Inscription({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final TextEditingController username_controller = TextEditingController();
    final TextEditingController password_controller = TextEditingController();
    final TextEditingController confirm_password_controller = TextEditingController();


    return Scaffold(

      appBar: AppBar(
        title: const Text('Inscription'),
         backgroundColor: Colors.deepPurple,
        ),

      body: Center(

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
              TextField(
                controller: password_controller,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    hintText: 'password',
                    hintStyle: TextStyle(color: Colors.black38)
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: confirm_password_controller,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    hintText: 'confirm your password',
                    hintStyle: TextStyle(color: Colors.black38)
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Connexion'),
                onPressed: () {Navigator.pushNamed(context, '/connexion');},
              )
            ],
          ),
        )
      ),
      );
  }
}