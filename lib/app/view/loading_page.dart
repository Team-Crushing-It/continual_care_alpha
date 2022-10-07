import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  static Page page() => const MaterialPage<void>(
        key: ValueKey('loading_page'),
        child: LoadingPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
