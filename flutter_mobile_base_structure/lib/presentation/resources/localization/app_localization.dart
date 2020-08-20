import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppLocalizations {
  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  AppLocalizations(Locale locale) {
    this.locale = locale;
    _localisedValues = null;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appTranslations = AppLocalizations(locale);
    String jsonContent =
        await rootBundle.loadString("assets/jsons/localization_en.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLanguage => locale.languageCode;

  String text(String key) {
    return _localisedValues[key] ?? "$key not found";
  }

  static final List<String> supportedLanguagesCodes = ["en"];

  static Iterable<Locale> supportedLanguages() =>
      supportedLanguagesCodes.map<Locale>((lengCode) => Locale(lengCode, ""));

  // defined text
  String get appName => text('app_name');
  String get touchidButton => text('button_label_touchid');
  String get faceidButton => text('button_label_faceid');
  String get loginButton => text('button_label_login');
  String get registerButton => text('button_label_register');
  String get guideButton => text('button_label_guide');

  String get registerInputFullname => text('register_input_fullname');
  String get registerInputNickname => text('register_input_nickname');

  String get registerInputPhone => text('register_input_phone_number');
  String get next => text('next_button');
  String get loginFaceid => text('login_faceid');

  String get username => text('login_username');
  String get password => text('login_password');
  String get inputUsername => text('login_input_username');
  String get inputPassword => text('login_input_password');
  String get rememeberLoginWelcomeMsg => text('remember_login_welcome_message');
  String get notMeButton => text('not_me_button');
  String get loginByAnotherAccount => text('login_by_another_account');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale newLocale;

  const AppLocalizationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLanguagesCodes
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
