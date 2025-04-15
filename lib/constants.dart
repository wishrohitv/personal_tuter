const int GEMINI_CHAR_LIMIT = 2000;
const int UNREAL_SPEECH_CHAR_LIMIT = 2000;
String sample =
    """Introducing yourself to someone in a professional setting can be tricky, especially when facing an interview. Irrespective of your qualifications and experience, your way of self-introduction during an interview carries much weight when it comes to making a strong impression.
As soon as you enter the room, exchange pleasantries and introduce yourself by saying your name. Keep this introduction short and concise before you go into detail when the interview starts.""";

// gemini api key
const apiKey = "AIzaSyC14KP5zEvd9Y6YPdEnQLh_h4kO0TisXX8";

// play.ht api keys
const String X_USER_ID = "";
const String AUTHORIZATION = "";

const String UNREAL_SPEECH_API_KEY = "";

String language = "en";

Map<String, String> defaultVoice = {
  "name": "hi-in-x-hia-local",
  "locale": "hi-IN"
};

String appDetaultLanguage = "en";

bool useOfflineTTS = true;

// // load translations
// void loadTranslations() {
//   var currentPath = Directory.current;
//   final File translationsFile =
//       File("${currentPath.path}lib/translations/$language.json");
//   Map translationData = jsonDecode(translationsFile.readAsStringSync());
//   print(translationData);
// }

// void loadTranslations(String language) {
//   var currentPath = Directory.current.path;
//   final String filePath = p.join(currentPath, "lib", "translations", "$language.json");
//   final File translationsFile = File(filePath);

//   if (!translationsFile.existsSync()) {
//     print("Translation file not found: $filePath");
//     return;
//   }

//   try {
//     String jsonString = translationsFile.readAsStringSync();
//     Map<String, dynamic> translationData = jsonDecode(jsonString);
//     print(translationData);
//   } catch (e) {
//     print("Error reading translation file: $e");
//   }
// }
