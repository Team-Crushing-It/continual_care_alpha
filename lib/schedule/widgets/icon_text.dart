import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    required this.icon,
    required this.text,
  }) : super();

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Icon(icon),
        ),
        Container(
          width: 170,
          child: Text(
            text,
            style: TextStyle(color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
      ],
    );
  }
}
