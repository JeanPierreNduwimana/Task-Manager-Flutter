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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S? current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current!;
    });
  } 

  static S? of(BuildContext context) {
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

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
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