/*import 'package:flutter/material.dart';

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
*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';


class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  // Tracks the expansion state of each section
  final List<bool> _isExpanded = [false, false, false];
  bool _isTicking = false;

  @override
  void initState() {
    super.initState();
    _loadTickingPreference();
  }

  Future<void> _loadTickingPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isTicking = prefs.getBool('isTicking') ?? false;
    });
  }

  Future<void> _toggleTicking(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isTicking', index == 0);
    setState(() {
      _isTicking = index == 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFF3EDF6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildExpansionButton(0, 'Privacy', 'Our app respects your privacy by not collecting, storing, or sharing any personal data without your explicit consent. We only use anonymized data for app improvement purposes. For more information or to opt out, please contact our support team.'),
            _buildExpansionButton(1, 'Credits', '''-------- DEVELOPED BY --------\n''' 'SES Businesses\n\n' '''-------- PROGRAMMING --------\n''' 'Ethan\nSherwin\nSung'),
            _buildExpansionButton(2, 'Contact Us', 'sesbusinesses@gmail.com'),
            const SizedBox(height: 20),
            ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              labels: const ['Tick', 'Silent'],
              initialLabelIndex: _isTicking ? 0 : 1,
              onToggle: (index) {
                // Wrap the call to the asynchronous method inside an anonymous function
                if (index != null) { // Check for null to satisfy the null-safety requirement
                  _toggleTicking(index);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionButton(int index, String title, String description) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Smoother edge radius
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight, // Optional: if you want a different background color for the expanded area
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(description, style: TextStyle(color: Colors.black)),
            )
          ],
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded[index] = expanded;
            });
          },
          trailing: _isExpanded[index]
              ? Icon(Icons.arrow_drop_up, color: Theme.of(context).primaryColor)
              : Icon(Icons.arrow_drop_down, color: Theme.of(context).primaryColor),
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          childrenPadding: EdgeInsets.only(bottom: 10),
        ),
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
