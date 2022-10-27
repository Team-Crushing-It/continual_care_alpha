import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.pressable,
  });

  final String title;
  final VoidCallback onPressed;
  final bool pressable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Container(
        width: 200,
        height: 32,
        child: pressable
            ? ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  title,
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
                  title,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              ),
      ),
    );
  }
}
