import 'package:flutter/material.dart';

class refrech extends PageRouteBuilder {
  late final Widget widget;
  refrech({
    required this.widget,
  }) : super(
            transitionDuration: Duration(milliseconds: 1),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
