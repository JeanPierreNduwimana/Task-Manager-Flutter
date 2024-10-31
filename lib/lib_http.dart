import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:tp1_flutter/transfer.dart';
import 'package:cookie_jar/cookie_jar.dart';

class SingletonDio {

  static var cookiemanager = CookieManager(CookieJar());

  static Dio getDio(){
    Dio dio = Dio();
    dio.interceptors.add(cookiemanager);
    return dio;
}
}
String api = 'http://10.10.45.134:8080/';

Future<SignUpResponse> signup(SignUpRequest req) async {
  try {
    var response = await SingletonDio.getDio().post( '${api}api/id/signup', data: req.toJson());
    print(response);
    return SignUpResponse.fromJson(response.data);
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<SignInResponse> signin(SignInRequest req) async {
  try {
    var response = await SingletonDio.getDio().post('${api}api/id/signin', data: req.toJson());
    print(response);
    return SignInResponse.fromJson(response.data);
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<void> AddTask(AddTaskRequest req) async {
  try {
    await SingletonDio.getDio().post('${api}api/add', data: req.toJson());
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<void> removePhoto(int Photoid) async {
    try{
      await SingletonDio.getDio().post('${api}file/delete/${Photoid}');
    }catch(e){

    }
}

Future<void> removeTask(TaskDetailPhotoResponse req) async {
  try {
    await SingletonDio.getDio().post('${api}api/detail/delete/', data: req.toJson());
  } catch(e) {
    print(e);
    throw(e);
  }

}

Future<void> deconnexion() async {
  try {
    await SingletonDio.getDio().post('${api}api/id/signout');
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<List<HomeItemPhotoResponse>> getHomeItemResponse() async {
  try {
    var response = await SingletonDio.getDio().get('${api}api/home/photo');

    var listeJSON = response.data as List;

    var listetaches = listeJSON.map((elementJSON) {
      return HomeItemPhotoResponse.fromJson(elementJSON);
    }).toList();

    return listetaches;

  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<TaskDetailPhotoResponse> getdetailsTache(String id) async {
  try {
     var response = await SingletonDio.getDio().get('${api}api/detail/photo/$id');
     return TaskDetailPhotoResponse.fromJson(response.data);
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<String> updateProgress(String id, String progression) async {
  try {
    await SingletonDio.getDio().get('${api}api/progress/$id/$progression');
    return '200';
  } catch(e) {
    print(e);
    throw(e);
  }
}


Future<void> signout() async {
  try {
    await SingletonDio.getDio().post('${api}api/id/signout');
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<String> uploadImage(FormData formdata) async {
  try {
    var response = await SingletonDio.getDio().post('${api}file', data: formdata);
    return response.data;
  } catch(e) {
    print(e);
    throw(e);
  }
}

Image downloadImage(int id) {
  return Image.network('${api}file/$id',height: 80, width: 80, fit: BoxFit.cover,);
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> afficherMessage(String message, BuildContext context, int duration){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: Duration(seconds: duration),),
  );
}

void erreurServeur(String typeDerreur, BuildContext context){

  switch(typeDerreur)
  {
    case "InternalAuthenticationServiceException":
      afficherMessage('Utilisateur inexistant veuillez vous inscrire 🙅‍♀️ \nErreur: $typeDerreur', context, 5);
      break;
    case "BadCredentialsException":
      afficherMessage('Mot de passe invalide. Essayer de nouveau 🍀 \nErreur: $typeDerreur', context, 5);
      break;
    case "UsernameAlreadyTaken":
      afficherMessage('Utilisateur existe deja 🙅‍ \nErreur: $typeDerreur', context, 5);
      break;
    case "UsernameTooShort":
      afficherMessage('Le nom choisi est trop court 🤏 \nErreur: $typeDerreur', context, 5);
      break;
    case "PasswordTooShort":
      afficherMessage('Votre mot de passe est trop court 🤏 \nErreur: $typeDerreur', context, 5);
      break;
    case "Empty":
      afficherMessage('Nom de la tâche est vide 🤷‍♂️ \nErreur: $typeDerreur', context, 5);
      break;
    case "Existing":
      afficherMessage('Nom de la tâche  existe déjà️ 🙅‍ \nErreur: $typeDerreur', context, 5);
      break;
    case "TooShort":
      afficherMessage('Nom de la tâche  est trop court️ 🙅‍ \nErreur: $typeDerreur', context, 5);
      break;
    case "NoSuchElementException":
    //Aucune idéé ce que ca fait
      break;
    case "UnkownError":
      afficherMessage('Erreur inconnu 🤔', context, 8);
      break;
    default:
      break;
  }
}