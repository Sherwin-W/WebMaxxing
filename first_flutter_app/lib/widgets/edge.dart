import 'package:first_flutter_app/widgets/timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EdgeWidget extends StatefulWidget {
  const EdgeWidget({super.key});

  @override
  _EdgeWidgetState createState() => _EdgeWidgetState();
}

class _EdgeWidgetState extends State<EdgeWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TimerScreen()
    );
  }
}
