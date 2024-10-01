import 'package:dio/dio.dart';
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
 String api = 'http://10.10.45.11:8080/api/';

Future<SignUpResponse> signup(SignUpRequest req) async {
  try {
    var response = await SingletonDio.getDio().post( '${api}id/signup', data: req.toJson());
    print(response);
    return SignUpResponse.fromJson(response.data);
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<SignInResponse> signin(SignInRequest req) async {
  try {
    var response = await SingletonDio.getDio().post('${api}id/signin', data: req.toJson());
    print(response);
    return SignInResponse.fromJson(response.data);
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<void> AddTask(AddTaskRequest req) async {
  try {
    await SingletonDio.getDio().post('${api}add', data: req.toJson());
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<void> deconnexion() async {
  try {
    await SingletonDio.getDio().post('${api}id/signout');
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<List<HomeItemResponse>> getHomeItemResponse() async {
  try {
    var response = await SingletonDio.getDio().get('${api}home');

    var listeJSON = response.data as List;

    var listetaches = listeJSON.map((elementJSON) {
      return HomeItemResponse.fromJson(elementJSON);
    }).toList();

    return listetaches;

  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<TaskDetailResponse> getdetailsTache(String id) async {
  try {
     var response = await SingletonDio.getDio().get('${api}detail/$id');
     return TaskDetailResponse.fromJson(response.data);
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<String> updateProgress(String id, String progression) async {
  try {
    await SingletonDio.getDio().get('${api}progress/$id/$progression');
    return '200';
  } catch(e) {
    print(e);
    throw(e);
  }
}


Future<void> signout() async {
  try {
    await SingletonDio.getDio().post('${api}id/signout');
  } catch(e) {
    print(e);
    throw(e);
  }
}