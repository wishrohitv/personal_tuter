import 'package:flutter/material.dart';
import 'package:project_tuter/widgets/round_button.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final TextEditingController _textEditingController = TextEditingController();
  bool showTextField = true;
  double textFieldHeight = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 80.0,
      padding: EdgeInsets.only(bottom: 6.0),
      color: Colors.transparent,
      child: Column(
        children: [
          // tool button
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundButton(
                onClick: () {
                  // start speaking
                  // _ttsVoiceInterface.rePlaySpeaking(currentResponse);
                },
                iconName: Icons.play_arrow_outlined,
                title: "Speak",
              ),
              RoundButton(
                onClick: () {
                  // stop speaking
                  // _ttsVoiceInterface.stopSpeaking();
                },
                iconName: Icons.pause_circle_outline,
                title: "Stop",
              ),
              RoundButton(
                onClick: () {
                  // updateUI();
                },
                iconName: Icons.mic,
                iconSize: 42.0,
                title: "Mic",
                height: 72.0,
                width: 60.0,
              ),
              RoundButton(
                onClick: () {
                  setState(() {
                    showTextField = showTextField ? false : true;
                    textFieldHeight = showTextField ? 0 : 65.0;
                  });
                },
                iconName: Icons.keyboard,
                title: "Type",
              )
            ],
          ),

          // text field
          textField()
          // showTextField ? textField() : Container(),
        ],
      ),
    );
  }

  Widget textField() {
    return AnimatedContainer(
      height: textFieldHeight,
      curve: Curves.easeOutCirc,
      duration: Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.abc),
                  labelText: "type here",
                ),
              ),
            ),
            IconButton(
              onPressed: () {
              },
              icon: Icon(Icons.send_outlined),
            )
          ],
        ),
      ),
    );
  }
}
