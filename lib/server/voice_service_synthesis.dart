import 'dart:convert';
import 'dart:typed_data';
import 'package:project_tuter/constants.dart';

import 'package:http/http.dart' as http;

// const String X_USER_ID = "7vHdzWO2zITJN0L77kmm0t1wj8B2";
// const String AUTHORIZATION = "5c2e4b7971b3422cbb8e4d947b8d17e9";

// class VoiceServicesSynthesis {
//   AudioPlayerSynthesis audioPlayerSynthesis = AudioPlayerSynthesis();
//   var client = http.Client();
//   Future<void> convertTextToAudio(String input) async {
//     try {
//       var response = await client.post(
//         Uri.parse(
//           "https://api.play.ht/api/v2/tts/stream",
//         ),
//         headers: {
//           "X-USER-ID": X_USER_ID,
//           "AUTHORIZATION": AUTHORIZATION,
//           "accept": "audio/mpeg",
//           "content-type": "application/json"
//         },
//         body: utf8.encode(jsonEncode({
//           "text": input,
//           "voice_engine": "PlayDialog",
//           "voice":
//               "s3://voice-cloning-zero-shot/d9ff78ba-d016-47f6-b0ef-dd630f59414e/female-cs/manifest.json",
//           "output_format": "mp3"
//         })),
//       );

//       print(response.statusCode);
//       print(response.body);
//       if (response.statusCode == 200) {
//         audioPlayerSynthesis.playAudio(response.bodyBytes);
//       }
//     } catch (e) {
//       print(e);
//     } finally {
//       client.close();
//     }
//   }
// }

// void main() {
//   VoiceServicesSynthesis voiceServicesSynthesis = VoiceServicesSynthesis();
//   voiceServicesSynthesis.convertTextToAudio("hello guyes im from japan");
// }

// void main() async {
//   const userId = X_USER_ID;
//   const apiKey = AUTHORIZATION;

//   final headers = {
//     'X-USER-ID': userId,
//     'Authorization': apiKey, // Changed to standard header casing
//     'Accept': 'audio/mpeg', // Capitalized header name
//     'Content-Type': 'application/json', // Capitalized and exact media type
//   };

//   final payload = {
//     'text': 'Hello from a realistic voice.',
//     'voice_engine': 'PlayDialog',
//     'voice': 's3://voice-cloning-zero-shot/d9ff78ba-d016-47f6-b0ef-dd630f59414e/female-cs/manifest.json',
//     'output_format': 'mp3',
//   };

//   try {
//     final response = await http.post(
//       Uri.parse('https://api.play.ht/api/v2/tts/stream'),
//       headers: headers,
//       body: utf8.encode(json.encode(payload)), // Encode to bytes directly
//     );

//     if (response.statusCode == 200) {
//       final file = File('result.mp3');
//       await file.writeAsBytes(response.bodyBytes);
//       print('Audio file saved successfully as result.mp3');
//     } else {
//       print('Request failed with status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//   } catch (e) {
//     print('Error making request: $e');
//   }
// }

class VoiceServiceSynthesis {
  var client = http.Client();
  Map<String, String> headers = {
    'Authorization': 'Bearer $UNREAL_SPEECH_API_KEY',
    "Content-Type": "application/json",
  };

  Future<Uint8List> convertTextToAudio(String input) async {
    var response =
        await client.post(Uri.parse("https://api.v8.unrealspeech.com/stream"),
            headers: headers,
            body: utf8.encode(jsonEncode({
              "Text": input,
              "VoiceId": "Sierra",
              "Bitrate": "128k",
            })));

    late Uint8List outputBytes;
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      // var data = response.bodyBytes;
      // print(data);
      // final file = File('unreal_result.mp3');
      // await file.writeAsBytes(data);
      // print('Audio file saved successfully as result.mp3');
      outputBytes = response.bodyBytes;
    } else {
      print(response.statusCode);
      print(response.body);
      outputBytes = response.bodyBytes;
    }
    return outputBytes;
  }
}
