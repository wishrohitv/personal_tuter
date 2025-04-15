import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:project_tuter/constants.dart';

class TextToVoice extends StatefulWidget {
  const TextToVoice({super.key});

  @override
  State<TextToVoice> createState() => _TextToVoiceState();
}

class _TextToVoiceState extends State<TextToVoice> {
  Map? _currentVoice;
  final FlutterTts _flutterTts = FlutterTts();
  List<Map> _voices = [];

  int? _currentWordStart, _currentWordEnd;

  @override
  void initState() {
    super.initState();
    initTTS();
  }

  void initTTS() {
    _flutterTts.setProgressHandler(
      (text, start, end, word) {
        setState(() {
          _currentWordStart = start;
          _currentWordEnd = end;
        });
      },
    );
    _flutterTts.getVoices.then((data) {
      try {
        _voices = List<Map>.from(data);
        setState(() {
          _voices =
              _voices.where((voice) => voice["name"].contains("en")).toList();
          _currentVoice = _voices.first;
          // print("CURRENTVOICE: $_currentVoice");
          setVoice(_currentVoice!);
        });

        // print("VOICES: $_voices");
      } catch (e) {
        print("ERROR: $e");
      }
    });
  }

  void setVoice(Map voice) {
    _flutterTts.setVoice({"name": "hi-in-x-hia-local", "locale": "hi-IN"});
    // _flutterTts.setVoice({"name": voice["name"], "locale": voice["locale"]});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  _flutterTts.speak(sample);
                  _currentWordStart = null;
                  _currentWordEnd = null;
                },
                icon: Icon(Icons.person_search)),
            IconButton(
              onPressed: () {
                _flutterTts.stop();
              },
              icon: Icon(Icons.stop),
              color: Colors.red,
            ),
          ],
        ),

        // speaker selector
        DropdownButton(
            value: _currentVoice,
            items: _voices
                .map((voice) =>
                    DropdownMenuItem(value: voice, child: Text(voice["name"])))
                .toList(),
            onChanged: (selectedVoice) {
              _flutterTts.setVoice({
                "name": selectedVoice!["name"],
                "locale": selectedVoice["locale"]
              });
              print(selectedVoice);
              setState(() {
                _currentVoice!.addAll({
                  "name": selectedVoice["name"],
                  "locale": selectedVoice["locale"]
                });
              });
            }),

        // rich text
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 20, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: sample.substring(
                  0,
                  _currentWordStart,
                ),
              ),
              if (_currentWordStart != null)
                TextSpan(
                    text: sample.substring(
                      _currentWordStart!,
                      _currentWordEnd,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.pinkAccent,
                    )),
              if (_currentWordEnd != null)
                TextSpan(
                  text: sample.substring(_currentWordEnd!),
                ),
            ],
          ),
        ),
        // Expanded(
        //   child: TextField(
        //     controller: _textEditingController,
        //   ),
        // )
      ],
    );
  }
}
