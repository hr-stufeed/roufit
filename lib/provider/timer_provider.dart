import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

const btnStart = 'start';
const btnStop = 'stop';

class TimerProvider with ChangeNotifier {
  List<Map<int, String>> routineList = [];
  String playBtn = btnStart;
  Map<int, String> selectRoutine = {};
  Timer _timer;
  Duration _routineTimer = Duration(seconds: 0);

  Duration get routineTimer => _routineTimer;

  timerState() {
    switch (playBtn) {
      case btnStart:
        timerStart();
        break;
      case btnStop:
        timerStop();
        break;
    }
  }

  timerStop() {
    playBtn = btnStart;
    _timer.cancel();
  }

  timerStart() {
    playBtn = btnStop;
    _routineTimer = Duration(seconds: 0);
    if(_timer.runtimeType != Null){
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
  }

  _tick(Timer timer) {
    _routineTimer += Duration(seconds: 1);
    notifyListeners();
  }
}

