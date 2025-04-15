import 'dart:convert';
import 'package:flutter/services.dart';

// Supported app languages
List<Map<String, String>> appLang = [
  {"en": "English"},
  {"hi": "हिन्दी (Hindī)"},
  {"ta": "தமிழ் (Tamiḻ)"},
  {"te": "తెలుగు (Telugu)"},
  {"bn": "বাংলা (Bāŋlā)"},
  {"kn": "ಕನ್ನಡ (Kannađa)"},
  {"ma": "മലയാളം (Malayāļã)"},
  {"or": "ଓଡ଼ିଆ (Odia)"},
  {"pa": "ਪੰਜਾਬੀ (Pãjābī)"},
  {"ne": "नेपाली भाषा (Nepālī)"},
  {"ja": "日本語 (Nihongo)"},
  {"vi": "tiếng Việt"},
  {"ru": "Русский (Russian)"},
];

Future<Map<dynamic, dynamic>> loadTranslations(String language) async {
  try {
    String jsonString =
        await rootBundle.loadString('lib/translations/$language.json');
    print(jsonDecode(jsonString));
    return jsonDecode(jsonString);
  } catch (e) {
    print("Error loading translation file: $e");
    return {};
  }
}

Future<Map> appLanguage(String appLanguage) async {
  Map<dynamic, dynamic> translation = await loadTranslations(appLanguage);
  return translation;
}
