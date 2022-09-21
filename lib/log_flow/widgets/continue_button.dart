import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
    required this.onPressed,
    required this.pressable,
  });

  final VoidCallback onPressed;
  final bool pressable;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 32,
      child: pressable
          ? ElevatedButton(
              onPressed: onPressed,
              child: Text(
                'Continue',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                side: BorderSide.none,
                backgroundColor: Color(0xffD00404),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            )
          : OutlinedButton(
              onPressed: null,
              child: Text(
                'Continue',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
            ),
    );
  }
}
