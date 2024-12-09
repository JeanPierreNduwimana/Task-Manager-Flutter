import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'generated/l10n.dart';
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
        afficherMessage('${S.of(context).InternalAuthenticationServiceException} 🙅‍♀️', context, delaiDaffichage);
        break;
      case "BadCredentialsException":
        afficherMessage('${S.of(context).BadCredentialsException} 🍀', context, delaiDaffichage);
        break;
      case "UsernameAlreadyTaken":
        afficherMessage('${S.of(context).UsernameAlreadyTaken} 🙅‍ ', context, delaiDaffichage);
        break;
      case "UsernameTooShort":
        afficherMessage('${S.of(context).UsernameTooShort} 🤏', context, delaiDaffichage);
        break;
      case "PasswordTooShort":
        afficherMessage('${S.of(context).PasswordTooShort} 🤏', context, delaiDaffichage);
        break;
      case "Empty":
        afficherMessage('${S.of(context).Empty} 🤷‍♂️', context, delaiDaffichage);
        break;
      case "Existing":
        afficherMessage('${S.of(context).Existing} 🙅‍', context, delaiDaffichage);
        break;
      case "TooShort":
        afficherMessage('${S.of(context).TooShort} 🙅‍', context, delaiDaffichage);
        break;
      case "NoSuchElementException":
      //Aucune idéé ce que ca fait
        break;
      case "UnkownError":
        afficherMessage('${S.of(context).UnkownError} 🤔', context, delaiDaffichage);
        break;
      case "connectionError":
        afficherMessage(S.of(context).connectionError, context, delaiDaffichage);
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