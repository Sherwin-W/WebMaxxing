import 'package:flutter/material.dart';

class EdgeWidget extends StatefulWidget {
  const EdgeWidget({super.key});

  @override
  _EdgeWidgetState createState() => _EdgeWidgetState();
}

class _EdgeWidgetState extends State<EdgeWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Hours'),
              Text('Minutes'),
              Text('Seconds'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(onPressed: () {
                // Implement start functionality
              }, child: const Text('Start')),
              ElevatedButton(onPressed: () {
                // Implement pause functionality
              }, child: const Text('Pause')),
            ],
          )
        ],
      ),
    );
  }
}
