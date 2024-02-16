import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Duration _duration = const Duration(seconds: 0);
  Timer? _timer;
  bool _isRunning = false;
  bool _isPaused = false;
  bool _isReset = true;

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
      _isReset = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds > 0) {
        setState(() {
          _duration = _duration - const Duration(seconds: 1);
        });
      } else {
        _timer!.cancel();
        setState(() {
          _isRunning = false;
          _isPaused = false;
          _isReset = true;
        });
        print("Timer Complete");
      }
    });
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
      setState(() {
        _isRunning = false;
        _isPaused = true;
        _isReset = false;
      });
    }
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      if(!_isReset){
         _duration = const Duration(seconds: 0);
      }
      _isRunning = false;
      _isPaused = false;
      _isReset = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isRunning || _isPaused)
              Text(
                _duration.toString().split('.').first.padLeft(8, "0"),
                style: const TextStyle(fontSize: 40),
              )
            else
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hms,
                  initialTimerDuration: _duration,
                  onTimerDurationChanged: (Duration changedTimer) {
                    setState(() {
                      _duration = changedTimer;
                    });
                  },
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isRunning)
                  ElevatedButton(
                    onPressed: _duration.inSeconds > 0 ? _startTimer : null,
                    child: const Text('Start'),
                  ),
                if (_isRunning)
                  ElevatedButton(
                    onPressed: _pauseTimer,
                    child: const Text('Pause'),
                  ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}