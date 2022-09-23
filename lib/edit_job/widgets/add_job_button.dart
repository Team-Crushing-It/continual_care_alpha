import 'package:flutter/material.dart';

class AddJobButton extends StatelessWidget {
  const AddJobButton({
    super.key,
    required this.onPressed,
    required this.pressable,
  });

  final VoidCallback onPressed;
  final bool pressable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Container(
        width: 160,
        height: 32,
        child: pressable
            ? ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  'Add Job',
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
                  'Add Job',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              ),
      ),
    );
  }
}
