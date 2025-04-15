import 'dart:async';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:project_tuter/constants.dart';

Future<String> askGemini(String prompt) async {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );
  Map<String, String> systermInstruction = {
    "role": "grammer/tuter",
    "work": "check user grammer and correct it",
    "response_length": "200 chars"
  };
  //String systemInstruction =
  //    "Your are ai assistant and check user's every senetence grammer and tell them their mistake and improved version of sentence too along with give his question's answar in small talk, and act like english teacher/personal tuter and your response must not be less than 150 charectors";

  final content = [
    Content.text(systermInstruction.toString()),
    Content.text(prompt)
  ];
  try {
    final response = await model.generateContent(content);
    print(response.usageMetadata);

    return response.text ?? "No response";
  } catch (e) {
    return "Something went wrong";
  }
}
