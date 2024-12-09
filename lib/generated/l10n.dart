// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Log In`
  String get connection {
    return Intl.message(
      'Log In',
      name: 'connection',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get inscription {
    return Intl.message(
      'Register',
      name: 'inscription',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get deconnexion {
    return Intl.message(
      'Log Out',
      name: 'deconnexion',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get confirmpassword {
    return Intl.message(
      'Confirm your password',
      name: 'confirmpassword',
      desc: '',
      args: [],
    );
  }

  /// `Loading your tasks...`
  String get loadindTaskList {
    return Intl.message(
      'Loading your tasks...',
      name: 'loadindTaskList',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Task Detail`
  String get taskDetail {
    return Intl.message(
      'Task Detail',
      name: 'taskDetail',
      desc: '',
      args: [],
    );
  }

  /// `Time Used`
  String get timeUsed {
    return Intl.message(
      'Time Used',
      name: 'timeUsed',
      desc: '',
      args: [],
    );
  }

  /// `Progression`
  String get progression {
    return Intl.message(
      'Progression',
      name: 'progression',
      desc: '',
      args: [],
    );
  }

  /// `Update Progression`
  String get updateProgression {
    return Intl.message(
      'Update Progression',
      name: 'updateProgression',
      desc: '',
      args: [],
    );
  }

  /// `Soft Delete`
  String get softDelete {
    return Intl.message(
      'Soft Delete',
      name: 'softDelete',
      desc: '',
      args: [],
    );
  }

  /// `Hard Delete`
  String get hardDelete {
    return Intl.message(
      'Hard Delete',
      name: 'hardDelete',
      desc: '',
      args: [],
    );
  }

  /// `Create your task`
  String get createTask {
    return Intl.message(
      'Create your task',
      name: 'createTask',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Direct access...`
  String get vipredirect {
    return Intl.message(
      'Direct access...',
      name: 'vipredirect',
      desc: '',
      args: [],
    );
  }

  /// `No field can be empty ☹`
  String get emptyfields {
    return Intl.message(
      'No field can be empty ☹',
      name: 'emptyfields',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `User not found. Please sign up`
  String get InternalAuthenticationServiceException {
    return Intl.message(
      'User not found. Please sign up',
      name: 'InternalAuthenticationServiceException',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password. Please try again`
  String get BadCredentialsException {
    return Intl.message(
      'Invalid password. Please try again',
      name: 'BadCredentialsException',
      desc: '',
      args: [],
    );
  }

  /// `User already exists`
  String get UsernameAlreadyTaken {
    return Intl.message(
      'User already exists',
      name: 'UsernameAlreadyTaken',
      desc: '',
      args: [],
    );
  }

  /// `The chosen name is too short`
  String get UsernameTooShort {
    return Intl.message(
      'The chosen name is too short',
      name: 'UsernameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Your password is too short`
  String get PasswordTooShort {
    return Intl.message(
      'Your password is too short',
      name: 'PasswordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Task name is empty`
  String get Empty {
    return Intl.message(
      'Task name is empty',
      name: 'Empty',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get SamePassword {
    return Intl.message(
      'Passwords do not match',
      name: 'SamePassword',
      desc: '',
      args: [],
    );
  }

  /// `Task name already exists`
  String get Existing {
    return Intl.message(
      'Task name already exists',
      name: 'Existing',
      desc: '',
      args: [],
    );
  }

  /// `Task name is too short`
  String get TooShort {
    return Intl.message(
      'Task name is too short',
      name: 'TooShort',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get UnkownError {
    return Intl.message(
      'Unknown error',
      name: 'UnkownError',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, no connection 😟 \n Please check your network`
  String get connectionError {
    return Intl.message(
      'Sorry, no connection 😟 \n Please check your network',
      name: 'connectionError',
      desc: '',
      args: [],
    );
  }

  /// `No tasks available`
  String get noTask {
    return Intl.message(
      'No tasks available',
      name: 'noTask',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get reload {
    return Intl.message(
      'Reload',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `Add a task`
  String get addTask {
    return Intl.message(
      'Add a task',
      name: 'addTask',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `The server didn't like this image, try another one and it will work, promise 😉`
  String get errorUploadImage {
    return Intl.message(
      'The server didn\'t like this image, try another one and it will work, promise 😉',
      name: 'errorUploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Task is updated 👌`
  String get taskUpdatedMessage {
    return Intl.message(
      'Task is updated 👌',
      name: 'taskUpdatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `The task {taskName} is deleted 🔪`
  String deletedTaskMessage(Object taskName) {
    return Intl.message(
      'The task $taskName is deleted 🔪',
      name: 'deletedTaskMessage',
      desc: '',
      args: [taskName],
    );
  }

  /// `Task Name`
  String get taskName {
    return Intl.message(
      'Task Name',
      name: 'taskName',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
