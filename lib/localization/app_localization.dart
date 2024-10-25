import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale? locale;
  AppLocalizations({
    this.locale,
  });

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;
  late Map<String, String> _defaultLocalizedStrings;

  Future loadJsonLanguage() async {
    String defaultJsonString =
        await rootBundle.loadString("lib/utils/languages/language_en.json");
    Map<String, dynamic> defaultJsonMap = json.decode(defaultJsonString);
    _defaultLocalizedStrings = defaultJsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    String jsonString = await rootBundle.loadString(
        "lib/utils/languages/language_${locale!.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) {
    String? translatedValue = _localizedStrings[key];

    if (translatedValue == null || translatedValue.isEmpty) {
      return _defaultLocalizedStrings[key] ?? "";
    }

    return translatedValue;
  }

  String translateWithArgs(String key, Map<String, dynamic> args) {
    String translation =
        _localizedStrings[key] ?? _defaultLocalizedStrings[key] ?? "";

    args.forEach((argKey, value) {
      translation = translation.replaceAll("{$argKey}", value.toString());
    });

    return translation;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.loadJsonLanguage();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

extension TranslateX on String {
  String translate(BuildContext context) {
    return AppLocalizations.of(context)!.translate(this);
  }
}

extension TranslateWithArg on String {
  String translateWithArg(BuildContext context, Map<String, dynamic> args) {
    return AppLocalizations.of(context)!.translateWithArgs(this, args);
  }
}
