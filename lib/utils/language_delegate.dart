import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocale{
  final Locale? locale;

  AppLocale(this.locale);

  Map<String,String>? _loadedLocalizedValues;

  static AppLocale of(BuildContext context){
    return Localizations.of(context, AppLocale);
  }

  Future loadLanguage()async{
    String _langFile = await rootBundle.loadString('assets/lang/${locale!.languageCode}.json');
    Map<String, dynamic> _loadedValues = jsonDecode(_langFile);
    _loadedLocalizedValues = _loadedValues.map((key, value) => MapEntry(key, value.toString()));
  }

  String? getTranslated(String key){
    return _loadedLocalizedValues?[key];
  }

  bool get isEnLocale => locale!.languageCode == 'en';

  bool get isArLocale => locale!.languageCode == 'ar';

  bool get isUrLocale => locale!.languageCode == 'ur';

  bool get isFilLocale => locale!.languageCode == 'fil';

  String get currentCode => locale!.languageCode;

  static const LocalizationsDelegate<AppLocale> delegate = _AppLocalDelegate();
}

class _AppLocalDelegate extends LocalizationsDelegate<AppLocale>{

  const _AppLocalDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','ar','ur','fil'].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async{
    AppLocale appLocale = AppLocale(locale);
    await appLocale.loadLanguage();
    return appLocale;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocale> old) {
    return false;
  }

}