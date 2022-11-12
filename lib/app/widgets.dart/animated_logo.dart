import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 800,
        height: 600,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 18, color: const Color(0xff2A3066))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Container(
                width: 750,
                child: const RiveAnimation.asset('assets/animation_light.riv'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                width: 655,
                child: Image.asset('assets/logo_light.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
