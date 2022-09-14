import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CheckTile extends StatelessWidget {
  const CheckTile({
    Key? key,
    required this.text,
    required this.onTap,
    this.isChecked = false,
  }) : super(key: key);

  final String text;
  final bool isChecked;
  final Function(bool? value) onTap;

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
            child: Checkbox(value: isChecked, onChanged: onTap),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text,
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }
}
