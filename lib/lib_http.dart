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
String api = 'http://10.10.45.16:8080/';

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
