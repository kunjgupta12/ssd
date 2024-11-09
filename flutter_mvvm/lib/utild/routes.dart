import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utild/routes_name.dart';
import 'package:flutter_mvvm/view/home_screen.dart';
import 'package:flutter_mvvm/view/login.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
   case RouteName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());
     default:
        return MaterialPageRoute(builder: (_) {return Scaffold(
          body: Center(child:Text('No route defined')),
        );});
    }
  }
}
