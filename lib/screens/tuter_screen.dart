import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_tuter/components/app_drawer.dart';
import 'package:project_tuter/constants.dart';
import 'package:project_tuter/widgets/chatBubble.dart';
import 'package:project_tuter/screens/settings_screen.dart';
import 'package:project_tuter/services/tts_voice_interface.dart';
import 'package:project_tuter/utils/audio_player_synthesis.dart';
import 'package:project_tuter/utils/speech_to_text_stt.dart';
import 'package:project_tuter/utils/text_to_speech_tts.dart';
import 'package:project_tuter/server/voice_service_synthesis.dart';
import 'package:project_tuter/widgets/round_button.dart';
import 'package:project_tuter/utils/gemini_service.dart';

class TuterScreen extends StatefulWidget {
  const TuterScreen({super.key});

  @override
  State<TuterScreen> createState() => _TuterScreenState();
}

class _TuterScreenState extends State<TuterScreen> {
  bool isListining = false;
  Color micColor = Colors.redAccent;
  String micStatus = "I'm not listing you";
  IconData micIcon = Icons.mic_off_outlined;

  // speech to text methods
  final SpeechToTextSTT _speechToTextSTT = SpeechToTextSTT();

  String _lastWords = '';

  String currentResponse = "";
  Timer? _debounce;

  // TTS voice services interface
  late TTSVoiceInterface _ttsVoiceInterface;

  // Global key for drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // text to audio synthesis converter
  VoiceServiceSynthesis voiceServicesSynthesis = VoiceServiceSynthesis();

  // audio player synthesis
  final AudioPlayerSynthesis _audioPlayerSynthesis = AudioPlayerSynthesis();

  // list view controller
  final ScrollController _scrollController = ScrollController();

  // chat data
  // 0 for ai
  // 1 for user
  List<Map<int, String>> chatData = [
    {0: "Hey Improve your grammer"},
  ];
  @override
  void initState() {
    super.initState();
    //loadTranslations("en");

    // initalize tts voice interface
    if (useOfflineTTS) {
      // ofline tts services
      _ttsVoiceInterface = TextToSpeechTTS();
    } else {
      // online text to voice synthesizer
      _ttsVoiceInterface = AudioPlayerSynthesis();
    }
  }

  // debouceCalls();

  void debouceCalls() {
    _debounce?.cancel();
    _debounce = Timer(Duration(seconds: 3), () async {
      String res = await askGemini(_lastWords);
      setState(() {
        currentResponse = res;
        // make scroll at end
        _scrollController.animateTo(
          chatData.length.toDouble() * 100,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeOutSine,
        );
        // add res to chat data
        chatData.add({0: res});
        // online service
        _ttsVoiceInterface.startSpeaking(currentResponse);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // App bar
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _scaffoldKey.currentState?.openDrawer();
                      });
                    },
                    icon: Icon(Icons.horizontal_split)),
                Spacer(),
                Text("Start Talking",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontStyle: FontStyle.normal,
                      fontFamily: "Ariel",
                      fontWeight: FontWeight.w700,
                    )),
                Spacer(),
                Tooltip(
                  message: "Swich Voice Type",
                  child: Switch.adaptive(
                      value: useOfflineTTS,
                      onChanged: (value) {
                        setState(() {
                          if (useOfflineTTS) {
                            useOfflineTTS = false;
                          } else {
                            useOfflineTTS = true;
                          }
                        });
                        // initalize tts voice interface
                        if (useOfflineTTS) {
                          // ofline tts services
                          _ttsVoiceInterface = TextToSpeechTTS();
                        } else {
                          // online text to voice synthesizer
                          _ttsVoiceInterface = AudioPlayerSynthesis();
                        }
                      }),
                ),
                PopupMenuButton(itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("Settings"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsScreen()));
                      },
                    ),
                    PopupMenuItem(child: Text("About Us")),
                  ];
                })
              ],
            ),
            Divider(),

            SizedBox(
              height: 10.0,
            ),
            // ui components

            SizedBox(
              height: 20.0,
            ),

            // chats
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                dragStartBehavior: DragStartBehavior.down,
                itemCount: chatData.length,
                itemBuilder: (BuildContext context, index) {
                  return Row(
                    mainAxisAlignment: chatData[index].keys.first == 0
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Chatbubble(
                        chatBubbleColor: chatData[index].keys.first == 0
                            ? const Color.fromARGB(255, 190, 210, 190)
                            : const Color.fromARGB(255, 218, 183, 195),
                        text: chatData[index].values.first,
                      ),
                    ],
                  );
                },
              ),
            ),

            // BottomBar()

            // bottom bar
            // BottomBar()
            Container(
              width: MediaQuery.of(context).size.width,
              // height: 80.0,
              padding: EdgeInsets.only(bottom: 6.0),
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RoundButton(
                    onClick: () {
                      // start speaking
                      _ttsVoiceInterface.rePlaySpeaking(currentResponse);
                    },
                    iconName: Icons.play_arrow_outlined,
                    title: "Speak",
                  ),
                  RoundButton(
                    onClick: () {
                      // stop speaking
                      _ttsVoiceInterface.stopSpeaking();
                    },
                    iconName: Icons.pause_circle_outline,
                    title: "Stop",
                  ),
                  RoundButton(
                    onClick: () {
                      updateUI();
                    },
                    iconName: Icons.mic,
                    iconSize: 42.0,
                    title: "Mic",
                    height: 72.0,
                    width: 60.0,
                  ),
                  RoundButton(
                    onClick: () {},
                    iconName: Icons.keyboard,
                    title: "Type",
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateUI() {
    if (isListining) {
      setState(() {
        isListining = false;
        micColor = Colors.redAccent;
        micStatus = "I'm not listing you";
        micIcon = Icons.mic_off_outlined;
        // _stopListening();
        _speechToTextSTT.stopListening();
      });
    } else {
      isListining = true;
      micColor = const Color.fromARGB(255, 241, 136, 14);
      micStatus = "I'm listing you";
      micIcon = Icons.mic_none_rounded;
      setState(() {});
      // _startListening();
      _speechToTextSTT.startListening(onSpeechResult: (String recognizedWord) {
        _lastWords = recognizedWord;

        setState(() {});
        updateIcon();
      });
    }
  }

  void updateIcon() {
    if (!_speechToTextSTT.isListening) {
      isListining = false;
      micColor = Colors.redAccent;
      micStatus = "I'm not listing you";
      micIcon = Icons.mic_off_outlined;
      setState(() {});
      // append conversion
      if (_lastWords != "") {
        chatData.add({1: _lastWords});
      }
      setState(() {
        // animate bubble and scroll it to end
        _scrollController.animateTo(
          chatData.length.toDouble() * 100,
          duration: Duration(milliseconds: 600),
          curve: Curves.fastOutSlowIn,
        );
      });
      debouceCalls();
    }
  }
}
