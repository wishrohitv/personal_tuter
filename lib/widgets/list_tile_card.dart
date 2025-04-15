import 'package:flutter/material.dart';

class ListTileCard extends StatelessWidget {
  final String titleText;
  final String duration;
  final Function? onClick;
  const ListTileCard({super.key, required this.titleText, required this.duration, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ColoredBox(
        color: const Color.fromARGB(137, 104, 119, 127),
        child: ListTile(
          title: Text(titleText),
          trailing: Text(duration),
          onTap: (){
            onClick;
          },
        ),
      ),
    );
  }
}
