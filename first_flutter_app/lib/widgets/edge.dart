import 'package:flutter/material.dart';

class EdgeWidget extends StatefulWidget {
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
          Row(
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
              }, child: Text('Start')),
              ElevatedButton(onPressed: () {
                // Implement pause functionality
              }, child: Text('Pause')),
            ],
          )
        ],
      ),
    );
  }
}
