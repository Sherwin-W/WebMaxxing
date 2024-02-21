import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

enum AppTheme {
  light,
  dark,
}

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  final List<bool> _isExpanded = [false, false, false];
  bool _isTicking = false;
  bool isDarkTheme = false;

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

  void applyTheme(AppTheme theme) {
    // This method will be used to apply the theme.
    // You might broadcast an event or call setState to trigger the theme change.
    // Actual implementation will depend on how your app is structured.
  }

    Future<void> _setThemePreference(AppTheme theme) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('themePreference', theme.index);
      await prefs.setBool('isDarkTheme', isDarkTheme);
      applyTheme(theme); // Make sure this method correctly applies the theme
    }

  Widget _buildThemeToggle() {
    return ToggleSwitch(
      minWidth: 90.0,
      cornerRadius: 20.0,
      activeBgColors: [
        const [Colors.lightBlueAccent],
        [Colors.grey.shade600],
      ],
      labels: const ['Light', 'Dark'],
      onToggle: (index) {
        if (index != null) {
          _setThemePreference(AppTheme.values[index]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3EDF6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            // Expansion buttons...
            _buildExpansionButton(0, 'Privacy', 'Our app respects your privacy...'),
            _buildExpansionButton(1, 'Credits', '-------- DEVELOPED BY --------\nSES Businesses...'),
            _buildExpansionButton(2, 'Contact Us', 'sesbusinesses@gmail.com'),
            const SizedBox(height: 20),
            ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              labels: const ['Tick', 'Silent'],
              initialLabelIndex: _isTicking ? 0 : 1,
              onToggle: (index) {
                if (index != null) {
                  _toggleTicking(index);
                }
              },
            ),
            const SizedBox(height: 20),
            _buildThemeToggle(), // Corrected method call
            const SizedBox(height: 20),
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
          tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
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
          childrenPadding: const EdgeInsets.only(bottom: 10),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight, // Optional: if you want a different background color for the expanded area
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(description, style: const TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  void showSettingsPanel(BuildContext context, AnimationController controller) {
    showDialog(
      context: context,
      barrierDismissible: true, // Ensure this is true
      builder: (BuildContext context) {
        // Wrap in GestureDetector to capture taps outside the SettingsWidget
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(), // Dismiss the dialog
          behavior: HitTestBehavior.opaque, // Ensure it captures all taps in the area
          child: const Dialog(
            backgroundColor: Colors.transparent,
            child: SettingsWidget(),
          ),
        );
      },
    ).then((_) {
      // Reset the animation when the dialog is closed.
      controller.reverse(from: 1.0);
    });
  }
}

void showSettingsPanel(BuildContext context, [AnimationController? controller]) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // This allows the dialog to be dismissed by tapping outside of it.
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withOpacity(0.5), // Semi-transparent barrier color, adjust opacity as needed.
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
      // Wrap the SettingsWidget in a Container with margin to ensure it doesn't stretch to the screen edges.
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24), // Adds margin around the SettingsWidget
          child: const Material(
            type: MaterialType.transparency,
            child: SettingsWidget(), // Your SettingsWidget here.
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      // Apply any desired animations here. For simplicity, a FadeTransition is used.
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child,
      );
    },
  ).then((_) {
    // If there's a controller and you want to reverse the animation or perform cleanup, do it here.
    if (controller != null) {
      controller.reverse(from: 1.0);
    }
  });
}

