import 'dart:async';

import 'package:flutter/material.dart';

class BaseDeBouncer {
  final int milliseconds;
  late VoidCallback action;
  Timer? _timer;

  BaseDeBouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}