import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFF3EDF6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text('Settings'),
      ),
    );
  }
}

void showSettingsPanel(BuildContext context, AnimationController controller) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: const SettingsWidget(),
      );
    },
  ).then((_) {
    // Reset the animation when the dialog is closed.
    controller.reverse(from: 1.0);
  });
}

