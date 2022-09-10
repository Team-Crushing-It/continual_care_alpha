import 'package:flutter/widgets.dart';

class SlideRightPage<T> extends Page<T> {
  const SlideRightPage({required this.child, LocalKey? key}) : super(key: key);

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return child;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-0.5, 0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
