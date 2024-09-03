import 'package:dio/dio.dart';
import 'package:tp1_flutter/transfer.dart';

Future<SignUpResponse> signup(SignUpRequest req) async {
  try {
    var response = await Dio().post('http://192.168.221.1:8080/api/id/signup', data: req.toJson());
    print(response);
    return SignUpResponse.fromJson(response.data);
  } catch(e) {
    print(e);
    throw(e);
  }
}