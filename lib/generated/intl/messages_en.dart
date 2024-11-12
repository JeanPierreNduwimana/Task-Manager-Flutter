// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(taskName) => "The task ${taskName} is deleted 🔪";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "BadCredentialsException": MessageLookupByLibrary.simpleMessage(
            "Invalid password. Please try again"),
        "Empty": MessageLookupByLibrary.simpleMessage("Task name is empty"),
        "Existing":
            MessageLookupByLibrary.simpleMessage("Task name already exists"),
        "InternalAuthenticationServiceException":
            MessageLookupByLibrary.simpleMessage(
                "User not found. Please sign up"),
        "PasswordTooShort":
            MessageLookupByLibrary.simpleMessage("Your password is too short"),
        "SamePassword":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "TooShort":
            MessageLookupByLibrary.simpleMessage("Task name is too short"),
        "UnkownError": MessageLookupByLibrary.simpleMessage("Unknown error"),
        "UsernameAlreadyTaken":
            MessageLookupByLibrary.simpleMessage("User already exists"),
        "UsernameTooShort": MessageLookupByLibrary.simpleMessage(
            "The chosen name is too short"),
        "addTask": MessageLookupByLibrary.simpleMessage("Add a task"),
        "confirmpassword":
            MessageLookupByLibrary.simpleMessage("Confirm your password"),
        "connection": MessageLookupByLibrary.simpleMessage("Log In"),
        "connectionError": MessageLookupByLibrary.simpleMessage(
            "Sorry, no connection 😟 \n Please check your network"),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "createTask": MessageLookupByLibrary.simpleMessage("Create your task"),
        "deconnexion": MessageLookupByLibrary.simpleMessage("Log Out"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deletedTaskMessage": m0,
        "emptyfields":
            MessageLookupByLibrary.simpleMessage("No field can be empty ☹"),
        "errorUploadImage": MessageLookupByLibrary.simpleMessage(
            "The server didn\'t like this image, try another one and it will work, promise 😉"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "inscription": MessageLookupByLibrary.simpleMessage("Register"),
        "loadindTaskList":
            MessageLookupByLibrary.simpleMessage("Loading your tasks..."),
        "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
        "noTask": MessageLookupByLibrary.simpleMessage("No tasks available"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "progression": MessageLookupByLibrary.simpleMessage("Progression"),
        "reload": MessageLookupByLibrary.simpleMessage("Reload"),
        "taskDetail": MessageLookupByLibrary.simpleMessage("Task Detail"),
        "taskName": MessageLookupByLibrary.simpleMessage("Task Name"),
        "taskUpdatedMessage":
            MessageLookupByLibrary.simpleMessage("Task is updated 👌"),
        "timeUsed": MessageLookupByLibrary.simpleMessage("Time Used"),
        "updateProgression":
            MessageLookupByLibrary.simpleMessage("Update Progression"),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "vipredirect": MessageLookupByLibrary.simpleMessage("Direct access..."),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome")
      };
}
