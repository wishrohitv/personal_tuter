import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {
  final double height;
  final double width;
  final String? title;
  final Color? bgColor;
  final IconData? iconName;
  final IconData? stateIconName;
  final double? iconSize;
  final Function()? onClick;
  const RoundButton({
    super.key,
    this.height = 56.0,
    this.width = 56.0,
    this.title,
    this.bgColor = Colors.grey,
    this.iconName,
    this.stateIconName,
    this.iconSize,
    this.onClick,
  });

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          child: Ink(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(
                18.0,
              ),
            ),
            child: InkWell(
              splashColor: Colors.greenAccent,
              borderRadius: BorderRadius.circular(
                18.0,
              ),
              onTap: () {
                widget.onClick!();
              },
              child: Icon(
                widget.iconName ?? Icons.no_drinks,
                size: widget.iconSize ?? 28,
              ),
            ),
          ),
        ),
        widget.title != null ? Text(widget.title!) : Container()
      ],
    );
  }
}
