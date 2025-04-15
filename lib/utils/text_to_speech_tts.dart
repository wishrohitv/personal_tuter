import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:project_tuter/constants.dart';
import 'package:project_tuter/services/tts_voice_interface.dart';

/// System's TTS service
class TextToSpeechTTS extends TTSVoiceInterface {
  /// This class enable system's voice tts service using flutter_tts package
  ///
  /// use carefully
  final FlutterTts _flutterTts = FlutterTts();
  List<Map> _voices = [];
  Map? _currentVoice;

  TextToSpeechTTS() {
    initTTS();
  }

  void initTTS() {
    _flutterTts.getVoices.then((data) {
      _voices = List<Map>.from(data);
      try {
        _voices =
            _voices.where((voice) => voice["name"].contains(language)).toList();
        _currentVoice = _voices.first;
      } catch (e) {
        debugPrint("VOICE ERROR: $e");
      }
    });
  }

  void setVoice(Map voice) {
    _flutterTts.setVoice(defaultVoice);
  }

  void speakInput(String input) {
    _flutterTts.speak(input);
  }

  /// start local tts services
  @override
  void startSpeaking(String input) {
    speakInput(input);
  }

  /// restartstart local tts services
  @override
  void rePlaySpeaking(String input) {
    speakInput(input);
  }

  /// manually stop local tts services
  @override
  void stopSpeaking() {
    _flutterTts.stop();
  }
}
