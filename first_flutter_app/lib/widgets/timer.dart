import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
  bool _isTicking = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _originalDuration = const Duration(seconds: 0);

  void _playClickSound() async {
    await _audioPlayer.play(AssetSource('audio/click.mp3'));
  }

  void _startTimer() {
    if (_isReset) {
      _originalDuration = _duration;
    }
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
        if (_isTicking) _playClickSound();
      } else {
        _timer!.cancel();
        setState(() {
          _isRunning = false;
          _isPaused = false;
          _isReset = true;
        });
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
    _originalDuration = const Duration(seconds: 0);
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

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    if (duration.inHours > 0) {
      final hours = twoDigits(duration.inHours);
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return "$hours:$minutes:$seconds";
    }
    else {
      final minutes = twoDigits(duration.inMinutes);
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return "$minutes:$seconds";
    }
  }

  double _getProgress() {
    if (_originalDuration.inSeconds == 0) {
      return 0;
    }
    return 1 - _duration.inSeconds / _originalDuration.inSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edge Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (_isRunning || _isPaused)
              Text(
                formatDuration(_duration), 
                style: const TextStyle(fontSize: 40)
              ),
            if (_isRunning || _isPaused)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: LinearProgressIndicator(
                      value: _getProgress(),
                      minHeight: 20,
                    ),
                  ),
                ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Reset'),
                ),
              ],
            ),
            ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              labels: const ['Tick', 'Silent'],
              initialLabelIndex: _isTicking ? 0 : 1,
              onToggle: (index) {
                setState(() {
                  _isTicking = !_isTicking;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}