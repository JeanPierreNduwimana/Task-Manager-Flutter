// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) =>
    SignUpRequest()
      ..username = json['username'] as String
      ..password = json['password'] as String;

Map<String, dynamic> _$SignUpRequestToJson(SignUpRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    SignUpResponse()..username = json['username'] as String;

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

SignInRequest _$SignInRequestFromJson(Map<String, dynamic> json) =>
    SignInRequest()
      ..username = json['username'] as String
      ..password = json['password'] as String;

Map<String, dynamic> _$SignInRequestToJson(SignInRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse()..username = json['username'] as String;

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

HomeItemPhotoResponse _$HomeItemPhotoResponseFromJson(
        Map<String, dynamic> json) =>
    HomeItemPhotoResponse()
      ..id = json['id'] as String
      ..photoUrl = json['photoUrl'] as String
      ..name = json['name'] as String
      ..percentageDone = (json['percentageDone'] as num).toInt()
      ..percentageTimeSpent = (json['percentageTimeSpent'] as num).toInt()
      ..deadline = json['deadline'] as String
      ..dateCreation = json['dateCreation'] as String
      ..isDeleted = json['isDeleted'] as bool;

Map<String, dynamic> _$HomeItemPhotoResponseToJson(
        HomeItemPhotoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'photoUrl': instance.photoUrl,
      'name': instance.name,
      'percentageDone': instance.percentageDone,
      'percentageTimeSpent': instance.percentageTimeSpent,
      'deadline': instance.deadline,
      'dateCreation': instance.dateCreation,
      'isDeleted': instance.isDeleted,
    };

AddTaskRequest _$AddTaskRequestFromJson(Map<String, dynamic> json) =>
    AddTaskRequest()
      ..id = (json['id'] as num).toInt()
      ..name = json['name'] as String
      ..percentageDone = (json['percentageDone'] as num).toInt()
      ..percentageTimeSpent = (json['percentageTimeSpent'] as num).toInt()
      ..deadline = json['deadline'] as String
      ..dateCreation = json['dateCreation'] as String
      ..isDeleted = json['isDeleted'] as bool;

Map<String, dynamic> _$AddTaskRequestToJson(AddTaskRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'percentageDone': instance.percentageDone,
      'percentageTimeSpent': instance.percentageTimeSpent,
      'deadline': instance.deadline,
      'dateCreation': instance.dateCreation,
      'isDeleted': instance.isDeleted,
    };

TaskDetailPhotoResponse _$TaskDetailPhotoResponseFromJson(
        Map<String, dynamic> json) =>
    TaskDetailPhotoResponse()
      ..id = json['id'] as String
      ..photoUrl = json['photoUrl'] as String
      ..imageName = json['imageName'] as String
      ..name = json['name'] as String
      ..percentageDone = (json['percentageDone'] as num).toInt()
      ..percentageTimeSpent = (json['percentageTimeSpent'] as num).toInt()
      ..deadline = json['deadline'] as String
      ..dateCreation = json['dateCreation'] as String;

Map<String, dynamic> _$TaskDetailPhotoResponseToJson(
        TaskDetailPhotoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'photoUrl': instance.photoUrl,
      'imageName': instance.imageName,
      'name': instance.name,
      'percentageDone': instance.percentageDone,
      'percentageTimeSpent': instance.percentageTimeSpent,
      'deadline': instance.deadline,
      'dateCreation': instance.dateCreation,
    };
