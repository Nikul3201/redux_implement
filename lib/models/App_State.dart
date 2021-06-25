
import 'dart:convert';

import 'package:redux_implement/models/bookState.dart';

class AppState {
  BookState bookState;

  AppState({this.bookState});

  dynamic toJson() => {
    'bookState': bookState
  };

  @override
  String toString() {
    return 'AppState : ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}