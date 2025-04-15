import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextSTT {
  // speech to text methods
  final stt.SpeechToText _speechToText = stt.SpeechToText();

  late bool speechEnabled = false;

  String? _recognizedText;

  SpeechToTextSTT() {
    _initiateSttService();
  }

  /// This has to happen only once per app
  void _initiateSttService() async {
    speechEnabled = await _speechToText.initialize();
  }

  /// Each time to start a speech recognition session
  /// return onSpeechResult callback and call getter to get result
  void startListening({required Function(String) onSpeechResult}) async {
    await _speechToText.listen(onResult: (SpeechRecognitionResult result) {
      String recognizedWord = result.recognizedWords;
      // send callback
      onSpeechResult(recognizedWord);
    });
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void stopListening() async {
    await _speechToText.stop();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    _recognizedText = result.recognizedWords;
  }

  String? get output => _recognizedText;
  bool get isListening => _speechToText.isListening;
}
