import 'package:dio/dio.dart';
import 'package:tp1_flutter/transfer.dart';

Future<SignUpResponse> signup(SignUpRequest req) async {
  try {
    var response = await Dio().post('http://10.10.39.139:8080/api/id/signup', data: req.toJson());
    print(response);
    return SignUpResponse.fromJson(response.data);
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<SignInResponse> signin(SignInRequest req) async {
  try {
    var response = await Dio().post('http://10.10.39.139:8080/api/id/signin', data: req.toJson());
    print(response);
    return SignInResponse.fromJson(response.data);
  } catch(e) {
    print(e);
    throw(e);
  }
}

Future<void> deconnexion() async {
  try {
    await Dio().post('http://10.10.39.139:8080/api/id/signout');
  } catch(e) {
    print(e);
    throw(e);
  }
}