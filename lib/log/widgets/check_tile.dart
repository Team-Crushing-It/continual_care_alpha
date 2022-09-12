import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CheckTile extends StatefulWidget {
  const CheckTile({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  State<CheckTile> createState() => _CheckTileState();
}

class _CheckTileState extends State<CheckTile> {
  bool? value = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 24,
            width: 24,
            child: Checkbox(
                value: value,
                onChanged: (bool) {
                  setState(() {
                    value = bool;
                  });
                  print(bool);
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Text(widget.text,
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }
}
