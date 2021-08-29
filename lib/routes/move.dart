import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

replaceTo(context, {required Widget screen, Object? arguments, required String name}) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
      settings: RouteSettings(
        arguments: arguments,
        name: name,
      ),
    ),
  );
}

moveTo(context, {required Widget screen, Object? arguments, required String name}) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
      settings: RouteSettings(
        arguments: arguments,
        name: name,
      ),
    ),
  );
}

returnTo(context) {
  return Navigator.pop(context);
}
