import 'package:flutter/material.dart';

class Chatbubble extends StatelessWidget {
  final Color chatBubbleColor;
  final String text;
  const Chatbubble({
    super.key,
    required this.chatBubbleColor,
    required this.text,
  });

  String get chatText => text;

  @override
  Widget build(BuildContext context) {
    // flexible make container srink and expand based on child value
    return Flexible(
      child: AnimatedContainer(
        constraints: BoxConstraints(
          minWidth: 50, // Minimum width
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ), // 80% of screen width), // Minimum width
        duration: Duration(seconds: 1),
        curve: Curves.easeInCubic,
        child: Container(
          margin: EdgeInsets.only(
            bottom: 10.0,
            left: 5.0,
            right: 5.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: chatBubbleColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text.trim(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
