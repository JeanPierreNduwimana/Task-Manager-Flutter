import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'lib_http.dart';


  String ImageUrl(int id) {
    // return Image.network('${api}file/$id',height: 80, width: 80, fit: BoxFit.cover,);
    return '${api}file/$id';
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> afficherMessage(String message, BuildContext context, int duration){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: duration),),
    );
  }

  void erreurServeur(String typeDerreur, BuildContext context){

    int delaiDaffichage = 3;

    switch(typeDerreur)
    {
      case "InternalAuthenticationServiceException":
        afficherMessage('Utilisateur inexistant veuillez vous inscrire 🙅‍♀️ \nErreur: $typeDerreur', context, delaiDaffichage);
        break;
      case "BadCredentialsException":
        afficherMessage('Mot de passe invalide. Essayer de nouveau 🍀 \nErreur: $typeDerreur', context, delaiDaffichage);
        break;
      case "UsernameAlreadyTaken":
        afficherMessage('Utilisateur existe deja 🙅‍ \nErreur: $typeDerreur', context, delaiDaffichage);
        break;
      case "UsernameTooShort":
        afficherMessage('Le nom choisi est trop court 🤏 \nErreur: $typeDerreur', context, delaiDaffichage);
        break;
      case "PasswordTooShort":
        afficherMessage('Votre mot de passe est trop court 🤏 \nErreur: $typeDerreur', context, delaiDaffichage);
        break;
      case "Empty":
        afficherMessage('Nom de la tâche est vide 🤷‍♂️ \nErreur: $typeDerreur', context, delaiDaffichage);
        break;
      case "Existing":
        afficherMessage('Nom de la tâche  existe déjà️ 🙅‍ \nErreur: $typeDerreur', context, delaiDaffichage);
        break;
      case "TooShort":
        afficherMessage('Nom de la tâche  est trop court️ 🙅‍ \nErreur: $typeDerreur', context, delaiDaffichage);
        break;
      case "NoSuchElementException":
      //Aucune idéé ce que ca fait
        break;
      case "UnkownError":
        afficherMessage('Erreur inconnu 🤔', context, delaiDaffichage);
        break;
      case "connectionError":
        afficherMessage('Désolé il n\'y a pas de connection 😣 \n Veuillez vérifiez votre réseau', context, delaiDaffichage);
      default:
        break;
    }
  }

  String formattageDate( String isoDate){

    if(isoDate == ''){
      return '';
    }
    // Convertir la chaîne en objet DateTime
    DateTime dateTime = DateTime.parse(isoDate);
    // Formater la date en 'YYYY-MM-DD'
    String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    // retourne la date formatée
    return formattedDate;
  }