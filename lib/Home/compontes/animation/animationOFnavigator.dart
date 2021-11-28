import 'package:flutter/material.dart';

class animation extends PageRouteBuilder {
  late final Widget widget;
  late final AxisDirection direction;
  animation({required this.widget, required this.direction})
      : super(
            transitionDuration: Duration(milliseconds: 250),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: getBeginOffst(),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  Offset getBeginOffst() {
    if (direction == AxisDirection.up) {
      return Offset(0, 1);
    }
    if (direction == AxisDirection.down) {
      return Offset(0, -1);
    }
    if (direction == AxisDirection.right) {
      return Offset(-1, 0);
    }
    return Offset(1, 0);
  }
}
