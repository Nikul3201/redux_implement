import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux_implement/main.dart';

class Routers {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/postBookData':
        return MaterialPageRoute(builder: (_) => postBookDataScreen());
      default:
        return MaterialPageRoute(builder: (_) => MyHomePage());
    }
  }
}