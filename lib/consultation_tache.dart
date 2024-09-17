import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ConsultationTache extends StatefulWidget {
  const ConsultationTache ({super.key});


  @override
  State<ConsultationTache> createState() => _State();
}

class _State extends State<ConsultationTache> {
  double _sliderValue = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultation de tâche'),
        backgroundColor: Colors.deepPurple,
      ),

      body: Center (
        child: Column(
          children: [
            const SizedBox(height: 30,),
            const SizedBox(
              child: Column(
                children: [
                  Text(
                      'Nom Tache',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text('date de la tache'),
                ],
              ),
            ),
            const SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  padding: EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black38, // Border color
                      width: 1.0,// Border width
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Expanded(
                    child: Column(
                      children: [
                        Text(
                            '40%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text('Temps utilisé'),
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox(),),
                Container(
                  margin: EdgeInsets.only(right: 16.0),
                  padding: EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black38, // Border color
                      width: 1.0,// Border width
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Expanded(
                    child: Column(
                      children: [
                        Text(
                          '25%',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        Text('Progression'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100,),
            Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                divisions: 5,
                label: _sliderValue.round().toString(),
                onChanged: (double num){
                  setState(() {
                    _sliderValue = num;
                  });

            }),
            const SizedBox(height: 40,),
            ElevatedButton(onPressed:(){},
                child: Text('Mettre à jour ma progression')),
          ],
        ),

      ),
    );
  }
}
