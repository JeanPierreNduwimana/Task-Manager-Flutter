import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer.g.dart';

@JsonSerializable()
class SignUpRequest {

  SignUpRequest();

  String username = '';
  String password = '';

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => _$SignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}

@JsonSerializable()
class SignUpResponse {

  SignUpResponse();

  String username = '';

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => _$SignUpResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}

@JsonSerializable()
class SignInRequest {

  SignInRequest();

  String username = '';
  String password = '';

  factory SignInRequest.fromJson(Map<String, dynamic> json) => _$SignInRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}

@JsonSerializable()
class SignInResponse {

  SignInResponse();

  String username = '';

  factory SignInResponse.fromJson(Map<String, dynamic> json) => _$SignInResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}

@JsonSerializable()
class HomeItemPhotoResponse {
  HomeItemPhotoResponse();

  String id = '';
  String photoUrl = '';
  String name = '';
  int percentageDone = 0;
  int percentageTimeSpent = 0;
  String deadline = '';
  String dateCreation = '';
  bool isDeleted = false;

  factory HomeItemPhotoResponse.fromJson(Map<String, dynamic> json) => _$HomeItemPhotoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HomeItemPhotoResponseToJson(this);
}

@JsonSerializable()
class AddTaskRequest {
  AddTaskRequest();

  int id = 0;
  String name = '';
  int percentageDone = 0;
  int percentageTimeSpent = 0;
  String deadline = '';
  String dateCreation = '';
  bool isDeleted = false;

  factory AddTaskRequest.fromJson(Map<String, dynamic> json) => _$AddTaskRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);
}

@JsonSerializable()
class TaskDetailPhotoResponse {
  TaskDetailPhotoResponse();

  String id = '';
  String photoUrl = '';
  String imageName = '';
  String name = '';
  int percentageDone = 0;
  int percentageTimeSpent = 0;
  String deadline = '';
  String dateCreation = '';

  factory TaskDetailPhotoResponse.fromJson(Map<String, dynamic> json) => _$TaskDetailPhotoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDetailPhotoResponseToJson(this);
}