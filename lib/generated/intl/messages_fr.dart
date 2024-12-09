// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(taskName) => "La tache ${taskName} est supprimé 🔪";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "BadCredentialsException": MessageLookupByLibrary.simpleMessage(
            "Mot de passe invalide. Essayer de nouveau"),
        "Empty":
            MessageLookupByLibrary.simpleMessage("Nom de la tâche est vide"),
        "Existing": MessageLookupByLibrary.simpleMessage(
            "Nom de la tâche  existe déjà️"),
        "InternalAuthenticationServiceException":
            MessageLookupByLibrary.simpleMessage(
                "Utilisateur inexistant veuillez vous inscrire"),
        "PasswordTooShort": MessageLookupByLibrary.simpleMessage(
            "Votre mot de passe est trop court"),
        "SamePassword": MessageLookupByLibrary.simpleMessage(
            "Mot de passes ne corresponds pas"),
        "TooShort": MessageLookupByLibrary.simpleMessage(
            "Nom de la tâche  est trop court️"),
        "UnkownError": MessageLookupByLibrary.simpleMessage("Erreur inconnu"),
        "UsernameAlreadyTaken":
            MessageLookupByLibrary.simpleMessage("Utilisateur existe deja"),
        "UsernameTooShort": MessageLookupByLibrary.simpleMessage(
            "Le nom choisi est trop court"),
        "addTask": MessageLookupByLibrary.simpleMessage("Ajout une tache"),
        "confirmpassword":
            MessageLookupByLibrary.simpleMessage("Confirme ton mot de passe"),
        "connection": MessageLookupByLibrary.simpleMessage("Se Connecter"),
        "connectionError": MessageLookupByLibrary.simpleMessage(
            "Désolé il n\'y a pas de connection 😣 \n Veuillez vérifiez votre réseau"),
        "create": MessageLookupByLibrary.simpleMessage("Créer"),
        "createTask": MessageLookupByLibrary.simpleMessage("Créér votre tâche"),
        "deconnexion": MessageLookupByLibrary.simpleMessage("Déconnexion"),
        "deletedTaskMessage": m0,
        "emptyfields": MessageLookupByLibrary.simpleMessage(
            "Aucun des champs ne peut être vide ☹"),
        "errorUploadImage": MessageLookupByLibrary.simpleMessage(
            "Le serveur n\'a pas aimé cette image, essayer avec une autre et ca marchera, promis 😉"),
        "hardDelete":
            MessageLookupByLibrary.simpleMessage("Supprimer (Hard Delete)"),
        "home": MessageLookupByLibrary.simpleMessage("Accueil"),
        "inscription": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
        "loadindTaskList":
            MessageLookupByLibrary.simpleMessage("chargement de vos taches..."),
        "loading": MessageLookupByLibrary.simpleMessage("Chargement..."),
        "noTask":
            MessageLookupByLibrary.simpleMessage("Aucune tache disponible"),
        "password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "progression": MessageLookupByLibrary.simpleMessage("Progression"),
        "reload": MessageLookupByLibrary.simpleMessage("Recharger"),
        "softDelete":
            MessageLookupByLibrary.simpleMessage("Supprimer (Soft Delete)"),
        "taskDetail":
            MessageLookupByLibrary.simpleMessage("Consultation de tache"),
        "taskName": MessageLookupByLibrary.simpleMessage("Nom de la tache"),
        "taskUpdatedMessage":
            MessageLookupByLibrary.simpleMessage("La tache est mise à jour 👌"),
        "timeUsed": MessageLookupByLibrary.simpleMessage("Temps utilisé"),
        "updateProgression":
            MessageLookupByLibrary.simpleMessage("Mise à jour de progression"),
        "username": MessageLookupByLibrary.simpleMessage("nom d\'utilisateur"),
        "vipredirect": MessageLookupByLibrary.simpleMessage(
            "Patientez, vous allez être rediriger..."),
        "welcome": MessageLookupByLibrary.simpleMessage("Bienvenue")
      };
}
