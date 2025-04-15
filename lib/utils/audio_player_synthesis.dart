import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:project_tuter/server/voice_service_synthesis.dart';
import 'package:project_tuter/services/tts_voice_interface.dart';

class AudioPlayerSynthesis implements TTSVoiceInterface {
  final player = AudioPlayer();
  Uint8List? storeAudioBytes;
  final VoiceServiceSynthesis _voiceServiceSynthesis = VoiceServiceSynthesis();

  void playAudio(String input) async {
    final audioBytes = await _voiceServiceSynthesis.convertTextToAudio(input);
    storeAudioBytes = audioBytes;
    try {
      // Get the temporary directory
      // final tempDir = await getTemporaryDirectory();
      // final file = File('${tempDir.path}/temp_audio.mp3');
      // // Write bytes to the file
      // await file.writeAsBytes(audioBytes);

      await player.setSource(BytesSource(audioBytes));
      await player.resume();
    } catch (e) {
      print("Audio Player Error: $e");
    }
  }

  void replayAudioBytes(String input) async {
    try {
      if (storeAudioBytes != null) {
        await player.play(BytesSource(storeAudioBytes!));
        // await player.setSource(BytesSource(storeAudioBytes!));
        // await player.resume();
      } else {
        /// call the main funtion
        playAudio(input);
      }
    } catch (e) {
      print("Audio player error: $e");
    }
  }

  /// replayAudioBytes
  @override
  void startSpeaking(String input) async {
    playAudio(input);
  }

  /// replayAudioBytes
  @override
  void rePlaySpeaking(String input) {
    replayAudioBytes(input);
  }

  /// stop speaking
  @override
  void stopSpeaking() async {
    await player.stop();
  }
}
