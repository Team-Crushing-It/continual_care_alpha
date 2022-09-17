import 'package:flutter/material.dart';

class CaregiverPage extends StatelessWidget {
  const CaregiverPage({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage<void>(child: CaregiverPage());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Caregiver page')
    );
  }
}
