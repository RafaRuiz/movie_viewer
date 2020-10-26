import 'dart:async';

import 'package:flutter/material.dart';

/// A Debouncer works very well when listening to
/// TextController events. It lets wait until the
/// user has stopped typing so we get only one
/// value instead of every single change and we
/// can perform, for example, HTTP calls with that
/// value.

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}