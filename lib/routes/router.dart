import 'package:flutter/material.dart';
import 'package:newsapp/routes/route_name.dart';
import 'package:newsapp/view/screens/dynamic/home_screen.dart';
import 'package:newsapp/view/screens/static/error_screen.dart';
import 'package:page_transition/page_transition.dart';

class RouterGenerate {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // home
      case RouteName.homeRoute:
        return myPrivateRoute(screen: MyHomeScreen(), transition: PageTransitionType.fade);

      // error
      default:
        return myPrivateRoute(screen: MyErrorScreen());
    }
  }
}

myPrivateRoute({required Widget screen, RouteSettings? args, PageTransitionType? transition, int? duration}) {
  return PageTransition(
    child: screen,
    settings: args,
    type: transition ?? PageTransitionType.rightToLeft,
    duration: Duration(milliseconds: duration ?? 500),
  );
}
